# ------------------------------------------------------------------------------
#
#   Helpers for wrapping python packages
#
# ------------------------------------------------------------------------------

# Dispatch table for functional interface inner workers.
# Populated by defineFunctionalClassMethod; looked up at call time by the generic.
# This is a global variable that is used to store the inner workers for the functional interface.
# It is used to dispatch to the correct inner worker function based on the class of the object.
# Key: "<genericName>_<className>", Value: inner worker function to call the Python method on the instance.
# The key is the generic name and the class name.
# The inner worker function is a function that takes an instance and ... as arguments and calls the Python method on the instance.
# Example:
# .functionalMethodDispatch
#  ├── synGetAcl      → function(instance, ...) # calls the Python method on the instance
#  └── ...
#
.functionalMethodDispatch <- new.env(parent = emptyenv())

# Lazily cached gateway module — imported once, reused everywhere.
.gateway <- NULL
.getGateway <- function() {
  if (is.null(.gateway)) {
    .gateway <<- reticulate::import("gateway")
  }
  .gateway
}

# Import sys, pyPkgInfo, and the target Python package once per call site.
.initPyPkgInfo <- function(pyPkg) {
  reticulate::py_run_string("import sys")
  reticulate::py_run_string("import pyPkgInfo")
  reticulate::py_run_string(sprintf("import %s", pyPkg))
}

# Helper function to generate R wrappers for Enum classes in a python module
#
# @param assignEnumCallback the callback to define the enum in the target R package
# @param enumInfo the Enum classes to generate R wrappers for
autoGenerateEnum <- function(assignEnumCallback, enumInfo) {
  for (e in enumInfo) {
    defineEnum(assignEnumCallback, e$name, e$keys, e$values)
  }
}

# Define an R wrapper for an Enum in Python
#
# @param assignEnumCallback the callback to define the enum in the target R package
# @param name the Enum class name
# @param keys the Enum item names
# @param values the Enum item values
defineEnum <- function(assignEnumCallback, name, keys, values) {
  force(name)
  assignEnumCallback(name, keys, values)
}

# Create formal args that can be assigned to a function
# based on the inspected Python signature.
# @param pyParams the function info args as from getFunctionInfo
.createFormalArgs <- function(pyParams) {
  argNames <- pyParams$args
  defaults <- pyParams$defaults

  if (length(argNames) > 0 && argNames[1] == 'self') {
    argNames <- argNames[-1]
  }

  newArgs <- setNames(rep(list(quote(expr = )), length(argNames)), argNames)

  if (length(defaults) > 0) {
    ## Otherwise fill in arguments with defaults at the end, and add empty symbols
    ## to any remaining arguments
    nArgs <- length(argNames)
    nDefs <- length(defaults)

    ## Position of the last default-less argument
    lastEmpty <- nArgs - nDefs

    ## Add the defaults to the end
    ## The key assumption is that Python defaults belong to the last N arguments
    newArgs[(lastEmpty + 1):nArgs] <- defaults
  }

  if (!is.null(pyParams$varargs) || !is.null(pyParams$keywords)) {
    # if the Python signature uses *args or **kwargs we add
    # dots to the R signature to match
    newArgs <- append(newArgs, alist(... = ))
  }

  return(newArgs)
}

# Define an R wrapper for a object constructor in Python
#
# @param module the python module
# @param setGenericCallback the callback to setGeneric defined in the target R package
# @param name the class name
# @param pyParams the function info args as from getFunctionInfo
defineConstructor <- function(module, setGenericCallback, name, pyParams) {
  force(name)
  force(module)
  force(pyParams)

  rWrapperName <- sprintf(".%s", name)
  gateway <- .getGateway()
  assign(rWrapperName, function(...) {
    pyModule <- reticulate::py_eval(module)
    argsAndKwArgs <- determineArgsAndKwArgs(...)
    returnedObject <- cleanUpStackTrace(
      gateway$invoke,
      list(
        method = list(pyModule, name),
        args = argsAndKwArgs$args,
        kwargs = argsAndKwArgs$kwargs
      )
    )
    # Tag with R class so the dispatch table generic can route by class(obj)[1]
    # R's S3 dispatch checks class(obj)[1] to decide which method to call.
    class(returnedObject) <- c(name, class(returnedObject))
    returnedObject
  })

  rFn <- function(...) {
    # formals will be assigned below, re-create the dots
    # so we can pass them through to the py call
    call <- sys.call()
    call[[1]] <- as.name('list')
    dots <- eval.parent(call)
    do.call(rWrapperName, args = dots)
  }

  newArgs <- .createFormalArgs(pyParams)
  if (length(newArgs) > 0) {
    formals(rFn) <- newArgs
  }

  setGenericCallback(name, rFn)
}

# Define an R wrapper for an instance method of a Python class.
#
# Creates two functions and registers the public one via setGenericCallback:
#
#   .<className>_<methodName>  — private wrapper; validates `instance` is non-NULL,
#                                splits ... into positional/keyword args, calls
#                                gateway$invoke(instance, pythonMethodName, ...).
#   <className>_<methodName>   — public function with formals derived from pyParams;
#                                `self` is stripped and replaced with `instance` as
#                                the first formal. Delegates to the private wrapper.
#
# @param module fully-qualified Python module string, e.g. "synapseclient.models"
# @param setGenericCallback callback that registers the public function in the target
#   R package namespace (typically wraps assign or setGeneric)
# @param className Python class name, e.g. "File"; used as the prefix in the function name
# @param methodName R-side method name (snake_case or camelCase); becomes the suffix
#   in "<className>_<methodName>"
# @param pyParams inspected Python signature from getFunctionInfo: list with fields
#   args, defaults, varargs, keywords
# @param pythonMethodName actual Python method name passed to gateway$invoke; defaults
#   to methodName when NULL — set this when the R name and Python name differ
defineClassMethod <- function(
  module,
  setGenericCallback,
  className,
  methodName,
  pyParams,
  pythonMethodName = NULL
) {
  force(className)
  force(methodName)
  force(module)
  force(pyParams)

  # If pythonMethodName is not provided, use methodName
  if (is.null(pythonMethodName)) {
    pythonMethodName <- methodName
  }
  force(pythonMethodName)

  # Create a unique R function name for the class method
  rFunctionName <- sprintf("%s_%s", className, methodName)
  rWrapperName <- sprintf(".%s_%s", className, methodName)

  gateway <- .getGateway()

  assign(rWrapperName, function(instance, ...) {
    if (missing(instance) || is.null(instance)) {
      stop(sprintf("The first argument must be an instance of %s", className))
    }
    argsAndKwArgs <- determineArgsAndKwArgs(...)
    returnedObject <- cleanUpStackTrace(
      gateway$invoke,
      list(
        method = list(instance, pythonMethodName),
        args = argsAndKwArgs$args,
        kwargs = argsAndKwArgs$kwargs
      )
    )
    if (grepl("GeneratorWrapper", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "GeneratorWrapper"
    }
    if (grepl("CsvFileTable", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "CsvFileTable"
    }
    returnedObject
  })

  rFn <- function(instance, ...) {
    # formals will be assigned below, re-create the dots
    # so we can pass them through to the py call
    call <- sys.call()
    call[[1]] <- as.name('list')
    dots <- eval.parent(call)
    do.call(rWrapperName, args = dots)
  }

  # Create formal arguments for the method, including a "instance" parameter
  newArgs <- .createFormalArgs(pyParams)
  if (length(newArgs) > 0) {
    # Remove 'self' from arguments if it exists and add 'instance' as first parameter
    ## TODO: to revisit when working on https://sagebionetworks.jira.com/browse/SYNR-1602 to strip out synapse_client arguments from the method signature
    if (!is.null(newArgs) && "self" %in% names(newArgs)) {
      newArgs <- newArgs[names(newArgs) != "self"]
    }
    newArgs <- append(newArgs, list(instance = quote(expr = )), after = 0)
  } else {
    newArgs <- list(instance = quote(expr = ))
  }

  formals(rFn) <- newArgs
  setGenericCallback(rFunctionName, rFn)
}

# Define a functional R wrapper for a method of a Python class.
#
# For each (className, methodName) pair this function does two things:
#
#   1. Registers an inner worker — a closure bound to the specific class — in
#      .functionalMethodDispatch under the key "<genericName>_<className>".
#      The worker accepts (instance, ...) and calls gateway$invoke with the
#      Python object as self, forwarding all positional and keyword arguments.
#
#   2. Registers a single public generic (e.g. synGetAcl) in the package
#      namespace the first time it is seen. The generic inspects class(instance)[1]
#      at call time, looks up the matching inner worker, and delegates to it.
#      This means one public function dispatches across all registered classes:
#        File(...) |> synGetAcl()    # routes to synGetAcl_File worker
#        Project(...) |> synGetAcl() # routes to synGetAcl_Project worker
#   3. Calling the generic with no arguments — i.e. synGetAcl() with nothing
#      piped in — triggers an explicit stop() whose message suggests the user
#      should pass an object as the first argument.
#   4. If the generic is called with an object whose class has no registered inner worker,
#      it errors with "No '<genericName>' method registered for class '<className>'".
#   5. For static methods (isStatic = TRUE) no inner worker is registered; instead a
#      plain function is created that resolves the Python class at call time via
#      reticulate::py_eval and invokes the method directly on the class.
#
# @param module the Python module path (e.g. "synapseclient.models")
# @param className the Python class name (e.g. "File"); used as the dispatch key suffix
# @param methodName the method name used to derive the R function name (snake_case)
# @param pyParams parameter info list from getFunctionInfo: args, defaults, varargs, keywords
# @param pythonMethodName the original Python method name if it differs from methodName; defaults to methodName
# @param functionPrefix prefix prepended to the camelCase method name (default "syn")
# @param functionNameMapping optional list with an $explicit named character vector for overriding generated names
# @param isStatic if TRUE, registers a static wrapper that omits the instance argument
defineFunctionalClassMethod <- function(
  module,
  className,
  methodName,
  pyParams,
  pythonMethodName = NULL,
  functionPrefix = "syn",
  functionNameMapping = NULL,
  isStatic = FALSE
) {
  # Capture the package namespace NOW, before any nested calls.
  # sys.function() here = defineFunctionalClassMethod; its environment = the package namespace.
  # Inside local({}) or any nested call, sys.function() would return a different function
  # (e.g. local or eval), giving the wrong environment.
  pkgNs <- environment(sys.function())

  force(className)
  force(methodName)
  force(module)
  force(pyParams)
  force(functionPrefix)
  force(isStatic)

  if (is.null(pythonMethodName)) {
    pythonMethodName <- methodName
  }
  force(pythonMethodName)

  # Generic name — no class suffix. One public function per verb:
  #   synStore(file_obj, ...)    synStore(project_obj, ...)
  # Dispatch to the right implementation via .functionalMethodDispatch lookup.
  genericName <- applyFunctionNameMapping(
    paste0(functionPrefix, snakeToCamel(methodName)),
    functionNameMapping
  )
  force(genericName)

  gateway <- .getGateway()

  if (isStatic) {
    # Static methods: no instance — call directly on the Python class.
    if (!exists(genericName, mode = "function", inherits = FALSE)) {
      # Private wrapper with plain (...) so all named args reach determineArgsAndKwArgs.
      # The public staticFn below has named formals; if it used (...) directly,
      # named formals would absorb the args before they reach ... in the body.
      staticWrapperName <- paste0(".", genericName)
      force(staticWrapperName)
      assign(staticWrapperName, function(...) {
        pyClass <- reticulate::py_eval(sprintf("%s.%s", module, className))
        argsAndKwArgs <- determineArgsAndKwArgs(...)
        returnedObject <- cleanUpStackTrace(
          gateway$invoke,
          list(
            method = list(pyClass, pythonMethodName),
            args = argsAndKwArgs$args,
            kwargs = argsAndKwArgs$kwargs
          )
        )
        if (grepl("GeneratorWrapper", class(returnedObject)[1])) {
          class(returnedObject)[1] <- "GeneratorWrapper"
        }
        if (grepl("CsvFileTable", class(returnedObject)[1])) {
          class(returnedObject)[1] <- "CsvFileTable"
        }
        returnedObject
      })

      # Public function: named formals for discoverability; sys.call() forwards
      # all args (including named ones) to the private wrapper.
      wn <- staticWrapperName
      staticFn <- function(...) {
        call <- sys.call()
        call[[1]] <- as.name('list')
        dots <- eval.parent(call)
        do.call(wn, args = dots)
      }

      methodArgs <- .createFormalArgs(pyParams)
      if (!"..." %in% names(methodArgs)) {
        methodArgs <- c(methodArgs, alist(... = ))
      }
      formals(staticFn) <- methodArgs
      assign(genericName, staticFn, envir = pkgNs)
    }
    return(invisible(NULL))
  }

  # The key for the dispatch table: "<genericName>_<className>"
  classMethodKey <- paste0(genericName, "_", className)

  # Closure stored in .functionalMethodDispatch under classMethodKey; never exposed
  # by name in any namespace — retrieved only by the generic at dispatch time.
  classMethodFn <- function(instance, ...) {
    argsAndKwArgs <- determineArgsAndKwArgs(...)
    returnedObject <- cleanUpStackTrace(
      gateway$invoke,
      list(
        method = list(instance, pythonMethodName),
        args = argsAndKwArgs$args,
        kwargs = argsAndKwArgs$kwargs
      )
    )
    if (grepl("GeneratorWrapper", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "GeneratorWrapper"
    }
    if (grepl("CsvFileTable", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "CsvFileTable"
    }
    returnedObject
  }

  # Assign the classMethodFn to the dispatch table under the key "<genericName>_<className>"
  assign(classMethodKey, classMethodFn, envir = .functionalMethodDispatch)

  # Register the generic once as a plain function
  if (!exists(genericName, mode = "function", inherits = TRUE)) {
    gn <- genericName
    tbl <- .functionalMethodDispatch
    genericFn <- function(instance, ...) {
      # sys.call() captures the raw call so named formals (e.g. comment, label)
      # are forwarded to the classMethodFn
      call <- sys.call()
      call[[1]] <- as.name('list')
      dots <- eval.parent(call)
      if (length(dots) == 0) {
        stop(sprintf(
          "Pass an object as the first argument, e.g. ClassName(...) |> %s()",
          gn
        ))
      }
      cls <- class(dots[[1]])[1]
      key <- paste0(gn, "_", cls)
      if (!exists(key, envir = tbl, inherits = FALSE)) {
        stop(sprintf("No '%s' method registered for class '%s'", gn, cls))
      }
      do.call(get(key, envir = tbl), args = dots)
    }
    # Expose method-specific formals so callers can see available params (e.g. via ?synSnapshot).
    # instance is prepended; ... is added if not already present (handles Python *args/**kwargs methods).
    methodArgs <- .createFormalArgs(pyParams)
    if (!"..." %in% names(methodArgs)) {
      methodArgs <- c(methodArgs, alist(... = ))
    }
    formals(genericFn) <- c(list(instance = quote(expr = )), methodArgs)
    assign(genericName, genericFn, envir = pkgNs)
  }
}

# Helper function to generate R wrappers for classes in a python module
#
# @param module the python module
# @param setGenericCallback the callback to setGeneric defined in the target R package
# @param classInfo the classes to generate R wrappers for
autoGenerateClasses <- function(module, setGenericCallback, classInfo) {
  for (c in classInfo) {
    defineConstructor(module, setGenericCallback, c$name, c$constructorArgs)

    # Generate wrappers for class methods (excluding constructor)
    if (!is.null(c$methods)) {
      for (method in c$methods) {
        # Skip the constructor method (it has the same name as the class)
        if (method$name != c$name) {
          defineClassMethod(
            module,
            setGenericCallback,
            c$name,
            method$name,
            method$args,
            method$name
          )
        }
      }
    }
  }
}

# Helper function to generate both regular class methods and functional interfaces
#
# @param module the python module
# @param setGenericCallback the callback to setGeneric defined in the target R package
# @param classInfo the classes to generate R wrappers for
# @param functionPrefix the prefix to add to functional method names (e.g., "syn")
# @param functionNameMapping the mapping configuration for customizing function names
autoGenerateClassesWithFunctionalInterface <- function(
  module,
  setGenericCallback,
  classInfo,
  functionPrefix = "syn",
  functionNameMapping = NULL
) {
  for (c in classInfo) {
    # suppress output when loading package
    if (nzchar(Sys.getenv("R_INSTALL_PKG"))) {
      cat(sprintf("Creating class wrapper for: %s\n", c$name))
    }
    defineConstructor(module, setGenericCallback, c$name, c$constructorArgs)

    # Generate wrappers for class methods (excluding constructor)
    if (!is.null(c$methods)) {
      for (method in c$methods) {
        # Skip the constructor method (it has the same name as the class)
        if (method$name != c$name) {
          isStatic <- isTRUE(method$is_static)
          # Create functional interface
          defineFunctionalClassMethod(
            module,
            c$name,
            method$name,
            method$args,
            method$name,
            functionPrefix,
            functionNameMapping,
            isStatic = isStatic
          )
        }
      }
    }
  }
}

# Define an R wrapper for a standalone function inside a Python module or class.
#
# The module-level counterpart to defineClassMethod: instead of calling a method
# on a Python instance, it calls a function on a Python module or class resolved
# at call time via reticulate::py_eval(functionContainerName).
#
# Creates two functions, registering the public one via setGenericCallback:
#
#   .<rName>  — private wrapper; resolves the Python container, splits ... into
#               positional/keyword args, calls gateway$invoke, applies
#               transformReturnObject if provided.
#   <rName>   — public function with formals derived from pyParams; delegates
#               to the private wrapper.
#
# @param rName R name for the public function, e.g. "synGet"
# @param pyName Python function name passed to gateway$invoke, e.g. "get"
# @param functionContainerName dotted Python path to the module or class that
#   holds the function, e.g. "synapseclient.operations"; resolved at call time
#   via reticulate::py_eval so it is not imported until the function is invoked
# @param pyParams inspected Python signature from getFunctionInfo: list with
#   fields args, defaults, varargs, keywords
# @param setGenericCallback callback that registers the public function in the
#   target R package namespace
# @param transformReturnObject optional function applied to the Python return
#   value before it is returned to the caller; use to reshape raw Python objects
#   into R-friendly types (e.g. list to data frame). NULL means pass through unchanged.
defineFunction <- function(
  rName,
  pyName,
  functionContainerName,
  pyParams,
  setGenericCallback,
  transformReturnObject = NULL,
  functionNameMapping = NULL
) {
  rName <- applyFunctionNameMapping(rName, functionNameMapping)
  force(rName)
  force(pyName)
  force(functionContainerName)
  force(pyParams)
  rWrapperName <- sprintf(".%s", rName)
  gateway <- .getGateway()
  assign(rWrapperName, function(...) {
    functionContainer <- reticulate::py_eval(functionContainerName)
    argsAndKwArgs <- determineArgsAndKwArgs(...)
    returnedObject <- cleanUpStackTrace(
      gateway$invoke, # nolint: object_usage_linter
      list(
        method = list(functionContainer, pyName),
        args = argsAndKwArgs$args,
        kwargs = argsAndKwArgs$kwargs
      )
    )
    if (grepl("GeneratorWrapper", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "GeneratorWrapper"
    }
    if (grepl("CsvFileTable", class(returnedObject)[1])) {
      class(returnedObject)[1] <- "CsvFileTable"
    }

    if (!is.null(transformReturnObject)) {
      transformReturnObject(returnedObject)
    } else {
      returnedObject
    }
  })

  rFn <- function(...) {
    # formals will be assigned below, re-create the dots
    # so we can pass them through to the py call
    call <- sys.call()
    call[[1]] <- as.name('list')
    dots <- eval.parent(call)
    do.call(rWrapperName, args = dots)
  }

  newArgs <- .createFormalArgs(pyParams)
  if (length(newArgs) > 0) {
    formals(rFn) <- newArgs
  }

  setGenericCallback(rName, rFn)
}

# Helper function to generate R wrappers for functions in a python module
#
# @param setGenericCallback the callback to setGeneric defined in the target R package
# @param functionInfo the functions to generate R wrappers for
# @param transformReturnObject optional function to change returned values in R
autoGenerateFunctions <- function(
  setGenericCallback,
  functionInfo,
  transformReturnObject = NULL,
  functionNameMapping = NULL
) {
  for (f in functionInfo) {
    defineFunction(
      f$rName,
      f$pyName,
      f$functionContainerName,
      f$args,
      setGenericCallback,
      transformReturnObject,
      functionNameMapping
    )
  }
}


# Helper function to capitalize the first letter of the input
#
# @param x the input string
capitalizeFirstLetter <- function(x) {
  paste0(
    toupper(substring(x, 1, 1)),
    substring(x, 2, nchar(x))
  )
}


# Helper function to camel case the given input
#
# @param x the input string
snakeToCamel <- function(x) {
  sapply(
    strsplit(x, "_"),
    function(x) {
      paste(capitalizeFirstLetter(x), collapse = "")
    }
  )
}


# Helper function to add prefix to a name
#
# @param name the name to add prefix to
# @param prefix the prefix to add
addPrefix <- function(name, prefix) {
  paste(
    prefix,
    snakeToCamel(name),
    sep = ""
  )
}

# Helper function to remove NULL in a list
#
# @param x the list to remove NULL
removeNulls <- function(x) {
  Filter(Negate(is.null), x)
}

# Helper function to get a list of Python functions in a given module
#
# @param pyPkg the Python package name
# @param module the Python module
# @param functionFilter optional function to modify the returned functions
# @param functionPrefix optional text to add to the name of the functions
# @param pySingletonName optional singleton object in python
getFunctionInfo <- function(
  pyPkg,
  module,
  functionFilter = NULL,
  functionPrefix = NULL,
  pySingletonName = NULL
) {
  .initPyPkgInfo(pyPkg)
  functionInfo <- reticulate::py_eval(sprintf(
    "pyPkgInfo.getFunctionInfo(%s)",
    module
  ))

  if (!is.null(functionFilter)) {
    functionInfo <- lapply(X = functionInfo, functionFilter)
  }
  # scrub the nulls
  functionInfo <- removeNulls(functionInfo)
  functionContainerName <- module
  if (!is.null(pySingletonName)) {
    functionContainerName <- pySingletonName
  }

  functionInfo <- lapply(X = functionInfo, function(x) {
    if (!is.null(functionPrefix)) {
      rName <- addPrefix(x$name, functionPrefix)
    } else {
      rName <- x$name
    }
    list(
      pyName = x$name,
      rName = rName,
      functionContainerName = functionContainerName,
      args = x$args,
      doc = x$doc,
      title = rName
    )
  })
  functionInfo
}

# Helper function to get a list of Python Enum classes in a given module
#
# @param pyPkg the Python package name
# @param module the Python module
# @param enumFilter optional function to modify the returned Enum classes
getEnumInfo <- function(pyPkg, module, enumFilter = NULL) {
  .initPyPkgInfo(pyPkg)
  enumInfo <- reticulate::py_eval(sprintf("pyPkgInfo.getEnumInfo(%s)", module))
  if (!is.null(enumFilter)) {
    enumInfo <- lapply(X = enumInfo, enumFilter)
  }
  # scrub the nulls
  removeNulls(enumInfo)
}

# Helper function to get a list of Python classes in a given module
#
# @param pyPkg the Python package name
# @param module the Python module
# @param classFilter optional function to modify the returned classes
getClassInfo <- function(pyPkg, module, classFilter = NULL) {
  .initPyPkgInfo(pyPkg)
  classInfo <- reticulate::py_eval(sprintf(
    "pyPkgInfo.getClassInfo(%s)",
    module
  ))
  if (!is.null(classFilter)) {
    classInfo <- lapply(X = classInfo, classFilter)
  }
  # scrub the nulls
  removeNulls(classInfo)
}

# Determines args and kwargs
#
# This function takes the list of arguments passed to an R function and groups them
#  into the (1) unnamed / positional arguments and the (2) the named / keyword arguments
#  to pass to the corresponding Python function.
#
# @param ... the list of arguments passed to an R function
# @return The grouping of arguments into 'args' (the unnamed or positional arguments) and
#  'kwargs' (the named or keyword arguments) to be passed to the corresponding Python function.
determineArgsAndKwArgs <- function(...) {
  values <- list(...)
  valuenames <- names(values)
  n <- length(values)
  args <- list()
  kwargs <- list()
  if (n > 0) {
    positionalArgument <- TRUE
    for (i in 1:n) {
      if (
        is.null(valuenames) ||
          length(valuenames[[i]]) == 0 ||
          nchar(valuenames[[i]]) == 0
      ) {
        # it's a positional argument
        if (!positionalArgument) {
          stop("positional argument follows keyword argument")
        }
        if (is.null(values[[i]])) {
          # inserting a value into a list at best is a no-op, at worst removes an existing value
          # to get the desired insertion we must wrap it in a list
          args[length(args) + 1] <- list(NULL)
        } else {
          args[[length(args) + 1]] <- values[[i]]
        }
      } else {
        # It's a keyword argument.  All subsequent arguments must also be keyword arg's
        positionalArgument <- FALSE
        # a repeated value will overwite an earlier one
        if (is.null(values[[i]])) {
          # inserting a value into a list at best is a no-op, at worst removes an existing value
          # to get the desired insertion we must wrap it in a list
          kwargs[valuenames[[i]]] <- list(NULL)
        } else {
          kwargs[[valuenames[[i]]]] <- values[[i]]
        }
      }
    }
  }
  list(args = args, kwargs = kwargs)
}

.rAuthMessage <- paste0(
  "You have not provided valid credentials for authentication with Synapse. ",
  "Please provide an authentication token and use `synLogin()` before your next attempt. ",
  "See https://r-docs.synapse.org/articles/manageSynapseCredentials.html for more information."
)

.replaceAuthMessage <- function(text) {
  gsub(
    "(?s)You have not provided valid credentials.*?for more information\\.",
    .rAuthMessage,
    text,
    perl = TRUE
  )
}

# The purpose of this function is to remove the Python stack trace from an error message
#  generated when calling Python from R. This makes the command line response more readable
#  when an error occurs. To support debugging the stack trace truncation can be overridden
#  by setting the global option 'verbose' to TRUE.
#
# @param callable the function to be called
# @param args the arguments to be passed to the function 'callable'
# @return the result of calling the given function with the given arguments
cleanUpStackTrace <- function(callable, args) {
  conn <- textConnection("outputCapture", open = "w", local = TRUE)
  sink(conn)
  tryCatch(
    {
      result <- do.call(callable, args)
      sink()
      close(conn)
      cat(paste(outputCapture, collapse = ""))
      result
    },
    error = function(e) {
      sink()
      close(conn)
      errorToReport <- paste(c(outputCapture, e$message), collapse = "\n")
      if (!getOption("verbose")) {
        # extract the error message
        splitArray <- strsplit(
          errorToReport,
          "exception-message-boundary",
          fixed = TRUE
        )[[1]]
        if (length(splitArray) >= 2) errorToReport <- splitArray[2]
      }
      stop(.replaceAuthMessage(errorToReport))
    }
  )
}

#' @title Generate R wrappers for Python classes and functions
#' @description This function generates R wrappers for Python classes and functions
#'   in the given Python container
#'
#' @param pyPkg The Python package name
#' @param container The fully qualified name of a Python module or a Python class to be wrapped
#' @param setGenericCallback The callback to setGeneric defined in the target R package
#' @param assignEnumCallback The callback to define the Python Enum in the target R package.
#' @param functionFilter Optional function to intercept and modify the auto-generated function metadata.
#' @param classFilter Optional function to intercept and modify the auto-generated class metadata.
#' @param functionPrefix Optional text to add to the name of the wrapped functions.
#' @param pySingletonName Optional parameter used to expose a set Python functions which are an object's
#'   methods, but without exposing the object itself. If the `container` parameter is a class then this must
#'   be the name of a Python variable referencing an instance of the class. Otherwise, this must be NULL.
#'   See example 4.
#' @param transformReturnObject Optional function to change returned values in R.
#' @param generateFunctionalInterface Logical. If TRUE, generates functional interface functions
#'   (e.g., synGetPermissions) in addition to regular class methods. Requires functionPrefix to be set.
#' @param functionNameMapping Optional list containing mapping configuration for customizing
#'   functional interface function names. Should contain 'explicit' (direct name mapping).
#'   Use getSynapseClientModelsMapping() for predefined synapseclient.models mappings.
#' @details
#' * `container` can take the same value as `pyPkg`, can be a module or class within the Python package.
#'
#' * `setGenericCallback` function must be defined in the same environment that `generateRWrappers`
#'   is called. See example 1.
#'
#' * `functionFilter` and `classFilter` are optional functions defined by the caller.
#'
#' * `functionFilter` takes as input the metadata for a generated function and either modifies it
#'   or returns NULL to omit it from the set of generated functions. The metadata object is a list
#'   having fields:
#'   ```
#'   'name': character
#'   'args': named list having fields:
#'       'args': a list of the argument names
#'       'varargs':  character
#'       'keywords': character
#'       'defaults': character
#'   'doc': character
#'   'module':character
#'   ```
#'   Please see [inspect.getargspec](https://docs.python.org/2/library/inspect.html#inspect.getargspec)
#'     for more information about the named list `args`.
#'   See example 2.
#'
#' * `classFilter` takes as input the metadata for a generated class and either modifies it
#'   or returns NULL to omit it from the set of generated classes The metadata object is a list
#'   having fields:
#'   ```
#'   'name': character
#'   'constructorArgs': named list having fields:
#'       'args': a list of the argument names
#'       'varargs':  character
#'       'keywords': character
#'       'defaults': character
#'   'doc': character
#'   'methods':named list having fields:
#'       'name': character
#'       'doc': character
#'       'args': named list having fields:
#'           'args': a list of the argument names
#'           'varargs':  character
#'           'keywords': character
#'           'defaults': character
#'   ```
#'   Please see [inspect.getargspec](https://docs.python.org/2/library/inspect.html#inspect.getargspec)
#'     for more information about the named list `args`.
#'   See example 3.
#'
#' * `transformReturnObject` is used to intercept and modify the values returned by the
#'   auto-generated R functions.`transformReturnObject` will be applied to the returned values
#'   from all generated functions. The transformation cannot depend on the function which generated
#'   the returned value. See example 5.
#'
#' @note
#' * `generateRWrappers` should be called at load time.
#' * `generateRWrappers` and `generateRdFiles` must be called with corresponding parameters to ensure
#'    all R wrappers has sufficient documentation.
#' @examples
#' # 1. Generate R wrappers for all functions, classes, and enums in "pyPackageName.aModuleInPyPackageName"
#'
#' callback <- function(name, def) {
#'   setGeneric(name, def)
#' }
# .NAMESPACE <- environment()
#' assignEnumCallback <- function(name, keys, values) {
#'   assign(name, setNames(values, keys), .NAMESPACE)
#' }
#' generateRWrappers(
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   setGenericCallback = callback,
#'   assignEnumCallback = assignEnumCallback)
#'
#' # 2. Generate R wrappers for module "pyPackageName.aModuleInPyPackageName", omitting function "myFun"
#'
#' myfunctionFilter <- function(x) {
#'   if (any(x$name == "myFun")) NULL else x
#' }
#' generateRWrappers(
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   setGenericCallback = callback,
#'   assignEnumCallback = assignEnumCallback,
#'   functionFilter = myfunctionFilter)
#'
#' # 3. Generate R wrappers for module "pyPackageName.aModuleInPyPackageName", omitting the "MyObj" class
#'
#' myclassFilter <- function(x) {
#'   if (any(x$name == "MyObj")) NULL else x
#' }
#' generateRWrappers(
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   setGenericCallback = callback,
#'   assignEnumCallback = assignEnumCallback,
#'   classFilter = myclassFilter)
#'
#' # 4. Generate R wrappers for class "synapseclient.client.Synapse" without exposing the "Synapse" object
#'
#' reticulate::py_run_string("import synapseclient")
#' reticulate::py_run_string("syn = synapseclient.Synapse()")
#' # `pySingletonName` must be the name of the object defined in Python.
#' generateRWrappers(pyPkg = "synapseclient",
#'                   container = "synapseclient.client.Synapse",
#'                   setGenericCallback = callback,
#'                   assignEnumCallback = assignEnumCallback,
#'                   pySingletonName = "syn")
#'
#' # 5. Generate R wrappers for module "pyPackageName.aModuleInPyPackageName", transforming all returned values,
#'    setting each returned object class name to "newName"
#'
#' myTransform <- function(x) {
#'   # replace the object name
#'   class(x) <- "newName"
#' }
#' generateRWrappers(
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   setGenericCallback = callback,
#'   assignEnumCallback = assignEnumCallback,
#'   transformReturnObject = myTransform)
#'
#' @md
generateRWrappers <- function(
  pyPkg,
  container,
  setGenericCallback,
  assignEnumCallback = NULL,
  functionFilter = NULL,
  classFilter = NULL,
  enumFilter = NULL,
  functionPrefix = NULL,
  pySingletonName = NULL,
  transformReturnObject = NULL,
  generateFunctionalInterface = FALSE,
  functionNameMapping = NULL
) {
  # validate the args
  reticulate::py_run_string("import inspect")
  reticulate::py_run_string(sprintf("import %s", pyPkg))
  isClass <- reticulate::py_eval(sprintf("inspect.isclass(%s)", container))
  if (isClass && is.null(pySingletonName)) {
    stop("`container` is a class, but `pySingtonName` is not specified.")
  }
  if (!isClass && !is.null(pySingletonName)) {
    stop("`container` is not a class, but `pySingtonName` is specified.")
  }
  if (is.null(assignEnumCallback) && !is.null(enumFilter)) {
    stop("`enumFilter` is specified, but `assignEnumCallback` is not.")
  }

  functionInfo <- getFunctionInfo(
    pyPkg,
    container,
    functionFilter,
    functionPrefix,
    pySingletonName
  )
  classInfo <- getClassInfo(
    pyPkg,
    container,
    classFilter
  )

  autoGenerateFunctions(
    setGenericCallback,
    functionInfo,
    transformReturnObject,
    functionNameMapping
  )

  if (generateFunctionalInterface && !is.null(functionPrefix)) {
    autoGenerateClassesWithFunctionalInterface(
      container,
      setGenericCallback,
      classInfo,
      functionPrefix,
      functionNameMapping
    )
  } else {
    autoGenerateClasses(
      container,
      setGenericCallback,
      classInfo
    )
  }
  if (!is.null(assignEnumCallback)) {
    enumInfo <- getEnumInfo(
      pyPkg,
      container,
      enumFilter
    )
    autoGenerateEnum(
      assignEnumCallback,
      enumInfo
    )
  }
}

# ------------------------------------------------------------------------------
#
#   Helpers for generating R docs from python docs
#
# ------------------------------------------------------------------------------

# This is factored out of autoGenerateRdFiles so it can be called during testing.
# Commented out because it is not used.
#initAutoGenerateRdFiles <- function(templateDir) {
#  dictDocString <<- getDictDocString(templateDir)
#}

# Generates R documentation (`.Rd`) files from Google-style Python docstrings.
# Referring to https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Rd-format for the Rd format.
# Output is written to `auto-man/`, then copied into `man/` (the package's canonical documentation directory)
# where manual touch-up happens.
#
# @param srcRootDir is the root directory for the code base (i.e., prior to installation)
# @param functionInfo list of functions for which to generate doc's
# @param classInfo list of classes for which to generate doc's
# @param keepContent boolean indicating whether to keep existing content
# @param templateDir (optional) custom templates for the docs
# @param functionNameMapping list of function name mappings
autoGenerateRdFiles <- function(
  srcRootDir,
  functionInfo,
  classInfo,
  keepContent,
  templateDir = NULL,
  functionNameMapping = NULL
) {
  if (!file.exists(srcRootDir)) {
    stop(sprintf("%s does not exist.", srcRootDir))
  }
  if (is.null(templateDir)) {
    # use default templates
    templateDir <- system.file("templates", package = "SynapseR")
  }

  targetFolder <- file.path(srcRootDir, "auto-man")
  if ((!keepContent) || (!file.exists(targetFolder))) {
    # start from a clean slate
    unlink(targetFolder, recursive = T, force = T)
    dir.create(targetFolder)
  }

  # create doc's for all functions (regular functions plus any functional-
  # interface entries using the Function template (rdFunctionTemplate.Rd)
  for (f in functionInfo) {
    name <- f$rName
    args <- f$args
    doc <- f$doc
    title <- f$title
    keyword <- f$targetClass
    if (is.null(f$returned)) {
      returned <- getReturned(doc)
    } else {
      returned <- f$returned
    }
    tryCatch(
      {
        argDescriptionsFromDoc <- parseArgDescriptionsFromDetails(
          doc,
          functionNameMapping
        )
        # The synthetic 'instance' arg on functional-interface
        # entries has no docstring counterpart (see generateFunctionalInterfaceInfo).
        # docstring-derived descriptions win if the same name is present in both.
        if (!is.null(f$argDescriptions)) {
          argDescriptionsFromDoc <- utils::modifyList(
            f$argDescriptions,
            argDescriptionsFromDoc
          )
        }
        argNames <- args$args
        formatArgsResult <- formatArgsForArgumentSection(
          argNames,
          argDescriptionsFromDoc
        )
        content <- createFunctionRdContent(
          templateDir = templateDir,
          alias = name,
          title = title,
          description = doc,
          usage = usage(
            name,
            args,
            argDescriptionsFromDoc
          ),
          argument = formatArgsResult,
          returned = returned,
          functionNameMapping = functionNameMapping,
          keyword = keyword
        )
        fileName <- if (!is.null(f$fileName)) f$fileName else name
        writeContent(content, fileName, targetFolder)
      },
      error = function(e) {
        stop(sprintf("Error generating doc for %s: %s\n", name, e[[1]]))
      }
    )
  }

  # create doc's for all classes, using the Class template (rdClassTemplate.Rd)
  # via createClassRdContent rather than borrowing the function template. Add
  # a \section{Methods}{} listing every method on the class(the constructor itself is methods[[1]]
  for (c in classInfo) {
    tryCatch(
      {
        argDescriptionsFromDoc <- parseArgDescriptionsFromDetails(
          c$doc,
          functionNameMapping
        )
        content <- createClassRdContent(
          templateDir = templateDir,
          alias = c$name,
          title = c$name,
          description = c$doc,
          usage = usage(
            c$name,
            c$constructorArgs,
            argDescriptionsFromDoc
          ),
          argument = formatArgsForArgumentSection(
            c$constructorArgs$args,
            argDescriptionsFromDoc
          ),
          returned = if (is.null(getReturned(c$doc))) {
            sprintf("An object of type %s", c$name)
          } else {
            getReturned(c$doc)
          },
          methods = lapply(
            X = c$methods,
            function(m) {
              list(
                name = m$name,
                description = m$doc,
                args = m$args,
                argDescriptionsFromDoc = parseArgDescriptionsFromDetails(
                  m$doc,
                  functionNameMapping
                )
              )
            }
          ),
          functionNameMapping = functionNameMapping
        )
        writeContent(content, c$name, targetFolder)
      },
      error = function(e) {
        stop(sprintf("Error generating doc for %s: %s\n", c$name, e[[1]]))
      }
    )
  }
}

# Renders a Python default value for display in a \usage{} line.
.formatDefaultValueForUsage <- function(value) {
  if (is.null(value)) {
    return("NULL")
  }
  if (is.character(value) && length(value) == 1) {
    # a trailing backslash would double under deparse() right before the
    # closing quote, breaking Rd's quote-tracking — use a raw string instead
    if (grepl("\\\\$", value)) {
      return(sprintf('r"(%s)"', value))
    }
    # special characters (quotes, literal newlines — e.g. a csv quote_character="\"" or line_end="\n"
    # default) come out as a properly escaped, single-line R literal
    return(deparse(value))
  }
  # Integers are rendered with R's "L" literal suffix
  if (is.integer(value) && length(value) == 1) {
    return(paste0(as.character(value), "L"))
  }
  if (is.list(value) && length(value) == 0) {
    return("list()")
  }
  sprintf("%s", value)
}

# create the 'usage' section of the doc
# this is also used to document the 'methods' of a class
usage <- function(name, args, argDescriptionsFromDoc) {
  argNames <- args$args
  defaults <- args$defaults
  result <- NULL
  if (length(argNames) > 0) {
    # self can be the first arg of a method or function, typ can be the first arg of a constructor
    if (argNames[1] != "self" && argNames[1] != "typ") {
      argStart <- 1
    } else {
      argStart <- 2
    }
    if (argStart <= length(argNames)) {
      for (i in argStart:length(argNames)) {
        argName <- argNames[[i]]
        defaultIndex <- i + length(defaults) - length(argNames)
        if (defaultIndex > 0) {
          # add the formatted default value for the argument
          result <- append(
            result,
            sprintf(
              "%s=%s",
              argName,
              .formatDefaultValueForUsage(defaults[[defaultIndex]])
            )
          )
        } else {
          result <- append(result, argName)
        }
        # remove it from the list of arguments mentioned in the docstring
        argDescriptionsFromDoc[[argName]] <- NULL
      }
    }
  }
  # are there any remaining arguments, not included in the argument list?
  # if so, they are kwargs / named parameters
  if (length(names(argDescriptionsFromDoc)) > 0) {
    result <- append(
      result,
      lapply(
        names(argDescriptionsFromDoc),
        function(x) {
          sprintf("%s=NULL", x)
        }
      )
    )
  }
  sprintf("%s(%s)", name, paste(result, collapse = ", "))
}

# create a named list of arguments and their descriptions
# suitable for use in the arguments section
# argNames is the list of explicit arguments from inspecting the function
# argDescriptionsFromDoc is the result of parsing the docstring, looking for parameters
formatArgsForArgumentSection <- function(argNames, argDescriptionsFromDoc) {
  # renders a list(type=, description=) entry as "(type) description",
  # or just "description" when there's no type annotation
  formatArgEntry <- function(entry) {
    if (is.null(entry)) {
      return("")
    }
    if (nchar(entry$type) > 0) {
      sprintf("(%s) %s", entry$type, entry$description)
    } else {
      entry$description
    }
  }
  result <- NULL
  if (length(argNames) > 0) {
    if (argNames[1] != "self" && argNames[1] != "typ") {
      argStart <- 1
    } else {
      argStart <- 2
    }
    if (argStart <= length(argNames)) {
      for (i in argStart:length(argNames)) {
        argName <- argNames[[i]]
        argDescription <- formatArgEntry(argDescriptionsFromDoc[[argName]])
        # remove it from the list of arguments mentioned in the docstring
        argDescriptionsFromDoc[[argName]] <- NULL
        result <- append(
          result,
          sprintf("\\item{%s}{%s}", argName, argDescription)
        )
      }
    }
  }
  # are there any remaining arguments, not included in the argument list?
  # if so, they are kwargs / named parameters
  if (length(argDescriptionsFromDoc) > 0) {
    result <- append(
      result,
      lapply(
        names(argDescriptionsFromDoc),
        function(x) {
          sprintf(
            "\\item{%s}{optional named parameter: %s}",
            x,
            formatArgEntry(argDescriptionsFromDoc[[x]])
          )
        }
      )
    )
  }
  paste(result, collapse = "\n")
}

# Commented out because it is not used currently.
# getDictDocString <- function(templateDir) {
#   file <- sprintf("%s/dictDocString.txt", templateDir)
#   connection <- file(file, open = "r")
#   result <- paste(readLines(connection), collapse = "\n")
#   close(connection)
#   result
# }

insertLatexNewLines <- function(raw) {
  gsub("\n", "\\cr\n", raw, fixed = TRUE)
}

# ------------------------------------------------------------------------------
#   Google-style docstring parsing (synapseclient's mkdocstrings config in
#   mkdocs.yml sets docstring_style: google) — "Arguments:"/"Attributes:",
#   "Returns:", "Raises:", "Note(s):", "Example(s):" sections, mkdocstrings
#   cross-refs ([qualified.name][]), and markdown links/code spans.
# ------------------------------------------------------------------------------

# `inspect.cleandoc`/`inspect.getdoc` (used throughout pyPkgInfo.py) dedent
# docstrings, so top-level section headers always sit at column 0;
.googleSectionHeaderPattern <- "^(Arguments|Args|Attributes|Returns|Return|Yields|Raises|Raise|Example|Examples|Note|Notes|Important Note|See Also):[ \t]*(.*)$"

# Split a cleaned docstring into its leading description and an ordered list
# of sections (each list(header=, title=, body=)).
.splitGoogleStyleSections <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return(list(description = "", sections = list()))
  }
  text <- gsub("\r\n", "\n", raw, fixed = TRUE)
  lines <- strsplit(text, "\n", fixed = TRUE)[[1]]
  headerLineIdx <- grep(.googleSectionHeaderPattern, lines)
  if (length(headerLineIdx) == 0) {
    return(list(description = text, sections = list()))
  }
  # description is the text before the first header
  description <- paste(lines[seq_len(headerLineIdx[1] - 1)], collapse = "\n")
  # sections is a list of lists, one for each header and its body.
  sections <- vector("list", length(headerLineIdx))
  # Most of the time, text indented beneath one header, up to the next header, is that section's body.
  # However, "Example"/"Examples" may repeat and may carry a title on the same line. grep() extracts every matching line.
  for (i in seq_along(headerLineIdx)) {
    startIdx <- headerLineIdx[i]
    endIdx <- if (i < length(headerLineIdx)) {
      headerLineIdx[i + 1] - 1
    } else {
      # the last section goes all the way to the end of the docstring
      length(lines)
    }
    header <- sub(.googleSectionHeaderPattern, "\\1", lines[startIdx])
    # second capture group for one header.
    # For "Example: Using this function", this yields "Using this function"
    title <- trimws(sub(.googleSectionHeaderPattern, "\\2", lines[startIdx]))
    bodyLines <- if (startIdx < endIdx) {
      lines[(startIdx + 1):endIdx]
    } else {
      character(0)
    }
    sections[[i]] <- list(
      header = header,
      title = title,
      body = paste(bodyLines, collapse = "\n")
    )
  }
  list(description = description, sections = sections)
}

.sectionsWithHeader <- function(sections, headers) {
  # Filter the sections list to only include sections with a header that is in the headers list
  Filter(function(s) s$header %in% headers, sections)
}

# Get Description section
getDescription <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return("")
  }
  trimws(.splitGoogleStyleSections(raw)$description, which = "right")
}
# Get Return section
getReturned <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return("NULL")
  }
  sections <- .sectionsWithHeader(
    .splitGoogleStyleSections(raw)$sections,
    c("Returns", "Return", "Yields")
  )
  if (length(sections) == 0) {
    return("NULL")
  }
  trimws(sections[[1]]$body)
}

# Extracts a "Raises:" section
getErrors <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return("")
  }
  sections <- .sectionsWithHeader(
    .splitGoogleStyleSections(raw)$sections,
    c("Raises", "Raise")
  )
  if (length(sections) == 0) {
    return("")
  }
  trimws(sections[[1]]$body)
}

# Extracts a "Note:"/"Notes:" section — maps to \note{}.
getNote <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return("")
  }
  sections <- .sectionsWithHeader(
    .splitGoogleStyleSections(raw)$sections,
    c("Note", "Notes", "Important Note")
  )
  if (length(sections) == 0) {
    return("")
  }
  trimws(sections[[1]]$body)
}

# Reformat example content
.cleanExampleBody <- function(text) {
  # split the example body into lines
  lines <- strsplit(text, "\n", fixed = TRUE)[[1]]
  # comment out example description lines that precede the first fenced code block
  fenceIdx <- grep("^\\s*```", lines)
  if (length(fenceIdx) > 0) {
    isDescription <- seq_along(lines) < fenceIdx[1] &
      nzchar(trimws(lines)) &
      !grepl("^\\s*&nbsp;\\s*$", lines)
    lines[isDescription] <- sub("^(\\s*)", "\\1# ", lines[isDescription])
  }
  # remove lines that start with ```
  lines <- lines[!grepl("^\\s*```", lines)]
  # remove lines that start with &nbsp;
  lines <- lines[!grepl("^\\s*&nbsp;\\s*$", lines)]
  # collapse the lines into a single string
  paste(lines, collapse = "\n")
}

# Get Example sections
# Returns the docstring's "Example"/"Examples" sections as a list of list(title=, body=)
# as there may be multiple "Example"/"Examples" sections.
getExampleSections <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return(list())
  }
  sections <- .sectionsWithHeader(
    .splitGoogleStyleSections(raw)$sections,
    c("Example", "Examples")
  )
  lapply(sections, function(s) {
    list(title = s$title, body = .cleanExampleBody(s$body))
  })
}

# Builds the content for the \examples{} placeholder, itemizing each example
# section with a numbered "## Example N: Title" comment header when there's
# more than one. The body itself is still the Python docstring's example text verbatim, wrapped
# in a real \dontrun{} (so R CMD check never tries to execute it as R) — a
# manual/ai-assisted translation is still required to translate it to valid R before it's runnable.
# see more details in the CONTRIBUTING.md file.
.buildExamplesRdContent <- function(sections) {
  if (length(sections) == 0) {
    return("")
  }
  multiple <- length(sections) > 1
  blocks <- vapply(
    seq_along(sections),
    function(i) {
      title <- sections[[i]]$title
      header <- if (multiple) {
        if (nchar(title) > 0) {
          sprintf("## Example %d: %s", i, title)
        } else {
          sprintf("## Example %d", i)
        }
      } else if (nchar(title) > 0) {
        sprintf("## %s", title)
      } else {
        ""
      }
      body <- sections[[i]]$body
      if (nchar(header) > 0) paste(header, body, sep = "\n") else body
    },
    character(1)
  )
  codeText <- paste(blocks, collapse = "\n\n")
  paste0("\\dontrun{\n", codeText, "\n}")
}

# Formats one argument's accumulated description lines and stores the
# result under `currentName` in `result`, alongside its (possibly empty)
# `currentType`. Returns the updated `result`; a NULL `currentName` (no
# argument started yet) returns `result` unchanged.
.storeArgText <- function(
  result,
  currentName,
  currentType,
  currentLines
) {
  if (is.null(currentName)) {
    return(result)
  }
  # collapse lines into a single string
  text <- paste(currentLines, collapse = "\n")
  # normalize paragraph breaks first, so a blank line's "\n\n" is preserved
  text <- gsub(" *\n *\n *", "\n\n", text)
  # a non-blank line is a soft line-wrap (joined with a space)
  # e.g. "foo \n bar\n\nbaz" -> "foo bar\n\nbaz"
  text <- gsub("(?<!\n)[ \t]*\n[ \t]*(?!\n)", " ", text, perl = TRUE)
  # trim whitespace and store the result
  result[[currentName]] <- list(type = currentType, description = trimws(text))
  result
}

# Parse the body of an "Arguments:"/"Args:"/"Attributes:" section into a
# named list mapping each parameter name to list(type=, description=). A new
# parameter entry is recognized at the section's base indent (the indent of
# its first non-blank line); anything indented deeper is a continuation of
# the previous parameter's description. `type` is "" when the docstring
# didn't include a "name (type):" annotation for that parameter.
.parseArgSectionBody <- function(body) {
  if (is.null(body) || nchar(trimws(body)) == 0) {
    return(list())
  }
  bodyLines <- strsplit(body, "\n", fixed = TRUE)[[1]]
  # find the indices of the non-blank lines
  nonBlank <- which(nzchar(trimws(bodyLines)))
  if (length(nonBlank) == 0) {
    return(list())
  }
  firstLine <- bodyLines[nonBlank[1]]
  # calculate the base indent of the first line
  baseIndent <- nchar(firstLine) - nchar(sub("^[ \t]+", "", firstLine))
  # argument pattern is a regular expression that matches the argument name, type, and description
  # e.g. baseindent + "name (type): description"
  argPattern <- sprintf(
    "^[ ]{%d}(\\w+)[ \t]*(\\([^)]*\\))?[ \t]*:[ \t]?(.*)$",
    baseIndent
  )
  result <- list()
  currentName <- NULL
  currentType <- ""
  currentLines <- character(0)
  for (line in bodyLines) {
    m <- regmatches(line, regexec(argPattern, line))[[1]]
    if (length(m) > 1) {
      result <- .storeArgText(
        result,
        currentName,
        currentType,
        currentLines
      )
      currentName <- m[2]
      # strip the surrounding parens from the optional "(type)" capture
      currentType <- sub("^\\((.*)\\)$", "\\1", m[3])
      currentLines <- if (nchar(m[4]) > 0) m[4] else character(0)
    } else if (!is.null(currentName)) {
      # continue the current argument's description
      currentLines <- c(currentLines, trimws(line))
    }
  }
  # store the last argument, since the loop only stores on the *next*
  # match and there is no next match after the final argument
  result <- .storeArgText(result, currentName, currentType, currentLines)
  result
}

# returns a named list in which the names are arguments and the values are
# list(type=, description=) — description is Latex-converted, type is passed
# through as-is
parseArgDescriptionsFromDetails <- function(raw, functionNameMapping = NULL) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return(list())
  }
  argSections <- .sectionsWithHeader(
    .splitGoogleStyleSections(raw)$sections,
    c("Arguments", "Args", "Attributes")
  )
  if (length(argSections) == 0) {
    return(list())
  }
  parsed <- list()
  for (section in argSections) {
    # merge this section's parsed arguments into the running result, after
    # stripping any fenced code sample in the body so its ``` markers don't
    # get mismatched by .convertInlineCode's single-backtick regex later on
    parsed <- utils::modifyList(
      parsed,
      .parseArgSectionBody(.cleanExampleBody(section$body))
    )
  }
  lapply(parsed, function(x) {
    list(
      type = x$type,
      description = insertLatexNewLines(pyVerbiageToLatex(
        x$description,
        functionNameMapping
      ))
    )
  })
}

# Rename cross-reference function name to R function name
.resolveCrossRefRName <- function(qualifiedName, functionNameMapping = NULL) {
  parts <- strsplit(qualifiedName, ".", fixed = TRUE)[[1]]
  name <- parts[length(parts)]
  name <- sub("_async$", "", name)
  applyFunctionNameMapping(
    paste0("syn", snakeToCamel(name)),
    functionNameMapping
  )
}

# mkdocstrings bare cross-reference syntax: "[qualified.name][]" -> a linked,
# code-styled R function reference, e.g.
# "[synapseclient.models.Activity.disassociate_from_entity_async][]"
# -> "\code{\link[=synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}}"
.convertMkdocstringsCrossRefs <- function(text, functionNameMapping = NULL) {
  pattern <- "\\[([A-Za-z0-9_.]+)\\]\\[\\]"
  where <- gregexpr(pattern, text)
  fullMatches <- regmatches(text, where)[[1]]
  if (length(fullMatches) == 0) {
    return(text)
  }
  qualifiedNames <- sub(pattern, "\\1", fullMatches)
  rNames <- vapply(
    qualifiedNames,
    .resolveCrossRefRName,
    character(1),
    functionNameMapping = functionNameMapping
  )
  replacements <- sprintf("\\code{\\link[=%s]{%s}}", rNames, rNames)
  regmatches(text, where) <- list(replacements)
  text
}

# standard markdown links: "[text](url)" -> "\href{url}{text}"
.convertMarkdownLinks <- function(text) {
  pattern <- "\\[([^][]+)\\]\\(([^()[:space:]]+)\\)"
  where <- gregexpr(pattern, text)
  fullMatches <- regmatches(text, where)[[1]]
  if (length(fullMatches) == 0) {
    return(text)
  }
  linkText <- sub(pattern, "\\1", fullMatches)
  linkUrl <- sub(pattern, "\\2", fullMatches)
  replacements <- sprintf("\\href{%s}{%s}", linkUrl, linkText)
  regmatches(text, where) <- list(replacements)
  text
}

# inline code spans with single backticks: "`code`" -> "\code{code}"
.convertInlineCode <- function(text) {
  pattern <- "`([^`]+)`"
  where <- gregexpr(pattern, text)
  fullMatches <- regmatches(text, where)[[1]]
  if (length(fullMatches) == 0) {
    return(text)
  }
  codeText <- sub(pattern, "\\1", fullMatches)
  replacements <- sprintf("\\code{%s}", codeText)
  regmatches(text, where) <- list(replacements)
  text
}

# Converts a chunk of Python docstring prose into Rd markup
pyVerbiageToLatex <- function(raw, functionNameMapping = NULL) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) {
    return("")
  }
  result <- raw
  result <- .convertMkdocstringsCrossRefs(result, functionNameMapping)
  result <- .convertMarkdownLinks(result)
  result <- .convertInlineCode(result)
  result
}
# Strips the classically-optional Rd sections — Details, Errors, Note, See
# Also, Examples — out of already-substituted .Rd content when they ended up
# empty (i.e. their placeholder was replaced with "" or all-whitespace), so
# auto-generated docs don't carry empty \section{}{}/\command{} blocks.
.removeEmptyRdSections <- function(content) {
  singleBraceSections <- c("details", "note", "seealso", "examples")
  for (section in singleBraceSections) {
    content <- gsub(
      sprintf("\\\\%s\\{\\s*\\}\n?", section),
      "",
      content,
      perl = TRUE
    )
  }
  # \section{Errors}{...} has a second brace group holding its body
  content <- gsub(
    "\\\\section\\{Errors\\}\\{\\s*\\}\n?",
    "",
    content,
    perl = TRUE
  )
  content
}

# Create the Rd content for a function
# @param templateDir The directory containing the template files
# @param alias The alias for the function
# @param title The title of the function
# @param description The description of the function
# @param usage The usage of the function
# @param argument The arguments of the function
# @param returned The returned value of the function
# @param functionNameMapping The function name mapping
# @return The Rd content for the function
createFunctionRdContent <- function(
  templateDir,
  alias,
  title,
  description,
  usage,
  argument,
  returned,
  functionNameMapping = NULL,
  keyword = NULL
) {
  templateFile <- sprintf("%s/rdFunctionTemplate.Rd", templateDir)
  connection <- file(templateFile, open = "r")
  template <- paste(readLines(connection), collapse = "\n")
  close(connection)

  content <- template
  content <- gsub("##alias##", alias, content, fixed = TRUE)
  if (!missing(title) && !is.null(title)) {
    content <- gsub("##title##", title, content, fixed = TRUE)
  }
  exampleSections <- list()
  errors <- ""
  note <- ""
  if (!missing(description) && !is.null(description)) {
    processedDescription <- pyVerbiageToLatex(
      getDescription(description),
      functionNameMapping
    )
    content <- gsub(
      "##description##",
      processedDescription,
      content,
      fixed = TRUE
    )
    exampleSections <- lapply(
      getExampleSections(description),
      function(s) {
        list(
          title = pyVerbiageToLatex(s$title, functionNameMapping),
          body = pyVerbiageToLatex(s$body, functionNameMapping)
        )
      }
    )
    errors <- pyVerbiageToLatex(getErrors(description), functionNameMapping)
    note <- pyVerbiageToLatex(getNote(description), functionNameMapping)
  } else {
    content <- gsub("##description##", "", content, fixed = TRUE)
  }
  if (!missing(returned) && !is.null(returned)) {
    value <- pyVerbiageToLatex(returned, functionNameMapping)
    content <- gsub("##value##", value, content, fixed = TRUE)
  } else {
    content <- gsub("##value##", "", content, fixed = TRUE)
  }
  if (!missing(usage) && !is.null(usage)) {
    content <- gsub("##usage##", usage, content, fixed = TRUE)
  }
  if (!missing(argument) && !is.null(argument)) {
    content <- gsub("##arguments##", argument, content, fixed = TRUE)
  }
  content <- gsub("##details##", "", content, fixed = TRUE)
  content <- gsub("##seealso##", "", content, fixed = TRUE)
  content <- gsub("##errors##", errors, content, fixed = TRUE)
  content <- gsub("##note##", note, content, fixed = TRUE)
  content <- gsub(
    "##examples##",
    .buildExamplesRdContent(exampleSections),
    content,
    fixed = TRUE
  )
  content <- gsub(
    "##keyword##",
    if (!is.null(keyword)) keyword else "",
    content,
    fixed = TRUE
  )
  .removeEmptyRdSections(content)
}

createMethodContent <- function(f) {
  paste0(
    "\\item \\code{",
    usage(f$name, f$args, f$argDescriptionsFromDoc),
    "}: ",
    f$description
  )
}

# Turns a class's already-shaped methods list (list(name=, description=,
# args=, argDescriptionsFromDoc=) per entry — see the `methods = lapply(...)`
# construction wherever this is called from) into the joined \item entries
# for a "\section{Methods}{\itemize{...}}" block. Factored out of
# createClassRdContent so the constructor page (which now carries this
# section itself; see autoGenerateRdFiles) can reuse the exact same logic.
.buildMethodsListContent <- function(methods, title, functionNameMapping) {
  methodContent <- NULL
  for (method in methods) {
    methodDescription <- method$description
    if (method$name == title) {
      method$description <- sprintf("Constructor for \\code{\\link{%s}}", title)
    } else {
      if (!is.null(methodDescription)) {
        methodDescription <- pyVerbiageToLatex(
          getDescription(methodDescription),
          functionNameMapping
        )
        methodDescription <- insertLatexNewLines(methodDescription)
        method$description <- methodDescription
      }
    }
    methodContent <- c(methodContent, createMethodContent(method))
  }
  paste(methodContent, collapse = "\n")
}

# Create the Rd content for a class
# @param templateDir The directory containing the template files
# @param alias The alias for the class
# @param title The title of the class
# @param description The description of the class
# @param methods The methods of the class
# @param argument The arguments of the class
# @param usage The usage of the class
# @param returned The returned value of the class
# @param functionNameMapping The function name mapping
# @return The Rd content for the class
createClassRdContent <- function(
  templateDir,
  alias,
  title,
  description,
  methods,
  argument = NULL,
  usage = NULL,
  returned = NULL,
  functionNameMapping = NULL
) {
  templateFile <- sprintf("%s/rdClassTemplate.Rd", templateDir)
  connection <- file(templateFile, open = "r")
  template <- paste(readLines(connection), collapse = "\n")
  close(connection)

  content <- template
  content <- gsub("##alias##", alias, content, fixed = TRUE)
  if (!missing(title) && !is.null(title)) {
    content <- gsub("##title##", title, content, fixed = TRUE)
  }
  # The constructor's arguments (i.e. the class's own attributes) now live
  # here instead of on a separate "<ClassName>.Rd" constructor page — see
  # autoGenerateRdFiles, which no longer generates that page at all.
  content <- gsub(
    "##arguments##",
    if (!is.null(argument)) argument else "",
    content,
    fixed = TRUE
  )
  if (!missing(usage) && !is.null(usage)) {
    content <- gsub("##usage##", usage, content, fixed = TRUE)
  }
  exampleSections <- list()
  note <- ""
  if (!missing(description) && !is.null(description)) {
    processedDescription <- pyVerbiageToLatex(
      getDescription(description),
      functionNameMapping
    )
    content <- gsub(
      "##description##",
      processedDescription,
      content,
      fixed = TRUE
    )
    exampleSections <- lapply(
      getExampleSections(description),
      function(s) {
        list(
          title = pyVerbiageToLatex(s$title, functionNameMapping),
          body = pyVerbiageToLatex(s$body, functionNameMapping)
        )
      }
    )
    note <- pyVerbiageToLatex(getNote(description), functionNameMapping)
  } else {
    content <- gsub("##description##", "", content, fixed = TRUE)
  }
  if (!missing(returned) && !is.null(returned)) {
    value <- pyVerbiageToLatex(returned, functionNameMapping)
    content <- gsub("##value##", value, content, fixed = TRUE)
  } else {
    content <- gsub("##value##", "", content, fixed = TRUE)
  }
  # `details` and `seealso` have no equivalent Google-style docstring
  # section to source from — left for manual curation in man/.
  content <- gsub("##details##", "", content, fixed = TRUE)
  content <- gsub("##seealso##", "", content, fixed = TRUE)
  content <- gsub("##note##", note, content, fixed = TRUE)
  content <- gsub(
    "##examples##",
    .buildExamplesRdContent(exampleSections),
    content,
    fixed = TRUE
  )

  content <- gsub(
    "##methods##",
    .buildMethodsListContent(methods, title, functionNameMapping),
    content,
    fixed = TRUE
  )
  .removeEmptyRdSections(content)
}

writeContent <- function(content, name, targetFolder) {
  filePath <- file.path(targetFolder, sprintf("%s.Rd", name))
  connection <- file(filePath, open = "w")
  writeChar(content, connection, eos = NULL)
  writeChar("\n", connection, eos = NULL)
  close(connection)
}

#' @title Generate .Rd files for Python classes and functions
#' @description This function generates .Rd files for Python classes and functions
#'   in a given Python container
#'
#' @param srcRootDir The root directory under which another directory, `auto-man/` is created to hold
#'   the output, Rd files.
#' @param pyPkg The Python package name
#' @param container The fully qualified name of a Python module, or a Python class to be wrapped
#' @param functionFilter Optional function to intercept and modify the auto-generated function metadata.
#' @param classFilter Optional function to intercept and modify the auto-generated class metadata.
#' @param functionPrefix Optional text to add to the name of the wrapped functions.
#' @param keepContent Optional whether the existing files at the target directory should be kept.
#' @param templateDir Optional path to a template directory. Set `templateDir` to NULL to use the default
#'   templates in the `/templates/` folder.
#' @param generateFunctionalInterface Logical. If TRUE, generates documentation for functional interface
#'   functions (e.g., synGetPermissions) in addition to regular class methods. Requires functionPrefix to be set.
#' @param functionNameMapping Optional list containing mapping configuration for customizing
#'   functional interface function names. Should contain 'explicit' (direct name mapping).
#'   Use getSynapseClientModelsMapping() for predefined synapseclient.models mappings.
#' @details
#' * `container` can take the same value as `pyPkg`, can be a module or a class within the Python package.
#'
#' * `functionFilter` and `classFilter` are optional functions defined by the caller.
#'
#' * `functionFilter` takes as input the metadata for a generated function and either modifies it
#'   or returns NULL to omit it from the set of generated functions. The metadata object is a list
#'   having fields:
#'   ```
#'   'name': character
#'   'args': named list having fields:
#'       'args': a list of the argument names
#'       'varargs':  character
#'       'keywords': character
#'       'defaults': character
#'   'doc': character
#'   'module':character
#'   ```
#'   Please see [inspect.getargspec](https://docs.python.org/2/library/inspect.html#inspect.getargspec)
#'     for more information about the named list `args`.
#'   See example 2.
#'
#' * `classFilter` takes as input the metadata for a generated class and either modifies it
#'   or returns NULL to omit it from the set of generated classes The metadata object is a list
#'   having fields:
#'   ```
#'   'name': character
#'   'constructorArgs': named list having fields:
#'       'args': a list of the argument names
#'       'varargs':  character
#'       'keywords': character
#'       'defaults': character
#'   'doc': character
#'   'methods':named list having fields:
#'       'name': character
#'       'doc': character
#'       'args': named list having fields:
#'           'args': a list of the argument names
#'           'varargs':  character
#'           'keywords': character
#'           'defaults': character
#'   ```
#'   Please see [inspect.getargspec](https://docs.python.org/2/library/inspect.html#inspect.getargspec)
#'     for more information about the named list `args`.
#'   See example 3.
#'
#' @note Python documentation may contains key words and terms that are only meaningful to Python users.
#'   The generated .Rd files, located in 'srcRootDir/auto-man', do not auto correct these terms, nor provide
#'   examples in R. One must copy all auto-generated .Rd files to their package `/man` folder and make sure
#'   that the language being used in these documents are friendly to R users.
#' @examples
#' # 1. Generate .Rd files for all functions and classes in "pyPackageName.aModuleInPyPackageName"
#' generateRdFiles(
#'   srcRootDir = "path/to/R/pkg",
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName")
#'
#' # 2. Generate docs for the module "pyPackageName.aModuleInPyPackageName", omitting the function "myFun"
#' myfunctionFilter <- function(x) {
#'   if (any(x$name == "myFun")) NULL else x
#' }
#' generateRdFiles(
#'   srcRootDir = "path/to/R/pkg",
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   functionFilter = myfunctionFilter)
#'
#' # 3.Generate docs for the module "pyPackageName.aModuleInPyPackageName", omitting the "MyObj" constructor
#' myclassFilter <- function(x) {
#'   if (any(x$name == "MyObj")) NULL else x
#' }
#' generateRdFiles(
#'   srcRootDir = "path/to/R/pkg",
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   classFilter = myclassFilter)
#'
#' # 4. Generate docs including functional interface functions (e.g.,synGetAcl(instance,...)
#' generateRdFiles(
#'   srcRootDir = "path/to/R/pkg",
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   functionPrefix = "syn",
#'   generateFunctionalInterface = TRUE)
#' @md
generateRdFiles <- function(
  srcRootDir,
  pyPkg,
  container,
  functionFilter = NULL,
  classFilter = NULL,
  functionPrefix = NULL,
  keepContent = FALSE,
  templateDir = NULL,
  generateFunctionalInterface = FALSE,
  functionNameMapping = NULL
) {
  functionInfo <- getFunctionInfo(
    pyPkg,
    container,
    functionFilter,
    functionPrefix
  )
  classInfo <- getClassInfo(pyPkg, container, classFilter)

  # Generate functional interface function info if requested
  functionalInterfaceInfo <- list()
  if (generateFunctionalInterface && !is.null(functionPrefix)) {
    functionalInterfaceInfo <- generateFunctionalInterfaceInfo(
      classInfo,
      functionPrefix,
      functionNameMapping
    )
  }

  # Combine all function info (regular functions + functional interface functions)
  allFunctionInfo <- c(functionInfo, functionalInterfaceInfo)

  autoGenerateRdFiles(
    srcRootDir,
    allFunctionInfo,
    classInfo,
    keepContent,
    file.path(srcRootDir, "inst", "templates"),
    functionNameMapping
  )
}

# Helper function to generate functional interface function info for documentation
#
# @param classInfo the classes to extract functional interface info from
# @param functionPrefix the prefix to add to functional method names (e.g., "syn")
# @param functionNameMapping the mapping configuration for customizing function names
generateFunctionalInterfaceInfo <- function(
  classInfo,
  functionPrefix = "syn",
  functionNameMapping = NULL
) {
  functionalInfo <- list()

  for (c in classInfo) {
    # Generate info for class methods (excluding constructor)
    if (!is.null(c$methods)) {
      for (method in c$methods) {
        # Skip the constructor method (it has the same name as the class)
        if (method$name != c$name) {
          # Generic name — no class suffix; dispatch table routes per class
          defaultGenericName <- paste0(
            functionPrefix,
            snakeToCamel(method$name)
          )
          functionalRFunctionName <- applyFunctionNameMapping(
            defaultGenericName,
            functionNameMapping
          )

          # The generic functionalways exposes 'instance' as the real first named formal,
          #so the documented usage()/ \arguments{} must include it too
          modifiedArgs <- method$args
          if (!is.null(modifiedArgs) && "self" %in% modifiedArgs$args) {
            modifiedArgs$args <- modifiedArgs$args[modifiedArgs$args != "self"]
          }
          modifiedArgs$args <- c("instance", modifiedArgs$args)
          fileName <- paste0(
            c$name,
            "_",
            substring(functionalRFunctionName, nchar(functionPrefix) + 1)
          )

          functionalFunctionInfo <- list(
            pyName = method$name,
            rName = functionalRFunctionName, # public generic, e.g. "synGetAcl"
            fileName = fileName, # draft file name, e.g. "File_GetAcl"
            targetClass = c$name, # e.g. "File" — which class this entry covers
            functionContainerName = paste0(c$name, ".", method$name),
            args = modifiedArgs,
            # 'instance' has no docstring counterpart to source a
            # description from; supply one directly
            argDescriptions = list(
              instance = list(
                type = "",
                description = sprintf("The %s instance to operate on.", c$name)
              )
            ),
            doc = method$doc,
            title = paste(
              c$name,
              ": ",
              method$name
            ),
            returned = getReturned(method$doc)
          )

          functionalInfo <- append(functionalInfo, list(functionalFunctionInfo))
        }
      }
    }
  }

  return(functionalInfo)
}

# Helper function to apply function name mapping if configured
#
# @param defaultName the default generated function name
# @param mappingConfig the mapping configuration list
applyFunctionNameMapping <- function(defaultName, mappingConfig = NULL) {
  if (is.null(mappingConfig)) {
    return(defaultName)
  }

  # Try explicit mapping table
  if (!is.null(mappingConfig$explicit)) {
    mapped <- mappingConfig$explicit[[defaultName]]
    if (!is.null(mapped)) {
      return(mapped)
    }
  }

  # Return default if no mapping found
  return(defaultName)
}

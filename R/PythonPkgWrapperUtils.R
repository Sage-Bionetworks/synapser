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
#  ├── synGetAcl_File      → function(instance, ...) # calls the Python method on the instance
#  ├── synGetAcl_Project   → function(instance, ...) # calls the Python method on the instance
#  └── ...
#
.functionalMethodDispatch <- new.env(parent = emptyenv())

# Lazily cached gateway module — imported once, reused everywhere.
.gateway <- NULL
.getGateway <- function() {
  if (is.null(.gateway)) .gateway <<- reticulate::import("gateway")
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

  newArgs <- setNames(rep(list(quote(expr =)), length(argNames)), argNames)

  if (length(defaults) > 0) {
    ## Otherwise fill in arguments with defaults at the end, and add empty symbols
    ## to any remaining arguments
    nArgs <- length(argNames)
    nDefs <- length(defaults)

    ## Position of the last default-less argument
    lastEmpty <- nArgs - nDefs

    ## Add the defaults to the end
    newArgs[(lastEmpty + 1):nArgs] <- defaults
  }

  if (!is.null(pyParams$varargs) || !is.null(pyParams$keywords)) {
    # if the Python signature uses *args or **kwargs we add
    # dots to the R signature to match
    newArgs <- append(newArgs, alist(... =))
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
defineClassMethod <- function(module, setGenericCallback, className, methodName, pyParams, pythonMethodName = NULL) {
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
    if (!is.null(newArgs) && "self" %in% names(newArgs)) {
      newArgs <- newArgs[names(newArgs) != "self"]
    }
    newArgs <- append(newArgs, list(instance = quote(expr =)), after = 0)
  } else {
    newArgs <- list(instance = quote(expr =))
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
#      reticulate::py_eval and invokes the method directly without an instance.
#
# @param module the Python module path (e.g. "synapseclient.models")
# @param className the Python class name (e.g. "File"); used as the dispatch key suffix
# @param methodName the method name used to derive the R function name (snake_case or camelCase)
# @param pyParams parameter info list from getFunctionInfo: args, defaults, varargs, keywords
# @param pythonMethodName the original Python method name if it differs from methodName; defaults to methodName
# @param functionPrefix prefix prepended to the camelCase method name (default "syn")
# @param functionNameMapping optional list with an $explicit named character vector for overriding generated names
# @param isStatic if TRUE, registers a static wrapper that omits the instance argument
defineFunctionalClassMethod <- function(module, className, methodName, pyParams, pythonMethodName = NULL, functionPrefix = "syn", functionNameMapping = NULL, isStatic = FALSE) {
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
      staticFn <- function(...) {
        pyClass <- reticulate::py_eval(sprintf("%s.%s", module, className))
        argsAndKwArgs <- determineArgsAndKwArgs(...)
        returnedObject <- cleanUpStackTrace(gateway$invoke, list(
          method = list(pyClass, pythonMethodName),
          args   = argsAndKwArgs$args,
          kwargs = argsAndKwArgs$kwargs
        ))
        if (grepl("GeneratorWrapper", class(returnedObject)[1])) class(returnedObject)[1] <- "GeneratorWrapper"
        if (grepl("CsvFileTable", class(returnedObject)[1])) class(returnedObject)[1] <- "CsvFileTable"
        returnedObject
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
    returnedObject <- cleanUpStackTrace(gateway$invoke, list(
      method = list(instance, pythonMethodName),
      args   = argsAndKwArgs$args,
      kwargs = argsAndKwArgs$kwargs
    ))
    if (grepl("GeneratorWrapper", class(returnedObject)[1])) class(returnedObject)[1] <- "GeneratorWrapper"
    if (grepl("CsvFileTable", class(returnedObject)[1])) class(returnedObject)[1] <- "CsvFileTable"
    returnedObject
  }

  # Assign the inner worker function to the dispatch table under the key "<genericName>_<className>"
  assign(classMethodKey, classMethodFn, envir = .functionalMethodDispatch)

  # Register the generic once as a plain function
  if (!exists(genericName, mode = "function", inherits = TRUE)) {
    gn  <- genericName
    tbl <- .functionalMethodDispatch
    genericFn <- function(instance, ...) {
      # sys.call() captures the raw call so named formals (e.g. comment, label)
      # are forwarded to the inner worker
      call <- sys.call()
      call[[1]] <- as.name('list')
      dots <- eval.parent(call)
      if (length(dots) == 0) {
        stop(sprintf("Pass an object as the first argument, e.g. ClassName(...) |> %s()", gn))
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
    formals(genericFn) <- c(list(instance = quote(expr =)), methodArgs)
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
          defineClassMethod(module, setGenericCallback, c$name, method$name, method$args, method$name)
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
autoGenerateClassesWithFunctionalInterface <- function(module, setGenericCallback, classInfo, functionPrefix = "syn", functionNameMapping = NULL, verbose = FALSE) {
  for (c in classInfo) {
    # suppress output when loading package
    if (nzchar(Sys.getenv("R_INSTALL_PKG"))) cat(sprintf("Creating class wrapper for: %s\n", c$name))
    defineConstructor(module, setGenericCallback, c$name, c$constructorArgs)
    
    # Generate wrappers for class methods (excluding constructor)
    if (!is.null(c$methods)) {
      for (method in c$methods) {
        # Skip the constructor method (it has the same name as the class)
        if (method$name != c$name) {
          isStatic <- isTRUE(method$is_static)
          # Create both regular class method and functional interface
          #defineClassMethod(module, setGenericCallback, c$name, method$name, method$args, method$name)
          defineFunctionalClassMethod(module, c$name, method$name, method$args, method$name, functionPrefix, functionNameMapping, isStatic = isStatic)
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
defineFunction <- function(rName,
                           pyName,
                           functionContainerName,
                           pyParams,
                           setGenericCallback,
                           transformReturnObject = NULL) {
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
autoGenerateFunctions <- function(setGenericCallback,
                                  functionInfo,
                                  transformReturnObject = NULL) {
  for (f in functionInfo) {
    defineFunction(
      f$rName,
      f$pyName,
      f$functionContainerName,
      f$args,
      setGenericCallback,
      transformReturnObject
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
      paste(capitalizeFirstLetter(x), collapse="")
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
getFunctionInfo <- function(pyPkg,
                            module,
                            functionFilter = NULL,
                            functionPrefix = NULL,
                            pySingletonName = NULL) {
  .initPyPkgInfo(pyPkg)
  functionInfo <- reticulate::py_eval(sprintf("pyPkgInfo.getFunctionInfo(%s)", module))

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
  classInfo <- reticulate::py_eval(sprintf("pyPkgInfo.getClassInfo(%s)", module))
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
      if (is.null(valuenames) ||
        length(valuenames[[i]]) == 0 ||
        nchar(valuenames[[i]]) == 0) {
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

# The purpose of this function is to remove the Python stack trace from an error message
#  generated when calling Python from R. This makes the command line response more readable
#  when an error occurs. To support debugging the stack trace truncation can be overridden
#  by setting the global option 'verbose' to TRUE.
#
# @param callable the function to be called
# @param args the arguments to be passed to the function 'callable'
# @return the result of calling the given function with the given arguments
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

cleanUpStackTrace <- function(callable, args) {
  conn <- textConnection("outputCapture", open = "w", local = TRUE)
  sink(conn)
  tryCatch({
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
      splitArray <- strsplit(errorToReport,
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
#'   (e.g., synGetProject) in addition to regular class methods. Requires functionPrefix to be set.
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
generateRWrappers <- function(pyPkg,
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
                              functionNameMapping = NULL) {
  # validate the args
  reticulate::py_run_string("import inspect")
  reticulate::py_run_string(sprintf("import %s", pyPkg))
  isClass <- reticulate::py_eval(sprintf("inspect.isclass(%s)", container))
  if (isClass && is.null(pySingletonName))
    stop("`container` is a class, but `pySingtonName` is not specified.")
  if (!isClass && !is.null(pySingletonName))
    stop("`container` is not a class, but `pySingtonName` is specified.")
  if (is.null(assignEnumCallback) && !is.null(enumFilter))
    stop("`enumFilter` is specified, but `assignEnumCallback` is not.")

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
    transformReturnObject
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

# This is factored out of autoGenerateRdFiles so it can be called during testing
initAutoGenerateRdFiles <- function(templateDir) {
  dictDocString <<- getDictDocString(templateDir)
}

# This function generates R documentation (.Rd) files
#  (https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Rd-format) from
#  Python doc-strings using Sphinx tags (http://www.sphinx-doc.org). The files are
#  written to the directory /auto-man, allowing manual touch up prior to copying to
#  man/ (the standard location for R documentation).
#
# @param srcRootDir is the root directory for the code base (i.e., prior to installation)
# @param functionInfo list of functions for which to generate doc's
# @param classInfo list of classes for which to generate doc's
# @param templateDir (optional) custom templates for the docs
autoGenerateRdFiles <- function(srcRootDir,
                                functionInfo,
                                classInfo,
                                keepContent,
                                templateDir = NULL) {
  if (!file.exists(srcRootDir)) {
    stop(sprintf("%s does not exist.", srcRootDir))
  }
  if (is.null(templateDir)) {
    # use default templates
    templateDir <- system.file("templates", package = "SynapseR")
  }
  initAutoGenerateRdFiles(templateDir)

  targetFolder <- file.path(srcRootDir, "auto-man")
  if ((!keepContent) || (!file.exists(targetFolder))) {
    # start from a clean slate
    unlink(targetFolder, recursive = T, force = T)
    dir.create(targetFolder)
  }

  # create a list for the constructors that's structured the same as the info for the functions
  constructorInfo <- lapply(X = classInfo, function(x) {
    list(
      rName = x$name,
      args = x$constructorArgs,
      doc = x$doc,
      title = sprintf("Constructor for objects of type %s", x$name),
      returned = sprintf("An object of type %s", x$name)
    )
  })
  # create doc's for all functions and constructors
  for (f in c(functionInfo, constructorInfo)) {
    name <- f$rName
    args <- f$args
    doc <- f$doc
    title <- f$title
    if (is.null(f$returned)) {
      returned <- getReturned(doc)
    } else {
      returned <- f$returned
    }
    tryCatch({
      argDescriptionsFromDoc <- parseArgDescriptionsFromDetails(doc)
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
        returned = returned
      )
      # make sure all place holders were replaced
      p <- regexpr("##(title|description|usage|arguments|value|examples)##", content)[1]
      # TODO: This is an issue in some of the legacy objects where this is failing. More work is needed to determine why this fails
      # if (p > 0) stop(sprintf("Failed to replace all placeholders in %s.Rd", name))
      writeContent(content, name, targetFolder)
    },
    error = function(e) {
      stop(sprintf("Error generating doc for %s: %s\n", name, e[[1]]))
    }
    )
  }

  for (c in classInfo) {
    tryCatch({
      content <- createClassRdContent(
        templateDir = templateDir,
        alias = paste0(c$name, "-class"),
        title = c$name,
        description = c$doc,
        methods = lapply(
          X = c$methods,
          function(x) {
            argDescriptionsFromDoc <- parseArgDescriptionsFromDetails(x$doc)
            list(
              name = x$name,
              description = x$doc,
              args = x$args,
              argDescriptionsFromDoc = argDescriptionsFromDoc
            )
          }
        )
      )
      p <- regexpr("##(alias|title|description|methods)##", content)[1]
      # TODO: This is an issue in some of the legacy objects where this is failing. More work is needed to determine why this fails
      # if (p > 0) stop(sprintf("Failed to replace all placeholders in %s.Rd", name))
      writeContent(content, paste0(c$name, "-class"), targetFolder)
    },
    error = function(e) {
      stop(sprintf("Error generating doc for %s: %s\n", name, e[[1]]))
    }
    )
  }
}

# create the 'usage' section of the doc
# this is also used to document the 'methods' of a class
usage <- function(name, args, argDescriptionsFromDoc) {
  argNames <- args$args
  defaults <- args$defaults
  result <- NULL
  if (length(argNames) > 0) {
    # self can be the first arg of a method or function, typ can be the first arg of a constructor
    if (argNames[1] != "self" && argNames[1] != "typ") argStart <- 1 else argStart <- 2
    if (argStart <= length(argNames)) {
      for (i in argStart:length(argNames)) {
        argName <- argNames[[i]]
        defaultIndex <- i + length(defaults) - length(argNames)
        if (defaultIndex > 0) {
          result <- append(result, sprintf("%s=%s", argName, defaults[defaultIndex]))
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
    result <- append(result, lapply(
      names(argDescriptionsFromDoc),
      function(x) {
        sprintf("%s=NULL", x)
      }
    ))
  }
  sprintf("%s(%s)", name, paste(result, collapse = ", "))
}

# create a named list of arguments and their descriptions
# suitable for use in the arguments section
# argNames is the list of explicit arguments from inspecting the function
# argDescriptionsFromDoc is the result of parsing the docstring, looking for parameters
formatArgsForArgumentSection <- function(argNames, argDescriptionsFromDoc) {
  result <- NULL
  if (length(argNames) > 0) {
    if (argNames[1] != "self" && argNames[1] != "typ") argStart <- 1 else argStart <- 2
    if (argStart <= length(argNames)) {
      for (i in argStart:length(argNames)) {
        argName <- argNames[[i]]
        argDescription <- argDescriptionsFromDoc[[argName]]
        # remove it from the list of arguments mentioned in the docstring
        argDescriptionsFromDoc[[argName]] <- NULL
        if (is.null(argDescription)) argDescription <- ""
        result <- append(result, sprintf("\\item{%s}{%s}", argName, argDescription))
      }
    }
  }
  # are there any remaining arguments, not included in the argument list?
  # if so, they are kwargs / named parameters
  if (length(argDescriptionsFromDoc) > 0) {
    result <- append(result, lapply(
      names(argDescriptionsFromDoc),
      function(x) {
        sprintf("\\item{%s}{optional named parameter: %s}", x, argDescriptionsFromDoc[[x]])
      }
    ))
  }
  paste(result, collapse = "\n")
}

getDictDocString <- function(templateDir) {
  file <- sprintf("%s/dictDocString.txt", templateDir)
  connection <- file(file, open = "r")
  result <- paste(readLines(connection), collapse = "\n")
  close(connection)
  result
}

# any conversion of Sphinx text to Latex text goes here
convertSphinxToLatex <- function(raw) {
  changeSphinxHyperlinksToLatex(raw)
}

changeSphinxHyperlinksToLatex <- function(raw) {
  gsub("`([^<\n]*) <([^>\n]*)>`_", "\\\\href{\\2}{\\1}", raw)
}

insertLatexNewLines <- function(raw) {
  gsub("\n", "\\cr\n", raw, fixed = TRUE)
}

# returns a named list in which the names are arguments
# and the values are their descriptions
parseArgDescriptionsFromDetails <- function(raw) {
  # escape any escaped-escapes
  preprocessed <- gsub("\\\\", "\\\\\\\\", raw)
  # change all quotes to escaped quotes
  preprocessed <- gsub("\"", "\\\\\"", preprocessed)
  # change \r\n to \n
  preprocessed <- gsub("\r\n", "\n", preprocessed)

  # find parameters and convert them, along with their def'ns, to json
  # reminder: \w in a regexp means "word character", [A-Za-z0-9_]
  json <- gsub(":(parameter|param|var) (\\w+):", "\",\"\\2\":\"", preprocessed)
  # prepend "{\"unusedPrefix\":\""
  # add "\"}" to the end
  json <- paste0("{\"unusedPrefix\":\"", json, "\"}")
  # parse JSON into named list
  paramsList <- fromJSON(json)
  # truncate each entry at end
  result <- lapply(
    X = paramsList,
    function(x) {
      p <- regexpr("\n\n|\n:returns?:|\n[Ee]xample:", x)[1]
      if (p < 0) {
        result <- x
      } else {
        result <- substr(x, 1, p - 1)
      }
      # now do any conversion of the description
      result <- pyVerbiageToLatex(result)
      result <- insertLatexNewLines(result)
      result
    }
  )
  result$unusedPrefix <- NULL
  if (length(names(result)) != length(unique(names(result)))) {
    message(sprintf("Warning:  encountered repeated function arguments definitions in docstring: %s", raw))
  }
  result
}

pyVerbiageToLatex <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) return("")
  # this replaces ':param <param name>:' with '\nparam name:'
  # same for parameter, type, var
  result <- raw
  result <- gsub(":(parameter|param|var) (\\w+):", "\n\\2:", result)
  # Reminder:  \\S means 'not whitespace'
  result <- gsub(":py:class:`(\\S+\\.)*(\\S+)`", "\\2", result)

  convertToUpper <- "##convertToUpper##" # marks character to convert
  result <- gsub(":py:mod:`(\\S+\\.)*(\\S+)`", paste0(convertToUpper, "\\2"), result)
  # anything else we simply leave in place for manual curation:
  result <- gsub(":py:(func|meth):`([^`]*)`", "\\2", result)

  while (TRUE) {
    ctuIndex <- regexpr(convertToUpper, result)[[1]]
    if (ctuIndex < 0) break
    lcChar <- nchar(convertToUpper) + ctuIndex
    # Check if lcChar is beyond the string length
    if (lcChar > nchar(result)) {
      # If marker is at the end, just remove it
      result <- substring(result, 1, ctuIndex - 1)
    } else {
      result <- paste0(
        substring(result, 1, ctuIndex - 1),
        toupper(substring(result, lcChar, lcChar)),
        substring(result, lcChar + 1)
      )
    }
  }

  result <- convertSphinxToLatex(result)
}

getDescription <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) return("")
  preprocessed <- gsub("\r\n", "\n", raw, fixed = TRUE)
  # find everything up to the first syphinx token following the description
  terminatorIndex <- regexpr("\n*:(parameter|param|type|var)|\n*?:returns?:|\n{1,}[Ee]xample:", preprocessed)[1]
  if (terminatorIndex < 1) return(preprocessed)
  substr(preprocessed, 1, terminatorIndex - 1)
}

getReturned <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) return("")
  preprocessed <- gsub("\r\n", "\n", raw, fixed = TRUE)
  if (!grepl(":returns?:", preprocessed)) return("")
  # get whatever follows :return: or :returns:
  result <- gsub(".*:returns?:(.*)", "\\1", preprocessed)
  # check for any trailing content
  doubleNewLineIndex <- regexpr("\n\n", result)[1]
  if (doubleNewLineIndex <= 1) return(result)
  substr(result, 1, doubleNewLineIndex - 1)
}

getExample <- function(raw) {
  if (missing(raw) || is.null(raw) || length(raw) == 0 || nchar(raw) == 0) return("")
  preprocessed <- gsub("\r\n", "\n", raw, fixed = TRUE)
  pattern <- ".*[Ee]xample::?\n\n(.*)"
  if (!grepl(pattern, preprocessed)) return("")
  result <- gsub(pattern, "\\1", preprocessed)
  # check for any trailing content
  doubleNewLineIndex <- regexpr("\n\n", result)[1]
  if (doubleNewLineIndex <= 1) return(result)
  substr(result, 1, doubleNewLineIndex - 1)
}

createFunctionRdContent <- function(templateDir, alias, title, description, usage, argument, returned) {
  templateFile <- sprintf("%s/rdFunctionTemplate.Rd", templateDir)
  connection <- file(templateFile, open = "r")
  template <- paste(readLines(connection), collapse = "\n")
  close(connection)

  content <- template
  content <- gsub("##alias##", alias, content, fixed = TRUE)
  if (!missing(title) && !is.null(title)) content <- gsub("##title##", title, content, fixed = TRUE)
  examples <- NULL
  if (!missing(description) && !is.null(description)) {
    processedDescription <- pyVerbiageToLatex(getDescription(description))
    content <- gsub("##description##", processedDescription, content, fixed = TRUE)
    examples <- pyVerbiageToLatex(getExample(description))
  } else {
    content <- gsub("##description##", "", content, fixed = TRUE)
  }
  if (!missing(returned) && !is.null(returned)) {
    value <- pyVerbiageToLatex(returned)
    content <- gsub("##value##", value, content, fixed = TRUE)
  } else {
    content <- gsub("##value##", "", content, fixed = TRUE)
  }
  if (!missing(usage) && !is.null(usage)) content <- gsub("##usage##", usage, content, fixed = TRUE)
  if (!missing(argument) && !is.null(argument)) content <- gsub("##arguments##", argument, content, fixed = TRUE)
  if (!is.null(examples) && length(examples) > 0 && nchar(examples) > 0) {
    content <- paste(content, "\n\\examples{\n##examples##\n}", collapse = "\n")
    # we comment out the examples which come from the Python client and need to be curated
    content <- gsub("##examples##", paste0("%\\dontrun{\n%", gsub("\n", "\n%", examples), "\n%}"), content, fixed = TRUE)
  }
  content
}

createMethodContent <- function(f) {
  paste0("\\item \\code{", usage(f$name, f$args, f$argDescriptionsFromDoc), "}: ", f$description)
}

createClassRdContent <- function(templateDir, alias, title, description, methods) {
  templateFile <- sprintf("%s/rdClassTemplate.Rd", templateDir)
  connection <- file(templateFile, open = "r")
  template <- paste(readLines(connection), collapse = "\n")
  close(connection)

  content <- template
  content <- gsub("##alias##", alias, content, fixed = TRUE)
  if (!missing(title) && !is.null(title)) content <- gsub("##title##", title, content, fixed = TRUE)
  if (!missing(description) && !is.null(description)) {
    processedDescription <- pyVerbiageToLatex(getDescription(description))
    content <- gsub("##description##", processedDescription, content, fixed = TRUE)
  }
  methodContent <- NULL
  for (method in methods) {
    methodDescription <- method$description
    if (method$name == title) {
      method$description <- sprintf("Constructor for \\code{\\link{%s}}", title)
    } else {
      if (!is.null(methodDescription)) {
        methodDescription <- pyVerbiageToLatex(getDescription(methodDescription))
        methodDescription <- insertLatexNewLines(methodDescription)
        method$description <- methodDescription
      }
    }
    methodContent <- c(methodContent, createMethodContent(method))
  }
  content <- gsub("##methods##", paste(methodContent, collapse = "\n"), content, fixed = TRUE)
  content
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
#'   functions (e.g., synGetProject) in addition to regular class methods. Requires functionPrefix to be set.
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
#' # 4. Generate docs including functional interface functions (e.g., synDatasetGet, synProjectStore)
#' generateRdFiles(
#'   srcRootDir = "path/to/R/pkg",
#'   pyPkg = "pyPackageName",
#'   container = "pyPackageName.aModuleInPyPackageName",
#'   functionPrefix = "syn",
#'   generateFunctionalInterface = TRUE)
#' @md
generateRdFiles <- function(srcRootDir,
                            pyPkg,
                            container,
                            functionFilter = NULL,
                            classFilter = NULL,
                            functionPrefix = NULL,
                            keepContent = FALSE,
                            templateDir = NULL,
                            generateFunctionalInterface = FALSE,
                            functionNameMapping = NULL) {

  functionInfo <- getFunctionInfo(pyPkg, container, functionFilter, functionPrefix)
  classInfo <- getClassInfo(pyPkg, container, classFilter)
  
  # Generate functional interface function info if requested
  functionalInterfaceInfo <- list()
  if (generateFunctionalInterface && !is.null(functionPrefix)) {
    functionalInterfaceInfo <- generateFunctionalInterfaceInfo(classInfo, functionPrefix, functionNameMapping)
  }
  
  # Combine all function info (regular functions + functional interface functions)
  allFunctionInfo <- c(functionInfo, functionalInterfaceInfo)

  autoGenerateRdFiles(srcRootDir, allFunctionInfo, classInfo, keepContent, file.path(srcRootDir, "inst", "templates"))
}

# Helper function to generate functional interface function info for documentation
#
# @param classInfo the classes to extract functional interface info from
# @param functionPrefix the prefix to add to functional method names (e.g., "syn")
# @param functionNameMapping the mapping configuration for customizing function names
generateFunctionalInterfaceInfo <- function(classInfo, functionPrefix = "syn", functionNameMapping = NULL) {
  functionalInfo <- list()
  
  for (c in classInfo) {
    # Generate info for class methods (excluding constructor)
    if (!is.null(c$methods)) {
      for (method in c$methods) {
        # Skip the constructor method (it has the same name as the class)
        if (method$name != c$name) {
          # Generic name — no class suffix; dispatch table routes per class
          defaultGenericName <- paste0(functionPrefix, snakeToCamel(method$name))
          functionalRFunctionName <- applyFunctionNameMapping(
            defaultGenericName,
            functionNameMapping
          )

          # Strip 'self' from args — instance is not a named formal
          modifiedArgs <- method$args
          if (!is.null(modifiedArgs) && "self" %in% modifiedArgs$args) {
            modifiedArgs$args <- modifiedArgs$args[modifiedArgs$args != "self"]
          }

          functionalFunctionInfo <- list(
            pyName = method$name,
            rName = functionalRFunctionName,   # public generic, e.g. "synStore"
            targetClass = c$name,              # e.g. "File" — which class this entry covers
            functionContainerName = paste0(c$name, ".", method$name),
            args = modifiedArgs,
            doc = method$doc,
            title = paste("Functional interface for", c$name, method$name, "method"),
            returned = paste("Result of calling", method$name, "method on", c$name, "instance")
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

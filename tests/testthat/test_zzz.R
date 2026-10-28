# One way to run the test is to run the test using devtools::test(filter = "zzz")
# from the synapser package directory.

context("test package initialization helpers in R/zzz.R")

# The helpers in R/zzz.R bind into environment(sys.function()) or .NAMESPACE,
# which is the sealed package namespace once synapser is installed. Each test
# below rebinds a copy of the helper to a throwaway child of the namespace, so
# writes land there and nothing leaks into the real namespace.
.zzzNs <- environment(.defineOperationsFallbacks)

.rebind <- function(fn, env) {
  environment(fn) <- env
  fn
}

# ---------------------------------------------------------------------------
# .onLoad side effects
# ---------------------------------------------------------------------------

test_that(".onLoad exposes the Synapse singleton as syn in the global env", {
  # syn <<- has no binding to find in the namespace, so it lands in globalenv.
  expect_true(exists("syn", envir = globalenv(), inherits = FALSE))
  expect_true(inherits(
    get("syn", envir = globalenv()),
    "synapseclient.client.Synapse"
  ))
})

test_that(".onLoad prefixes the Python User-Agent with the synapser version", {
  userAgent <- reticulate::py_eval("synapseclient.USER_AGENT['User-Agent']")
  expected <- sprintf("synapser/%s ", utils::packageVersion("synapser"))
  expect_true(startsWith(userAgent, expected))
})

test_that(".onLoad forces single-threaded mode in synapseclient", {
  expect_true(reticulate::py_eval("synapseclient.core.config.single_threaded"))
})

# Returns a copy of .onLoad whose package-side helpers are no-ops and whose
# syn <<- lands in a local binding instead of overwriting the real global syn.
# reticulate itself is mocked by the caller.
.isolatedOnLoad <- function() {
  localNs <- new.env(parent = .zzzNs)
  for (helper in c(
    ".addPythonAndFoldersToSysPath",
    ".defineRPackageFunctions",
    ".defineOverloadFunctions"
  )) {
    assign(helper, function(...) NULL, envir = localNs)
  }
  assign("syn", NULL, envir = localNs)
  .rebind(get(".onLoad", envir = .zzzNs), localNs)
}

test_that(".onLoad reinstalls the pinned synapseclient when the import fails", {
  onLoad <- .isolatedOnLoad()
  imports <- 0
  installed <- list()
  local_mocked_bindings(
    py_require = function(...) NULL,
    py_install = function(packages, ...) {
      installed[[length(installed) + 1]] <<- packages
    },
    py_run_string = function(code, ...) {
      if (code == "import synapseclient") {
        imports <<- imports + 1
        if (imports == 1) stop("No module named 'synapseclient'")
      }
      NULL
    },
    py_eval = function(...) NULL,
    .package = "reticulate"
  )

  onLoad(NULL, "synapser")

  expect_equal(2, imports)
  expect_equal(
    list(paste0("synapseclient[pandas]==", PYTHON_CLIENT_VERSION)),
    installed
  )
})

test_that(".onLoad surfaces the error when the import still fails after reinstall", {
  onLoad <- .isolatedOnLoad()
  local_mocked_bindings(
    py_require = function(...) NULL,
    py_install = function(...) NULL,
    py_run_string = function(code, ...) {
      if (code == "import synapseclient") {
        stop("No module named 'synapseclient'")
      }
      NULL
    },
    .package = "reticulate"
  )

  expect_error(onLoad(NULL, "synapser"), "No module named 'synapseclient'")
})

# ---------------------------------------------------------------------------
# .setGenericCallback
# ---------------------------------------------------------------------------

test_that(".setGenericCallback assigns tagged constructors directly", {
  localNs <- new.env(parent = .zzzNs)
  cb <- .rebind(.setGenericCallback, localNs)

  def <- function(...) "constructed"
  class(def) <- c("Team", "function")
  expect_null(cb("Team", def))

  expect_true(exists("Team", envir = localNs, inherits = FALSE))
  registered <- get("Team", envir = localNs)
  # The class tag doubles as the classmethod dispatch marker, so it must
  # survive registration.
  expect_equal(c("Team", "function"), class(registered))
  expect_equal("constructed", registered())
})

test_that(".setGenericCallback re-locks a previously locked binding", {
  localNs <- new.env(parent = .zzzNs)
  cb <- .rebind(.setGenericCallback, localNs)

  assign("Team", function() "old", envir = localNs)
  lockBinding("Team", localNs)

  def <- function() "new"
  class(def) <- c("Team", "function")
  cb("Team", def)

  expect_equal("new", get("Team", envir = localNs)())
  expect_true(bindingIsLocked("Team", localNs))
})

test_that(".setGenericCallback leaves an unlocked binding unlocked", {
  localNs <- new.env(parent = .zzzNs)
  cb <- .rebind(.setGenericCallback, localNs)

  assign("Team", function() "old", envir = localNs)

  def <- function() "new"
  class(def) <- c("Team", "function")
  cb("Team", def)

  expect_equal("new", get("Team", envir = localNs)())
  expect_false(bindingIsLocked("Team", localNs))
})

test_that(".setGenericCallback routes plain functions through setGeneric", {
  # setGeneric() registers in topenv() of the caller, so give the copy a
  # global-env parent rather than the sealed namespace.
  localEnv <- new.env(parent = globalenv())
  cb <- .rebind(.setGenericCallback, localEnv)
  name <- "synZzzTestGeneric"
  on.exit(suppressWarnings(methods::removeGeneric(name, where = globalenv())), add = TRUE)

  suppressMessages(cb(name, function(x) standardGeneric("synZzzTestGeneric")))

  expect_true(methods::isGeneric(name, where = globalenv()))
  expect_false(exists(name, envir = localEnv, inherits = FALSE))
})

# ---------------------------------------------------------------------------
# .assignEnumCallback
# ---------------------------------------------------------------------------

test_that(".assignEnumCallback assigns a named vector into .NAMESPACE", {
  localNs <- new.env(parent = .zzzNs)
  target <- new.env(parent = emptyenv())
  assign(".NAMESPACE", target, envir = localNs)
  cb <- .rebind(.assignEnumCallback, localNs)

  cb("MyEnum", c("KEY1", "KEY2"), c(1L, 2L))

  expect_equal(c(KEY1 = 1L, KEY2 = 2L), get("MyEnum", envir = target))
})

# ---------------------------------------------------------------------------
# .defineRPackageFunctions
# ---------------------------------------------------------------------------

test_that(".defineRPackageFunctions wraps operations before models, then installs fallbacks", {
  localNs <- new.env(parent = .zzzNs)
  calls <- list()
  assign("generateRWrappers", function(...) {
    calls[[length(calls) + 1]] <<- list(...)
  }, envir = localNs)
  assign(".defineOperationsFallbacks", function() {
    calls[[length(calls) + 1]] <<- "fallbacks"
  }, envir = localNs)
  fn <- .rebind(.defineRPackageFunctions, localNs)

  fn()

  expect_length(calls, 4)
  containers <- vapply(calls[1:3], function(x) x$container, character(1))
  # synapseclient.operations must be wrapped before synapseclient.models; the
  # fallback shim depends on that order (see the comment above
  # .defineOperationsFallbacks in R/zzz.R).
  expect_equal(
    c(
      "synapseclient.Synapse",
      "synapseclient.operations",
      "synapseclient.models"
    ),
    containers
  )
  expect_equal("fallbacks", calls[[4]])

  for (x in calls[1:3]) {
    expect_equal("syn", x$functionPrefix)
    expect_identical(.setGenericCallback, x$setGenericCallback)
    expect_identical(.assignEnumCallback, x$assignEnumCallback)
  }
  expect_equal("syn", calls[[1]]$pySingletonName)
  expect_true(calls[[3]]$generateFunctionalInterface)
})

# ---------------------------------------------------------------------------
# .defineOperationsFallbacks
# ---------------------------------------------------------------------------

# Builds an isolated namespace holding fake synGet/synStore/synDelete
# factories and private dispatch tables, and returns it alongside a copy of
# .defineOperationsFallbacks bound to it.
.fallbackFixture <- function(generics = c("synGet", "synStore", "synDelete")) {
  localNs <- new.env(parent = .zzzNs)
  dispatch <- new.env(parent = emptyenv())
  classLevel <- new.env(parent = emptyenv())
  assign(".functionalMethodDispatch", dispatch, envir = localNs)
  assign(".functionalMethodIsClassLevel", classLevel, envir = localNs)
  assign(
    ".isClassLevelFunctionalMethod",
    .rebind(.isClassLevelFunctionalMethod, localNs),
    envir = localNs
  )

  factoryFormals <- list(
    synGet = alist(synapse_id = NULL, entity = NULL, version_number = NULL),
    synStore = alist(entity = NULL, parent = NULL),
    synDelete = alist(entity = NULL, version_only = FALSE)
  )
  for (gn in generics) {
    # The factory reports back exactly the arguments it was called with.
    factory <- function() {
      supplied <- as.list(match.call())[-1]
      list(via = "factory", args = lapply(supplied, eval, parent.frame()))
    }
    formals(factory) <- c(factoryFormals[[gn]], alist(... = ))
    assign(gn, factory, envir = localNs)
  }

  list(
    ns = localNs,
    dispatch = dispatch,
    classLevel = classLevel,
    define = .rebind(.defineOperationsFallbacks, localNs)
  )
}

.fakeInstance <- function(className) {
  structure(list(), class = className)
}

test_that(".defineOperationsFallbacks adds the extra formals each generic needs", {
  fx <- .fallbackFixture()
  fx$define()

  expect_equal(
    c("synapse_id", "entity", "version_number", "...", "owner_id", "id", "offset", "limit"),
    names(formals(get("synGet", envir = fx$ns)))
  )
  expect_equal(0, formals(get("synGet", envir = fx$ns))$offset)
  expect_equal(20, formals(get("synGet", envir = fx$ns))$limit)
  expect_equal(
    c("entity", "parent", "..."),
    names(formals(get("synStore", envir = fx$ns)))
  )
  expect_equal(
    c("entity", "version_only", "...", "parent"),
    names(formals(get("synDelete", envir = fx$ns)))
  )
})

test_that(".defineOperationsFallbacks skips generics that were never defined", {
  fx <- .fallbackFixture(generics = "synGet")
  expect_error(fx$define(), NA)
  expect_false(exists("synStore", envir = fx$ns, inherits = FALSE))
  expect_false(exists("synDelete", envir = fx$ns, inherits = FALSE))
})

test_that(".defineOperationsFallbacks defers to the factory with no registered worker", {
  fx <- .fallbackFixture()
  fx$define()
  synGet <- get("synGet", envir = fx$ns)

  result <- synGet(synapse_id = "syn123")

  expect_equal("factory", result$via)
  # Only the supplied argument is forwarded; unsupplied formals such as
  # offset/limit must not materialise with their defaults.
  expect_equal(list(synapse_id = "syn123"), result$args)
})

test_that(".defineOperationsFallbacks forwards a positional Synapse ID to the factory", {
  fx <- .fallbackFixture()
  fx$define()
  synGet <- get("synGet", envir = fx$ns)

  # The common synGet("syn123") call looks up synGet_character, which is
  # never registered, so it must fall through with the ID intact.
  result <- synGet("syn123")

  expect_equal("factory", result$via)
  expect_equal(list(synapse_id = "syn123"), result$args)
})

test_that(".defineOperationsFallbacks defers to the factory when called with no arguments", {
  fx <- .fallbackFixture()
  fx$define()
  synStore <- get("synStore", envir = fx$ns)

  result <- synStore()

  expect_equal("factory", result$via)
  expect_length(result$args, 0)
})

test_that(".defineOperationsFallbacks routes instance-level workers with the instance", {
  fx <- .fallbackFixture()
  received <- NULL
  assign("synDelete_Activity", function(...) {
    received <<- list(...)
    "worker"
  }, envir = fx$dispatch)
  assign("synDelete_Activity", FALSE, envir = fx$classLevel)
  fx$define()
  synDelete <- get("synDelete", envir = fx$ns)

  instance <- .fakeInstance("Activity")
  expect_equal("worker", synDelete(instance, parent = "syn123"))
  expect_equal(list(instance, parent = "syn123"), received)
})

test_that(".defineOperationsFallbacks drops the dispatch marker for class-level workers", {
  fx <- .fallbackFixture()
  received <- NULL
  assign("synGet_WikiHeader", function(...) {
    received <<- list(...)
    "worker"
  }, envir = fx$dispatch)
  assign("synGet_WikiHeader", TRUE, envir = fx$classLevel)
  fx$define()
  synGet <- get("synGet", envir = fx$ns)

  marker <- .fakeInstance("WikiHeader")
  expect_equal("worker", synGet(marker, owner_id = "syn123", limit = 5))
  expect_equal(list(owner_id = "syn123", limit = 5), received)
})

test_that(".defineOperationsFallbacks dispatches only on the first class", {
  fx <- .fallbackFixture()
  assign("synGet_Base", function(...) "worker", envir = fx$dispatch)
  fx$define()
  synGet <- get("synGet", envir = fx$ns)

  result <- synGet(structure(list(), class = c("Derived", "Base")))

  expect_equal("factory", result$via)
})

test_that(".defineOperationsFallbacks preserves the binding lock state", {
  fx <- .fallbackFixture()
  lockBinding("synGet", fx$ns)
  fx$define()

  expect_true(bindingIsLocked("synGet", fx$ns))
  expect_false(bindingIsLocked("synStore", fx$ns))
  expect_true("owner_id" %in% names(formals(get("synGet", envir = fx$ns))))
})

test_that("installed synGet/synStore/synDelete carry the fallback formals", {
  expect_true(all(c("owner_id", "id", "offset", "limit") %in% names(formals(synGet))))
  expect_true("parent" %in% names(formals(synDelete)))
})

test_that("every method routed past synapseclient.operations has a registered worker", {
  # Without a worker, the installed shim silently falls back to the factory,
  # which does not support these model classes.
  generics <- c(get = "synGet", store = "synStore", delete = "synDelete")
  for (cls in names(.operationsUnsupportedModelMethods)) {
    for (method in .operationsUnsupportedModelMethods[[cls]]) {
      key <- paste0(generics[[method]], "_", cls)
      expect_true(
        exists(key, envir = .functionalMethodDispatch, inherits = FALSE),
        info = key
      )
    }
  }
})

# ---------------------------------------------------------------------------
# .onAttach
# ---------------------------------------------------------------------------

test_that(".onAttach checks for updates and shows the terms of use", {
  localNs <- new.env(parent = .zzzNs)
  checked <- FALSE
  assign(".checkForUpdate", function() checked <<- TRUE, envir = localNs)
  # testthat does not expose .onAttach to the test env, so fetch it directly.
  onAttach <- .rebind(get(".onAttach", envir = .zzzNs), localNs)

  expect_message(onAttach(NULL, "synapser"), "TERMS OF USE NOTICE")
  expect_true(checked)
})

# ---------------------------------------------------------------------------
# .defineOverloadFunctions
# ---------------------------------------------------------------------------

test_that(".defineOverloadFunctions registers GeneratorWrapper methods", {
  expect_true(methods::isClass("GeneratorWrapper"))
  expect_true(methods::isGeneric("nextElem"))
  expect_true(methods::existsMethod("nextElem", "GeneratorWrapper"))
  expect_true(methods::existsMethod("as.list", "GeneratorWrapper"))
})

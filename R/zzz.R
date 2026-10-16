# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) {
  # Declares the requirement before any Python call so reticulate's
  # uv-managed ephemeral environment resolves it up front, instead of
  # provisioning a fresh empty environment for this process.
  reticulate::py_require(
    paste("synapseclient[pandas]==", PYTHON_CLIENT_VERSION, sep = "")
  )

  tryCatch(
    {
      reticulate::py_run_string("import synapseclient")
    },
    error = function(e) {
      # Fallback for when Python was already initialized (e.g. a
      # persistent venv via RETICULATE_PYTHON) before py_require() above
      # could take effect.
      reticulate::py_install(
        c(paste("synapseclient[pandas]==", PYTHON_CLIENT_VERSION, sep = "")),
        pip = T
      )
      reticulate::py_run_string("import synapseclient")
    }
  )

  reticulate::py_run_string(sprintf(
    "synapserVersion = 'synapser/%s' ",
    utils::packageVersion("synapser")
  ))
  reticulate::py_run_string(
    "synapseclient.USER_AGENT['User-Agent'] = synapserVersion + ' '+ synapseclient.USER_AGENT['User-Agent']"
  )
  reticulate::py_run_string("synapseclient.core.config.single_threaded = True")
  reticulate::py_run_string(
    "syn=synapseclient.Synapse(skip_checks=True, debug=False)"
  )
  # make syn available in the global environment
  syn <<- reticulate::py_eval("syn")

  .addPythonAndFoldersToSysPath(system.file(package = "synapser"))
  .defineRPackageFunctions()
  # .defineOverloadFunctions() must come AFTER .defineRPackageFunctions()
  # because it redefines selected generic functions
  .defineOverloadFunctions()

  # mute Python warnings
  reticulate::py_run_string("import warnings")
  reticulate::py_run_string("warnings.filterwarnings('ignore')")
  reticulate::py_run_string(
    "warnings.showwarning = lambda *args, **kwargs: None"
  )
}

.setGenericCallback <- function(name, def) {
  # defineConstructor tags a constructor's class() with its own Python class
  # name (e.g. class(Team) <- c("Team", ...)) so it can double as a
  # classmethod/staticmethod dispatch marker (see defineFunctionalClassMethod).
  # Constructors have exactly one implementation per class name, so they
  # don't need real S4 multiple dispatch: register them as plain functions
  # directly instead of routing them through methods::setGeneric().
  #
  # This used to strip the tag, call setGeneric(), then reapply class(def)
  # to the registered generic to restore the marker.
  if (!identical(class(def), "function")) {
    ns <- environment(sys.function())
    # bindingIsLocked() errors on a name with no existing binding, which is
    # the common case here (first time this class name is registered).
    wasLocked <- exists(name, envir = ns, inherits = FALSE) &&
      bindingIsLocked(name, ns)
    if (wasLocked) {
      unlockBinding(name, ns)
    }
    assign(name, def, envir = ns)
    if (wasLocked) {
      lockBinding(name, ns)
    }
    return(invisible(NULL))
  }
  methods::setGeneric(name, def)
}

.NAMESPACE <- environment()
.assignEnumCallback <- function(name, keys, values) {
  assign(name, setNames(values, keys), .NAMESPACE)
}

.defineRPackageFunctions <- function() {
  # exposing all Synapse's methods without exposing the Synapse object
  generateRWrappers(
    pyPkg = "synapseclient",
    container = "synapseclient.Synapse",
    setGenericCallback = .setGenericCallback,
    assignEnumCallback = .assignEnumCallback,
    functionFilter = .synapseClassFunctionFilter,
    functionPrefix = "syn",
    pySingletonName = "syn",
    functionNameMapping = .functionNameMappingSynapse()
  )
  reticulate::py_run_string("import synapseclient.operations")
  generateRWrappers(
    pyPkg = "synapseclient",
    container = "synapseclient.operations",
    setGenericCallback = .setGenericCallback,
    assignEnumCallback = .assignEnumCallback,
    functionFilter = .operationsFunctionNamesFilter,
    classFilter = .operationsClassFilter,
    functionPrefix = "syn"
  )
  generateRWrappers(
    pyPkg = "synapseclient.models",
    container = "synapseclient.models",
    setGenericCallback = .setGenericCallback,
    assignEnumCallback = .assignEnumCallback,
    functionFilter = .modelsFunctionFilter,
    classFilter = .synapseModelClassFilter,
    functionPrefix = "syn",
    generateFunctionalInterface = TRUE,
    functionNameMapping = .functionNameMappingSynapseclientModels()
  )
  # Must come AFTER the synapseclient.models call above, which is what
  # populates .functionalMethodDispatch with the model-level workers.
  .defineOperationsFallbacks()
}

# TEMPORARY WORKAROUND -- companion to .operationsUnsupportedModelMethods in
# R/shared.R. Re-points synGet/synStore/synDelete at a shim that prefers a
# model class's own method when one is registered, and otherwise defers to the
# synapseclient.operations factory exactly as before.
#
# This is needed because defineFunctionalClassMethod only installs its
# dispatching generic when the name is still free:
#
#   if (!exists(genericName, mode = "function", inherits = TRUE))
#
# and .defineRPackageFunctions() wraps synapseclient.operations BEFORE
# synapseclient.models, so synGet/synStore/synDelete are already bound to the
# plain factory wrappers by then. Without this shim the model workers are
# registered in .functionalMethodDispatch but never reachable.
#
# Note: this is load-order-fragile by construction. If the generateRWrappers
# calls above are ever reordered so that models comes first, the generic will
# register itself and this shim becomes a harmless no-op pass-through.
#
# Two generics gain formals the factory does not have, because a routed model
# method requires them. Derived against synapseclient 4.14.0 by unioning every
# routed method's parameters and subtracting the factory's formals:
#
#   synGet    owner_id, id, offset, limit -- WikiHeader$get and
#             WikiHistorySnapshot$get are classmethods that page through a
#             wiki's headers/history rather than fetching by Synapse ID.
#   synDelete parent                      -- Activity$delete disassociates from
#             the parent entity and then deletes it.
#
# synStore needs nothing added: Activity$store wants `parent`, which the store
# factory already has. Re-run that derivation whenever
# .operationsUnsupportedModelMethods gains a class.
.defineOperationsFallbacks <- function() {
  ns <- environment(sys.function())
  extraFormals <- list(
    synGet = alist(owner_id = NULL, id = NULL, offset = 0, limit = 20),
    synStore = NULL,
    synDelete = alist(parent = NULL)
  )

  for (generic in c("synGet", "synStore", "synDelete")) {
    # Defensive: this runs during .onLoad, so a missing name must not abort
    # package load. All three are produced by the synapseclient.operations
    # wrapper above, but that depends on .operationsFunctionNames.
    if (!exists(generic, envir = ns, inherits = FALSE)) {
      next
    }
    local({
      gn <- generic
      fallback <- get(gn, envir = ns)
      tbl <- .functionalMethodDispatch

      shim <- function(...) {
        # Re-evaluate the raw call as list(...) so that ONLY the arguments the
        # caller actually supplied are forwarded. This is what lets one shared
        # signature serve methods with different parameter sets: an unsupplied
        # formal never materialises, so e.g. WikiPage$get() is still invoked
        # with nothing but self.
        call <- sys.call()
        call[[1]] <- as.name("list")
        dots <- eval.parent(call)

        if (length(dots) > 0) {
          key <- paste0(gn, "_", class(dots[[1]])[1])
          if (exists(key, envir = tbl, inherits = FALSE)) {
            # Class-level workers (@classmethod/@staticmethod) forward every
            # argument they receive to Python, so the leading dispatch marker
            # must be dropped first -- the same rule the generic in
            # defineFunctionalClassMethod applies.
            callArgs <- if (.isClassLevelFunctionalMethod(key)) {
              dots[-1]
            } else {
              dots
            }
            return(do.call(get(key, envir = tbl), args = callArgs))
          }
        }
        do.call(fallback, args = dots)
      }

      formals(shim) <- c(formals(fallback), extraFormals[[gn]])

      wasLocked <- bindingIsLocked(gn, ns)
      if (wasLocked) {
        unlockBinding(gn, ns)
      }
      assign(gn, shim, envir = ns)
      if (wasLocked) {
        lockBinding(gn, ns)
      }
    })
  }
}
.onAttach <- function(libname, pkgname) {
  tou <- "\nTERMS OF USE NOTICE:
  When using Synapse, remember that the terms and conditions of use require that you:
  1) Attribute data contributors when discussing these data or results from these data.
  2) Not discriminate, identify, or recontact individuals or groups represented by the data.
  3) Use and contribute only data de-identified to HIPAA standards.
  4) Redistribute data only under these same terms of use.\n"

  .checkForUpdate()
  packageStartupMessage(tou)
}

.defineOverloadFunctions <- function() {
  methods::setClass("GeneratorWrapper")
  methods::setMethod(
    f = "as.list",
    signature = c(x = "GeneratorWrapper"),
    definition = function(x) {
      x$asList()
    }
  )

  methods::setGeneric(
    name = "nextElem",
    def = function(x) {
      standardGeneric("nextElem")
    }
  )

  methods::setMethod(
    f = "nextElem",
    signature = c(x = "GeneratorWrapper"),
    definition = function(x) {
      x$nextElem()
    }
  )
}

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
    functionFilter = .removeAsyncFunctionFilter,
    classFilter = .synapseModelClassFilter,
    functionPrefix = "syn",
    generateFunctionalInterface = TRUE,
    functionNameMapping = .functionNameMappingSynapseclientModels()
  )
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

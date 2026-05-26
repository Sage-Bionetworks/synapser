# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) {
  tryCatch(
    {
      reticulate::py_run_string("import synapseclient")
    },
    error = function(e) {
      # Ideally we would source tools/installPythonClient.R to not
      # have to duplicate the synapseclient install code
      # system2(paste("Rscript ", getwd(), "/tools/installPythonClient.R ", getwd(), sep=""))
      PYTHON_CLIENT_VERSION <- 'v4.12'
      reticulate::py_install(c(paste("synapseclient[pandas]==", PYTHON_CLIENT_VERSION, sep="")), pip=T)
      reticulate::py_run_string("import synapseclient")
    }
  )
  
  reticulate::py_run_string(sprintf("synapserVersion = 'synapser/%s' ", utils::packageVersion("synapser")))
  reticulate::py_run_string("synapseclient.USER_AGENT['User-Agent'] = synapserVersion + ' '+ synapseclient.USER_AGENT['User-Agent']")
  reticulate::py_run_string("synapseclient.core.config.single_threaded = True")
  reticulate::py_run_string("syn=synapseclient.Synapse(skip_checks=True, debug=False)")
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
  reticulate::py_run_string("warnings.showwarning = lambda *args, **kwargs: None")
}

.setGenericCallback <- function(name, def) {
  methods::setGeneric(name, def)
}

.NAMESPACE <- environment()
.assignEnumCallback <- function(name, keys, values) {
  assign(name, setNames(values, keys), .NAMESPACE)
}

.defineRPackageFunctions <- function() {
  # exposing all Synapse's methods without exposing the Synapse object
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.Synapse",
                    setGenericCallback = .setGenericCallback,
                    assignEnumCallback = .assignEnumCallback,
                    functionFilter = .synapseClassFunctionFilter,
                    functionPrefix = "syn",
                    pySingletonName = "syn")
  # expose synapseclient.operations
  reticulate::py_run_string("import synapseclient.operations")
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.operations",
                    setGenericCallback = .setGenericCallback,
                    assignEnumCallback = .assignEnumCallback,
                    functionFilter = .removeAsyncFunctionFilter,
                    functionPrefix = "syn")

  generateRWrappers(pyPkg = "synapseclient.models",
                    container = "synapseclient.models",
                    setGenericCallback = .setGenericCallback,
                    assignEnumCallback = .assignEnumCallback,
                    functionFilter = .removeAsyncFunctionFilter,
                    classFilter = .synapseModelClassFilter,
                    functionPrefix = "syn",
                    generateFunctionalInterface = TRUE,
                    functionNameMapping = .synapseClientModelsMapping()
                    )
}
# TODO: This section is removed since it causes the infinite recursion 
# issue when reading downloaded entity to a dataframe. Revisit this
# when deprecating PythonEmbedInR code
# .objectDefinitionHelper <- function(object) {
#   if (methods::is(object, "CsvFileTable")) {
#     # reading from csv
#     # Removed due to Error in unlockBinding("asDataFrame", object) : no binding for "asDataFrame"
#     # unlockBinding("asDataFrame", object)
#     object$asDataFrame <- function() {
#       .readCsvBasedOnSchema(object)
#     }
#     # Removed due to Error in lockBinding("asDataFrame", object) : no binding for "asDataFrame"
#     # lockBinding("asDataFrame", object)
#   }
#   object
# }

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

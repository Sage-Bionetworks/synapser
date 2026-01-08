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
      PYTHON_CLIENT_VERSION <- '4.4.0'
      reticulate::py_install(c("pandas>=1.5,<=2.0.3", "jinja2", "markupsafe","numpy<=1.24.4"))
      reticulate::py_install(c(paste("synapseclient==", PYTHON_CLIENT_VERSION, sep="")), pip=T)
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
  # exposing all supporting classes except for Synapse itself and some selected classes.
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient",
                    setGenericCallback = .setGenericCallback,
                    assignEnumCallback = .assignEnumCallback,
                    functionFilter = .removeAllFunctionsFunctionFilter,
                    classFilter = .synapseClientClassFilter)
  # cherry picking and exposing function Table
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.table",
                    setGenericCallback = .setGenericCallback,
                    assignEnumCallback = .assignEnumCallback,
                    functionFilter = .cherryPickTableFunctionFilter,
                    classFilter = .removeAllClassesClassFilter,
                    functionPrefix = "syn")
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
  methods::setGeneric(
    name ="Table",
    def = function(schema, values, ...){
      do.call("synTable", args = list(schema, values, ...))
    }
  )
  methods::setMethod(
    f = "Table",
    signature = c("character", "data.frame"),
    definition = function(schema, values) {
      file <- tempfile()
      .saveToCsv(values, file)
      Table(schema, file)
    }
  )
  methods::setMethod(
    f = "Table",
    signature = c("ANY", "data.frame"),
    definition = function(schema, values) {
      file <- tempfile()
      .saveToCsvWithSchema(schema, values, file)
      Table(schema, file)
    }
  )
  
  methods::setMethod(
    f = "synBuildTable",
    signature = c("ANY", "ANY", "data.frame"),
    definition = function(name, parent, values) {
      file <- tempfile()
      .saveToCsv(values, file)
      synBuildTable(name, parent, file)
    }
  )

  methods::setClass("CsvFileTable")
  methods::setMethod(
    f = "as.data.frame",
    signature = c(x = "CsvFileTable"),
    definition = function(x) {
      .readCsvBasedOnSchema(x)
    }
  )
  
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
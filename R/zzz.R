# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) {
  .addPythonAndFoldersToSysPath(system.file(package = "synapser"))
  .defineRPackageFunctions()
  # .defineOverloadFunctions() must come AFTER .defineRPackageFunctions()
  # because it redefines selected generic functions
  .defineOverloadFunctions()

  PythonEmbedInR::pyImport("synapseclient")
  PythonEmbedInR::pySet("synapserVersion", sprintf("synapser/%s ", utils::packageVersion("synapser")))
  PythonEmbedInR::pyExec("synapseclient.USER_AGENT['User-Agent'] = synapserVersion + synapseclient.USER_AGENT['User-Agent']")
  PythonEmbedInR::pyExec("synapseclient.config.single_threaded = True")
  PythonEmbedInR::pyExec("syn=synapseclient.Synapse(skip_checks=True)")

  # register interrupt check
  libraryName <- sprintf("PythonEmbedInR%s", .Platform$dynlib.ext)
  if (.Platform$OS.type == "windows") {
    sharedLibrary <- libraryName
  } else {
    sharedLibraryLocation <- system.file("libs", package = "PythonEmbedInR")
    sharedLibrary <- file.path(sharedLibraryLocation, libraryName)
  }
  PythonEmbedInR::pyImport("interruptCheck")
  PythonEmbedInR::pyExec(sprintf("interruptCheck.registerInterruptChecker('%s')", sharedLibrary))

  # mute Python warnings
  PythonEmbedInR::pyImport("warnings")
  PythonEmbedInR::pyExec("warnings.filterwarnings('ignore')")
}

.callback <- function(name, def) {
  methods::setGeneric(name, def)
}

.defineRPackageFunctions <- function() {
  # exposing all Synapse's methods without exposing the Synapse object
  PythonEmbedInR::generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.Synapse",
                    setGenericCallback = .callback,
                    functionFilter = .synapseClassFunctionFilter,
                    functionPrefix = "syn",
                    transformReturnObject = .objectDefinitionHelper,
                    pySingletonName = "syn")
  # exposing all supporting classes except for Synapse itself and some selected classes.
  PythonEmbedInR::generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient",
                    setGenericCallback = .callback,
                    functionFilter = .removeAllFunctionsFunctionFilter,
                    classFilter = .synapseClientClassFilter)
  # cherry picking and exposing function Table
  PythonEmbedInR::generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.table",
                    setGenericCallback = .callback,
                    functionFilter = .cherryPickTableFunctionFilter,
                    classFilter = .removeAllClassesClassFilter,
                    functionPrefix = "syn",
                    transformReturnObject = .objectDefinitionHelper)
}

.objectDefinitionHelper <- function(object) {
  if (methods::is(object, "CsvFileTable")) {
    # reading from csv
    unlockBinding("asDataFrame", object)
    object$asDataFrame <- function() {
      if (object$header) {
        synapseTypes <- unlist(lapply(object$headers["::"], function(x){x$columnType}))
        # read all columns as character
        df <- .readCsv(object$filepath, "character")
        # convert each column to the most likely desired type
        df <- data.frame(
          Map(.convertListOfSchemaTypeToRType, list = df, type = synapseTypes),
          stringsAsFactors = F)
        
        # The mapping mangles column names, so let's fix them
        colnames(df) <- unlist(lapply(object$headers["::"], function(x){x$name}))
        df
      } else {
        .readCsv(object$filepath) # let readCsv decide types
      }
    }
    lockBinding("asDataFrame", object)
  }
  object
}

.onAttach <- function(libname, pkgname) {
  tou <- "\nTERMS OF USE NOTICE:
  When using Synapse, remember that the terms and conditions of use require that you:
  1) Attribute data contributors when discussing these data or results from these data.
  2) Not discriminate, identify, or recontact individuals or groups represented by the data.
  3) Use and contribute only data de-identified to HIPAA standards.
  4) Redistribute data only under these same terms of use.\n"

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
    signature = c("ANY", "data.frame"),
    definition = function(schema, values) {
      file <- tempfile()
      .saveToCsv(values, file)
      Table(schema, file)
    }
  )

  methods::setGeneric(
    name ="synBuildTable",
    def = function(name, parent, values){
      do.call("synBuild_table", args = list(name, parent, values))
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
      x$asDataFrame()
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

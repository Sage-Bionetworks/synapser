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

  pyImport("synapseclient")
  pySet("synapserVersion", sprintf("synapser/%s ", packageVersion("synapser")))
  pyExec("synapseclient.USER_AGENT['User-Agent'] = synapserVersion + synapseclient.USER_AGENT['User-Agent']")
  pyExec("syn=synapseclient.Synapse()")

  # register interrupt check
  libraryName <- sprintf("PythonEmbedInR%s", .Platform$dynlib.ext)
  if (.Platform$OS.type == "windows") {
    sharedLibrary <- libraryName
  } else {
    sharedLibraryLocation <- system.file("libs", package = "PythonEmbedInR")
    sharedLibrary <- file.path(sharedLibraryLocation, libraryName)
  }
  pyImport("interruptCheck")
  pyExec(sprintf("interruptCheck.registerInterruptChecker('%s')", sharedLibrary))
}

.callback <- function(name, def) {
  setGeneric(name, def)
}

.defineRPackageFunctions <- function() {
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.Synapse",
                    setGenericCallback = .callback,
                    functionFilter = synapseFunctionSelector,
                    functionPrefix = "syn",
                    transformReturnObject = .objectDefinitionHelper,
                    pySingletonName = "syn")
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient",
                    setGenericCallback = .callback,
                    functionFilter = removeAllFunctions,
                    classFilter = omitClasses)
  generateRWrappers(pyPkg = "synapseclient",
                    container = "synapseclient.table",
                    setGenericCallback = .callback,
                    functionFilter = cherryPickTable,
                    classFilter = removeAllClasses,
                    functionPrefix = "syn",
                    transformReturnObject = .objectDefinitionHelper)
}

.objectDefinitionHelper <- function(object) {
  if (is(object, "CsvFileTable")) {
    # reading from csv
    unlockBinding("asDataFrame", object)
    object$asDataFrame <- function() {
      .readCsv(object$filepath)
    }
    lockBinding("asDataFrame", object)
  }
  if (grepl("^GeneratorWrapper", class(object)[1])) {
    class(object)[1] <- "GeneratorWrapper"
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
  setGeneric(
    name ="Table",
    def = function(schema, values, ...){
      do.call("synTable", args = list(schema, values, ...))
    }
  )
  setMethod(
    f = "Table",
    signature = c("ANY", "data.frame"),
    definition = function(schema, values) {
      file <- tempfile()
      .saveToCsv(values, file)
      Table(schema, file)
    }
  )

  setClass("CsvFileTable")
  setMethod(
    f = "as.data.frame",
    signature = c(x = "CsvFileTable"),
    definition = function(x) {
      x$asDataFrame()
    }
  )

  setClass("GeneratorWrapper")
  setMethod(
    f = "as.list",
    signature = c(x = "GeneratorWrapper"),
    definition = function(x) {
      x$asList()
    }
  )

  setGeneric(
    name = "nextElem",
    def = function(x) {
      standardGeneric("nextElem")
    }
  )

  setMethod(
    f = "nextElem",
    signature = c(x = "GeneratorWrapper"),
    definition = function(x) {
      x$nextElem()
    }
  )
}

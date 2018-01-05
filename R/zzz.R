# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) { 
	.addPythonAndFoldersToSysPath(system.file(package="synapser"))
	
	.defineRPackageFunctions()
	# .defineOverloadFunctions() must come AFTER .defineRPackageFunctions() 
	# because it redefines selected generic functions.
	.defineOverloadFunctions()
	
	pyImport("synapseclient")
	pySet("synapserVersion", sprintf("synapser/%s ", packageVersion("synapser")))
	pyExec("synapseclient.USER_AGENT['User-Agent'] = synapserVersion + synapseclient.USER_AGENT['User-Agent']")
	pyExec("syn=synapseclient.Synapse()")
	
	# register interrupt check
	libraryName<-sprintf("PythonEmbedInR%s", .Platform$dynlib.ext)
	if(.Platform$OS.type == "windows") {
		sharedLibrary<-libraryName
	} else {
		sharedLibraryLocation<-system.file("libs", package="PythonEmbedInR")
		sharedLibrary<-file.path(sharedLibraryLocation, libraryName)
	}
	pyImport("interruptCheck")
	pyExec(sprintf("interruptCheck.registerInterruptChecker('%s')", sharedLibrary))	
}

.determineArgsAndKwArgs<-function(...) {
	values<-list(...)
	valuenames<-names(values)
	n<-length(values)
	args<-list()
	kwargs<-list()
	if (n>0) {
		positionalArgument<-TRUE
		for (i in 1:n) {
			if (is.null(valuenames) || length(valuenames[[i]])==0 || nchar(valuenames[[i]])==0) {
				# it's a positional argument
				if (!positionalArgument) {
					stop("positional argument follows keyword argument")
				}
				args[[length(args)+1]]<-values[[i]]
			} else {
				# It's a keyword argument.  All subsequent arguments must also be keyword arg's
				positionalArgument<-FALSE
				# a repeated value will overwite an earlier one
				kwargs[[valuenames[[i]]]]<-values[[i]]
			}
		}
	}
	list(args=args, kwargs=kwargs)
}

.cleanUpStackTrace<-function(callable, args) {
	conn<-textConnection("outputCapture", open="w")
	sink(conn)
	tryCatch({
			result<-do.call(callable, args)
			sink()
			close(conn)
			cat(outputCapture, "\n")
			result
		}, 
		error = function(e) {
			sink()
			close(conn)
			errorToReport<-paste(outputCapture, collapse="\n")
			if (!getOption("verbose")) {
				# extract the error message
				splitArray<-strsplit(errorToReport, "exception-message-boundary", fixed=TRUE)[[1]]
				if (length(splitArray)>=2) errorToReport<-splitArray[2]
			}
			stop(errorToReport)
		}
	)
}

.defineFunction<-function(synName, pyName, functionContainerName) {
	force(synName)
	force(pyName)
	force(functionContainerName)
	assign(sprintf(".%s", synName), function(...) {
				functionContainer<-pyGet(functionContainerName, simplify=FALSE)
				argsAndKwArgs<-.determineArgsAndKwArgs(...)
				functionAndArgs<-append(list(functionContainer, pyName), argsAndKwArgs$args)
				returnedObject <- .cleanUpStackTrace(pyCall, list("gateway.invoke", args=functionAndArgs, kwargs=argsAndKwArgs$kwargs, simplify=F))
				.modify(returnedObject)
			})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), args=list(...))
			}
	)
}

.defineConstructor<-function(synName, pyName) {
	force(synName)
	force(pyName)
	assign(sprintf(".%s", synName), function(...) {
				synapseClientModule<-pyGet("synapseclient")
				argsAndKwArgs<-.determineArgsAndKwArgs(...)
				functionAndArgs<-append(list(synapseClientModule, pyName), argsAndKwArgs$args)
				.cleanUpStackTrace(pyCall, list("gateway.invoke", args=functionAndArgs, kwargs=argsAndKwArgs$kwargs, simplify=F))
			})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), args=list(...))
			}
	)
}

.defineRPackageFunctions<-function() {
	functionInfo<-.getSynapseFunctionInfo(system.file(package="synapser"))
	for (f in functionInfo) {
		.defineFunction(f$synName, f$name, f$functionContainerName)
	}
	classInfo<-.getSynapseClassInfo(system.file(package="synapser"))
	for (c in classInfo) {
		.defineConstructor(c$name, c$name)
	}
}

.modify <- function(object) {
  if (is(object, "CsvFileTable")){
    # reading from csv
    unlockBinding("asDataFrame", object)
    object$asDataFrame <- function() {
      .readCsv(object$filepath)
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

.defineOverloadFunctions<-function() {
  assign(".Table", function(...) {
    synapseClientModule<-pyGet("synapseclient")
    argsAndKwArgs<-.determineArgsAndKwArgs(...)
    functionAndArgs<-append(list(synapseClientModule, "Table"), argsAndKwArgs$args)
    returnedObject <- .cleanUpStackTrace(pyCall, list("gateway.invoke", args=functionAndArgs, kwargs=argsAndKwArgs$kwargs, simplify=F))
    .modify(returnedObject)
  })
  setGeneric(
    name="Table",
    def = function(schema, values, ...) {
      do.call(".Table", args=list(schema, values, ...))
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
    })
}

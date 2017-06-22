# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) { 
	.addPythonAndFoldersToSysPath(system.file(package="synapser"))
	
	# TODO This line is in '.onLoad' in PythonEmbedInR but fails to persist on Windows
	# long term, need to determine why and fix it
	Sys.setenv(PYTHONPATH=system.file("lib", package="PythonEmbedInR"))
	# TODO to be on the safe side, we repeat this too.  Long term we need to look at the root cause.
	Sys.setenv(PYTHONHOME=system.file(package="PythonEmbedInR"))
	
	# TODO remove debugging statements:
	message("In synapser's .onLoad.  The value of sys.path is:")
	pyExec("import sys")
	pyExec("print(sys.path)")
	message("\nHere's the content of python-packages:")
	message(paste(list.files(system.file("python-packages", package="synapser")), collapse="\n"))
	message("\nNow we will import 'synapseclient' in python")
	
	.defineRPackageFunctions()
	
	pyImport("synapseclient")
	pyExec("syn=synapseclient.Synapse()")
	message("synapseclient version:", pyGet("synapseclient.__version__"))
}

.defineFunction<-function(synName, pyName) {
	force(synName)
	force(pyName)
	assign(sprintf(".%s", synName), function(...) {
		pyCall(sprintf("syn.%s", pyName), ...)
	})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), list(...))
			}
	)
}

.defineRPackageFunctions<-function() {
	functionInfo<-.getSynapseFunctionInfo(system.file(package="synapser"))
	for (f in functionInfo) {
		.defineFunction(f$synName, f$name)
	}
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




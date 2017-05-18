# package initialization
#
# 
# Author: bhoff
###############################################################################

# TODO the package should be able to return the version of the underlying Python package
# i.e. the value of synapseclient.__version__
.onLoad <- function(libname, pkgname) { 
	.addPythonAndLibFoldersToSysPath(system.file(package="synapser"))
	.defineRPackageFunctions()
	
	# TODO fix module import failure
	#pyImport("urllib3")
	#pyExec("urllib3.disable_warnings()")
	
	pyImport("synapseclient")
	pyExec("syn=synapseclient.Synapse()")
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

.onAttach <-
		function(libname, pkgname)
{
	tou <- "\nTERMS OF USE NOTICE:
	When using Synapse, remember that the terms and conditions of use require that you:
	1) Attribute data contributors when discussing these data or results from these data.
	2) Not discriminate, identify, or recontact individuals or groups represented by the data.
	3) Use and contribute only data de-identified to HIPAA standards.
	4) Redistribute data only under these same terms of use.\n"
	
	packageStartupMessage(tou)
}




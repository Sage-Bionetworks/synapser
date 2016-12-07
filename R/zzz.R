# package initialization
#
# 
# Author: bhoff
###############################################################################

# TODO the package should be able to return the version of the underlying Python package
# i.e. the value of synapseclient.__version__
.onLoad <- function(libname, pkgname) { 
	.addPythonAndLibFoldersToSysPath(system.file(package="synapse"))
	.defineRPackageFunctions()
	python.exec("import urllib3")
	python.exec("urllib3.disable_warnings()")
	
	python.exec("import synapseclient")
	python.exec("urllib3.disable_warnings()\nsyn=synapseclient.Synapse()")
}

.defineFunction<-function(synName, pyName) {
	force(synName)
	force(pyName)
	assign(sprintf(".%s", synName), function(...) {
		python.call(sprintf("syn.%s", pyName), ...)
	})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), list(...))
			}
	)
}

.defineRPackageFunctions<-function() {
	functionInfo<-.getSynapseFunctionInfo(system.file(package="synapse"))
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




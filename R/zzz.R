# package initialization
#
# 
# Author: bhoff
###############################################################################

# TODO the package should be able to return the version of the underlying Python package
# i.e. the value of synapseclient.__version__
.onLoad <- function(libname, pkgname) { 
	.addPythonFolderToSysPath(system.file(package="synapseclient"))
	.defineRPackageFunctions()
	
	# TODO This doesn't work
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
	functionInfo<-.getSynapseFunctionInfo(system.file(package="synapseclient"))
	for (f in functionInfo) {
		.defineFunction(f$synName, f$name)
	}
}



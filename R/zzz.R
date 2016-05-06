# package initialization
#
# 
# Author: bhoff
###############################################################################

# TODO the package should be able to return the version of the underlying Python package
# i.e. the value of synapseclient.__version__
.onLoad <- function(libname, pkgname) { 
	.addPythonFolderToSysPath(system.file(package="synapse"))
	.defineRPackageFunctions()
	
	python.exec("import urllib3")
	python.exec("urllib3.disable_warnings()")
	
	python.exec("import synapseclient")
	python.exec("urllib3.disable_warnings()\nsyn=synapseclient.Synapse()")
	
	# auto-generate S-4 classes:  The following is inherited from the original R client:
	entities <- entitiesToLoad()
	where<-.Internal(getRegisteredNamespace(as.name("synapse")))
	for(ee in entities){ 
		defineEntityClass(ee, package="synapse", where=where)
		defineEntityConstructors(ee, package="synapse", where=where)
	}
	
	# we need a TypedList of UploadDestination, for which there is no schema
	defineTypedList("UploadDestination")
	
	# This is done during class generation but seems to be lost at package load time.  So we do it again.
	populateSchemaToClassMap()
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




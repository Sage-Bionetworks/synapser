# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.addSynPrefix<-function(name) {
	paste("syn", toupper(substring(name,1,1)), substring(name,2,nchar(name)), sep="")
}

.addPythonAndFoldersToSysPath<-function(srcDir) {
	pyImport("sys")
	pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "python")))
	pyImport("installPythonClient")
	pyExec(sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", srcDir))
}

# for each function in the Python 'Synapse' class, get:
# (1) function name,
# (2) arguments,
# (3) comments
# returns a list having fields: name, args, doc
#
# rootDir is the folder containing the 'python' folder
#
.getSynapseFunctionInfo<-function(rootDir) {
	.addPythonAndFoldersToSysPath(rootDir)
	pyImport("functionInfo")
	
	pyFunctionInfo<-pyCall("functionInfo.functionInfo", simplify=F)
	
	# the now add the prefix 'syn'
	lapply(X=pyFunctionInfo, function(x){list(name=x$name, synName=.addSynPrefix(x$name), args=x$args, doc=x$doc)})
}

.getSynapseConstructorInfo<-function(rootDir) {
	.addPythonAndFoldersToSysPath(rootDir)
	pyImport("functionInfo")

	# Now find all the public classes and create constructors for them
	pyConstructorInfo<-pyCall("functionInfo.constructorInfo", simplify=F)
	
	lapply(X=pyConstructorInfo, function(x){list(name=x$name, synName=x$name, args=x$args, doc=x$doc)})
}


# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.addSynPrefix<-function(name) {
	paste("syn", toupper(substring(name,1,1)), substring(name,2,nchar(name)), sep="")
}

.addEggsToPath<-function(dir) {
	# modules with .egg extensions (such as future and synapseClient) need to be explicitly added to the sys.path
	pyImport("sys")
	pyImport("glob")
	pyExec(sprintf("sys.path+=glob.glob('%s/*.egg')", dir))
}

.addPythonAndFoldersToSysPath<-function(srcDir) {
	pyImport("sys")
	pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "python")))
	packageDir<-file.path(srcDir, "python-packages")
	pyExec(sprintf("sys.path.append('%s')", packageDir))
	Sys.setenv(PYTHONPATH=packageDir)
	
	#add all .eggs to paths
	.addEggsToPath(packageDir)
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

	result<-pyCall("functionInfo.functionInfo")
	
	message("In .getSynapseFunctionInfo") # TODO remove
	
	# the now add the prefix 'syn'
	lapply(X=result, function(x){list(name=x$name, synName=.addSynPrefix(x$name), args=x$args, doc=x$doc)})
}
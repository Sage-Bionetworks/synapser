# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.getPythonFolderPath<-function(rootDir) {
	file.path(rootDir, "python")
}

.addEggsToPath<-function(dir){
	# modules with .egg extensions (such as future and synapseClient) need to be explicitly added to the sys.path
	pyImport("sys")
	pyImport("glob")
	pyExec(sprintf("sys.path+=glob.glob('%s/*.egg')", dir))
}

.addPythonAndLibFoldersToSysPath<-function(srcDir) {
	pyImport("sys")
	pyExec(sprintf("sys.path.append('%s')", .getPythonFolderPath(srcDir)))
	pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "lib")))
	pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "lib/python3.5")))
	sitePackageDir <- file.path(srcDir, "lib/python3.5/site-packages")
	pyExec(sprintf("sys.path.append('%s')", sitePackageDir))
	#add all .eggs to paths
	.addEggsToPath(sitePackageDir)
}

.addSynPrefix<-function(name) {
	paste("syn", toupper(substring(name,1,1)), substring(name,2,nchar(name)), sep="")
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
	#pyImport("sys")
	pyExec(sprintf("sys.path.append(\"%s\")", file.path(rootDir, "python")))
	pyImport("functionInfo")	

	result<-pyCall("functionInfo.functionInfo", list())
	
	# the now add the prefix 'syn'
	lapply(X=result, function(x){list(name=x$name, synName=.addSynPrefix(x$name), args=x$args, doc=x$doc)})
}
# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.getPythonFolderPath<-function(rootDir) {
	file.path(rootDir, "python")
}

.addEggsToPath<-function(dir){
	# modules with .egg extensions (such as future and synapseClient) need to be explicitly added to the sys.path
	python.exec("import sys")
	python.exec("import glob")
	python.exec(sprintf("sys.path+=glob.glob('%s/*.egg')", dir))
}

.addPythonAndLibFoldersToSysPath<-function(srcDir) {
	python.exec("import sys")
	python.exec(sprintf("sys.path.append('%s')", .getPythonFolderPath(srcDir)))
	python.exec(sprintf("sys.path.append('%s')", file.path(srcDir, "lib")))
	python.exec(sprintf("sys.path.append('%s')", file.path(srcDir, "lib/python3.5")))
	sitePackageDir <- file.path(srcDir, "lib/python3.5/site-packages")
	python.exec(sprintf("sys.path.append('%s')", sitePackageDir))
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
.getSynapseFunctionInfo<-function(rootDir) {
	#.addPythonAndLibFoldersToSysPath(rootDir)
	python.load(file.path(.getPythonFolderPath(rootDir), "functionInfo.py"))
	result<-python.get("functionInfo()")
	# the now add the prefix 'syn'
	lapply(X=result, function(x){list(name=x$name, synName=.addSynPrefix(x$name), args=x$args, doc=x$doc)})
}
# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.getPythonFolderPath<-function(rootDir) {
	file.path(rootDir, "python")
}

.addPythonFolderToSysPath<-function(srcDir) {
	python.exec("import sys")
	sysPath<-python.get("sys.path")
	pythonFolder<-.getPythonFolderPath(srcDir)
	sysPath<-append(sysPath, pythonFolder)
	python.assign("sys.path", sysPath)
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
	.addPythonFolderToSysPath(rootDir)
	python.load(file.path(.getPythonFolderPath(rootDir), "functionInfo.py"))
	result<-python.get("functionInfo()")
	# the now add the prefix 'syn'
	lapply(X=result, function(x){list(name=x$name, synName=.addSynPrefix(x$name), args=x$args, doc=x$doc)})
}
# R script to install the Synapse Python client
# The script itself is written in Python.  This is simply a wrapper to call it
# via the rWithPython package
# 
# Author: bhoff
###############################################################################

library(PythonEmbedInR)
args <- commandArgs(trailingOnly = TRUE)
baseDir<-args[1]

if (is.null(baseDir) || is.na(baseDir) || !file.exists(baseDir)) {
	stop("baseDir is invalid")
}

pyImport("sys")
pyExec(sprintf("sys.path.append(\"%s\")", file.path(baseDir, "inst", "python")))

pyImport("installPythonClient")

command<-sprintf("installPythonClient.foo('%s')", baseDir)
message("installPythonClient.R:  imported installPythonClient, next will call ", command)
pyExec(command)

command<-sprintf("installPythonClient.entrypoint('%s')", baseDir)
message("installPythonClient.R:  imported installPythonClient, next will call ", command)
pyExec(command)

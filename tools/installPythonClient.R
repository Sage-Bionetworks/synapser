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
	stop(paste("baseDir", baseDir, "is invalid"))
}

PythonEmbedInR::pyImport("sys")
PythonEmbedInR::pyExec(sprintf("sys.path.append(\"%s\")", file.path(baseDir, "inst", "python")))

PythonEmbedInR::pyImport("installPythonClient")

command<-sprintf("installPythonClient.main('%s')", baseDir)
PythonEmbedInR::pyExec(command)

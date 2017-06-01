# R script to install the Synapse Python client
# The script itself is written in Python.  This is simply a wrapper to call it
# via the rWithPython package
# 
# Author: bhoff
###############################################################################

library(PythonEmbedInR)
args <- commandArgs(trailingOnly = TRUE)
baseDir<-args[1]
message("In installPythonClient.R baseDir value passed in: ", baseDir)
if (is.null(baseDir) || is.na(baseDir) || !file.exists(baseDir)) {
	baseDir<-getwd()
	message("In installPythonClient.R baseDir changed to: ", baseDir)
}

message("contents of ", baseDir, " :")
list.files(baseDir)

message("file info for ./configure:")
file.info(file.path(baseDir, "configure"))

message("contents of ", file.path(baseDir, "inst/python"), " :")
list.files(file.path(baseDir, "inst/python"))

pyImport("sys")
pyExec(sprintf("sys.path.append(\"%s\")", file.path(baseDir, "inst/python")))
message("sys.path: ", pyGet("sys.path"))

pyImport("installPythonClient")
pyExec(sprintf("installPythonClient.main(\"%s\")", baseDir))

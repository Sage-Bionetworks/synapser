# R script to install the Synapse Python client
# The script itself is written in Python.  This is simply a wrapper to call it
# via the rWithPython package
# 
# Author: bhoff
###############################################################################

library(rWithPython)
args <- commandArgs(trailingOnly = TRUE)
baseDir<-args[1]
python.exec("import sys")
python.exec(sprintf("sys.path.append(\"%s\")", file.path(baseDir, "inst/python")))
python.exec("import installPythonClient")
python.exec(sprintf("installPythonClient.main(\"%s\")", baseDir))

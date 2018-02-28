# now call autoGenerateRdFiles
args <- commandArgs(TRUE)
srcRootDir <- args[1]
library("PythonEmbedInR")
# 'source' some functions shared with the synapser package
source(sprintf("%s/R/shared.R",srcRootDir))
# get the Python documentation of all the functions
functionInfo<-.getSynapseFunctionInfo(file.path(srcRootDir, "inst"))
# get the Python documentation of all the classes
classInfo<-.getSynapseClassInfo(file.path(srcRootDir, "inst"))
autoGenerateRdFiles(srcRootDir, functionInfo, classInfo)

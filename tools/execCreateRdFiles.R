# now call autoGenerateRdFiles
args <- commandArgs(TRUE)
srcRootDir<-args[1]
source(sprintf("%s/tools/createRdFiles.R",srcRootDir))
# 'source' some functions shared with the synapser package
source(sprintf("%s/R/shared.R",srcRootDir))
autoGenerateRdFiles(srcRootDir)

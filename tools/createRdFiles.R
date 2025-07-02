# now call autoGenerateRdFiles
library("reticulate")
library("rjson")
args <- commandArgs(TRUE)
srcRootDir <- args[1]

# 'source' some functions shared with the synapser package
# to get omitFunctions and omitClasses
source(sprintf("%s/R/shared.R", srcRootDir))
source(sprintf("%s/R/PythonPkgWrapperUtils.R", srcRootDir))

reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf("sys.path.append(\"%s\")", file.path(srcRootDir, "inst", "python")))

generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient.Synapse",
                functionFilter = .synapseClassFunctionFilter,
                functionPrefix = "syn",
                generateFunctionalInterface = TRUE)
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient.models",
                container = "synapseclient.models",
                functionFilter = .removeAsyncFunctionFilter,
                classFilter = .synapseModelClassFilter,
                keepContent = TRUE,
                functionPrefix = "syn",
                generateFunctionalInterface = TRUE)

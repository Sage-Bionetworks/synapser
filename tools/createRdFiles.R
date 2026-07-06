# now call autoGenerateRdFiles
library("reticulate")
library("rjson")
args <- commandArgs(TRUE)
srcRootDir <- args[1]

# 'source' some functions shared with the synapser package
# to get omitFunctions and omitClasses
source(sprintf("%s/R/shared.R", srcRootDir))
source(sprintf("%s/R/PythonPkgWrapperUtils.R", srcRootDir))

# Must be declared before any Python call below so reticulate's
# uv-managed ephemeral environment resolves this requirement instead of
# provisioning a fresh empty environment for this process (this script
# runs as its own Rscript process, separate from installPythonClient.R).
reticulate::py_require("synapseclient[pandas]==4.12")

reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf(
    "sys.path.append(\"%s\")",
    file.path(srcRootDir, "inst", "python")
))

generateRdFiles(
    srcRootDir,
    pyPkg = "synapseclient",
    container = "synapseclient.Synapse",
    functionFilter = .synapseClassFunctionFilter,
    functionPrefix = "syn",
    functionNameMapping = .functionNameMappingSynapse()
)
reticulate::py_run_string("import synapseclient.operations")
generateRdFiles(
    srcRootDir,
    pyPkg = "synapseclient",
    container = "synapseclient.operations",
    functionFilter = .operationsFunctionNamesFilter,
    keepContent = TRUE,
    functionPrefix = "syn"
)
generateRdFiles(
    srcRootDir,
    pyPkg = "synapseclient",
    container = "synapseclient.models",
    functionFilter = .removeAsyncFunctionFilter,
    classFilter = .synapseModelClassFilter,
    keepContent = TRUE,
    functionPrefix = "syn",
    generateFunctionalInterface = TRUE,
    functionNameMapping = .functionNameMappingSynapseclientModels()
)

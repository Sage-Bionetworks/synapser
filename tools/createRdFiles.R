# now call autoGenerateRdFiles
args <- commandArgs(TRUE)
srcRootDir <- args[1]

library("PythonEmbedInR")

# add synapseclient egg to search path
PythonEmbedInR::pyImport("sys")
PythonEmbedInR::pyExec(sprintf("sys.path.append(\"%s\")", file.path(srcRootDir, "inst", "python")))
PythonEmbedInR::pyImport("installPythonClient")
PythonEmbedInR::pyImport("os")
sitePackagesDir <- PythonEmbedInR::pyGet(sprintf("'%s'+os.sep+'inst'", srcRootDir))
command <- sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", sitePackagesDir)
PythonEmbedInR::pyExec(command)

# 'source' some functions shared with the synapser package
# to get omitFunctions and omitClasses
source(sprintf("%s/R/shared.R", srcRootDir))

## all functions in synapseclient.Synapse module
PythonEmbedInR::generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient.Synapse",
                functionFilter = .synapseClassFunctionFilter,
                functionPrefix = "syn")
## all classes in synapseclient module
PythonEmbedInR::generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient",
                functionFilter = .removeAllFunctionsFunctionFilter,
                classFilter = .synapseClientClassFilter,
                keepContent = TRUE)
# cherry pick Table function
PythonEmbedInR::generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient.table",
                functionFilter = .cherryPickTableFunctionFilter,
                classFilter = .removeAllClassesClassFilter,
                keepContent = TRUE)

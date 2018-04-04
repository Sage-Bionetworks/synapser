# now call autoGenerateRdFiles
args <- commandArgs(TRUE)
srcRootDir <- args[1]

library("PythonEmbedInR")

# add synapseclient egg to search path
pyImport("sys")
pyExec(sprintf("sys.path.append(\"%s\")", file.path(srcRootDir, "inst", "python")))
pyImport("installPythonClient")
pyImport("os")
sitePackagesDir <- pyGet(sprintf("'%s'+os.sep+'inst'", srcRootDir))
command <- sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", sitePackagesDir)
pyExec(command)

# 'source' some functions shared with the synapser package
# to get omitFunctions and omitClasses
source(sprintf("%s/R/shared.R", srcRootDir))

## all functions in synapseclient.Synapse module
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient.Synapse",
                functionFilter = .synapseClassFunctionFilter,
                functionPrefix = "syn")
## all classes in synapseclient module
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient",
                functionFilter = .removeAllFunctionsFunctionFilter,
                classFilter = .synapseClientClassFilter,
                keepContent = TRUE)
# cherry pick Table function
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                container = "synapseclient.table",
                functionFilter = .cherryPickTableFunctionFilter,
                classFilter = .removeAllClassesClassFilter,
                keepContent = TRUE)

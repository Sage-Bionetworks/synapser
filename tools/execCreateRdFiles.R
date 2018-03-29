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
                class = "synapseclient.Synapse",
                functionFilter = synapseFunctionSelector,
                functionPrefix = "syn")
## all classes in synapseclient module
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                module = "synapseclient",
                functionFilter = removeAllFunctions,
                classFilter = omitClasses,
                keepContent = TRUE)
# cherry pick Table function
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                module = "synapseclient.table",
                functionFilter = cherryPickTable,
                classFilter = removeAllClasses,
                keepContent = TRUE)

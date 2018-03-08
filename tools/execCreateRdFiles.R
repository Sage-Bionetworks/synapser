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
                module = "synapseclient.Synapse",
                modifyFunctions = synapseFunctionSelector,
                functionPrefix = "syn")
## all classes in synapseclient module
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                module = "synapseclient",
                modifyFunctions = removeAllFunctions,
                modifyClasses = omitClasses,
                keepContent = TRUE)
# cherry pick Table function
generateRdFiles(srcRootDir,
                pyPkg = "synapseclient",
                module = "synapseclient.table",
                modifyFunctions = cherryPickTable,
                modifyClasses = removeAllClasses,
                keepContent = TRUE)

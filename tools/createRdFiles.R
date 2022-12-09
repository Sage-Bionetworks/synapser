# now call autoGenerateRdFiles
library("reticulate")
library("rjson")
args <- commandArgs(TRUE)
srcRootDir <- args[1]



# add synapseclient egg to search path
# reticulate::py_run_string("import sys")
# reticulate::py_run_string(sprintf("sys.path.append(\"%s\")", file.path(srcRootDir, "inst", "python")))
# reticulate::py_run_string("import installPythonClient")
# reticulate::py_run_string("import os")
# sitePackagesDir <- reticulate::py_run_string(sprintf("'%s'+os.sep+'inst'", srcRootDir))
# command <- sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", sitePackagesDir)
# reticulate::py_run_string(command)

# 'source' some functions shared with the synapser package
# to get omitFunctions and omitClasses
source(sprintf("%s/R/shared.R", srcRootDir))
source(sprintf("%s/R/PythonPkgWrapperUtils.R", srcRootDir))

reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf("sys.path.append(\"%s\")", file.path(srcRootDir, "inst", "python")))
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

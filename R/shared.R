# Utilities for getting Python method signatures and documentation
# 
# Author: bhoff
###############################################################################

.addSynPrefix <- function(name) {
  paste("syn", toupper(substring(name, 1, 1)), substring(name, 2, nchar(name)), sep = "")
}

.addPythonAndFoldersToSysPath <- function(srcDir) {
  pyImport("sys")
  pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "python")))
  pyImport("installPythonClient")
  pyExec(sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", srcDir))
}

# for each function in the Python 'Synapse' class, get:
# (1) function name,
# (2) arguments,
# (3) comments
# returns a list having fields: name, args, doc
#
# rootDir is the folder containing the 'python' folder
#
.getSynapseFunctionInfo <- function(rootDir) {
  .addPythonAndFoldersToSysPath(rootDir)
  pyImport("functionInfo")
  pyImport("gateway")

  pyFunctionInfo <- pyCall("functionInfo.functionInfo", simplify = F)

  # the now add the prefix 'syn'
  result <- lapply(X = pyFunctionInfo, function(x) {
    if (!is.null(x$doc) && regexpr("**Deprecated**", x$doc, fixed = TRUE)[1] > 0) return(NULL)
    if (x$module == "synapseclient.client") {
      synName <- .addSynPrefix(x$name)
      functionContainerName <- "syn" # function is contained in an instance of the Synapse class
    } else if (x$module == "synapseclient.table") {
      synName <- x$name
      functionContainerName <- "synapseclient.table" # function is contained within the synapseclient.table module
    } else {
      stop(sprintf("Unexpected module %s for %s", x$module, x$name))
    }
    list(name = x$name, synName = synName, functionContainerName = functionContainerName, args = x$args, doc = x$doc, title = synName)
  })
  # scrub the nulls
  result[-which(sapply(result, is.null))]
}

.removeOmittedClassesAndMethods <- function(pyClassInfo) {
  classesToSkip <- c("Entity")
  methodsToOmit <- c("postURI", "getURI", "putURI", "deleteURI", "getACLURI", "putACLURI", "keys", "has_key")
  result <- lapply(X = pyClassInfo, function(x) {
    if (any(x$name == classesToSkip)) return(NULL)
    if (!is.null(x$methods)) {
      culledMethods <- lapply(X = x$methods,
                              function(x) {
                                if (any(x$name == methodsToOmit)) NULL else x;
                                }
                              )
      # Now remove the nulls
      nullIndices <- sapply(culledMethods, is.null)
      if (any(nullIndices)) {
        x$methods <- culledMethods[-which(nullIndices)]
      }
    }
    x
  })
  # scrub the nulls
  nullIndices <- sapply(result, is.null)
  if (any(nullIndices)) {
    result <- result[-which(nullIndices)]
  }
  result
}

.getSynapseClassInfo <- function(rootDir) {
  .addPythonAndFoldersToSysPath(rootDir)
  pyImport("functionInfo")
  # Now find all the public classes and create constructors for them
  pyClassInfo <- pyCall("functionInfo.classInfo", simplify = F)
  .removeOmittedClassesAndMethods(pyClassInfo)
}

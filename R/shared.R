# Utilities for getting Python method signatures and documentation
#
# Author: bhoff
###############################################################################

.addPythonAndFoldersToSysPath <- function(srcDir) {
  pyImport("sys")
  pyExec(sprintf("sys.path.append('%s')", file.path(srcDir, "python")))
  pyImport("installPythonClient")
  pyExec(
    sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", srcDir)
  )
}

# for synapseclient.table module 
cherryPickTable <- function(x) {
  if (x$name == "Table") {
    x
  }
}

removeAllClasses <- function(x) NULL

# for synapseclient.Synapse
synapseFunctionSelector <- function(x) {
  if (!is.null(x$doc) && regexpr("**Deprecated**", x$doc, fixed = TRUE)[1] > 0) {
    return(NULL)
  } else {
    x
  }
}

# for synapseclient module

removeAllFunctions <- function(x) NULL

classesToSkip <- c("Entity", "Synapse")
methodsToOmit <- c("postURI", "getURI", "putURI", "deleteURI", "getACLURI", "putACLURI", "keys", "has_key")

omitClasses <- function(x) {
  if (any(x$name == classesToSkip)) {
    return(NULL)
  }
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
}
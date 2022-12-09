# Utilities for getting Python method signatures and documentation
#
# Author: bhoff
###############################################################################

.addPythonAndFoldersToSysPath <- function(srcDir) {
  reticulate::py_run_string("import sys")
  reticulate::py_run_string(sprintf("sys.path.insert(0, '%s')", file.path(srcDir, "python")))
  reticulate::py_run_string("import installPythonClient")
  reticulate::py_run_string(
    sprintf("installPythonClient.addLocalSitePackageToPythonPath('%s')", srcDir)
  )
}

# for synapseclient.table module
.cherryPickTableFunctionFilter <- function(x) {
  if (x$name == "Table" || x$name == "build_table") {
    x
  }
}

.removeAllClassesClassFilter <- function(x) NULL

# for synapseclient.Synapse
.synapseClassFunctionFilter <- function(x) {
  if ((!is.null(x$doc) && regexpr("**Deprecated**", x$doc, fixed = TRUE)[1] > 0) ||
      (any(x$name == .methodsToOmit))) {
    return(NULL)
  } else {
    x
  }
}

# for synapseclient module

.removeAllFunctionsFunctionFilter <- function(x) NULL

.classesToSkip <- c(
  "Entity",
  "Synapse",
  "Annotations"
)
.methodsToOmit <- c(
  "postURI",
  "getURI",
  "putURI",
  "deleteURI",
  "getACLURI",
  "putACLURI",
  "keys",
  "has_key",
  "set_annotations",
  "get_annotations"
)

.synapseClientClassFilter <- function(x) {
  if (any(x$name == .classesToSkip)) {
    return(NULL)
  }
  if (!is.null(x$methods)) {
    culledMethods <- lapply(X = x$methods,
                            function(x) {
                              if (any(x$name == .methodsToOmit)) NULL else x;
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

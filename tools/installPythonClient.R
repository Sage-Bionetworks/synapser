# R script to install the Synapse Python client
# The script itself is written in Python.  This is simply a wrapper to call it
# via the rWithPython package
# This script runs during configure, before synapser itself is installed.
# Author: bhoff
###############################################################################

args <- commandArgs(trailingOnly = TRUE)
baseDir <- args[1]

if (is.null(baseDir) || is.na(baseDir) || !file.exists(baseDir)) {
  stop(paste("baseDir", baseDir, "is invalid"))
}

source(file.path(baseDir, "R", "shared.R"))
# Resolves the pinned synapseclient in reticulate's uv-managed environment
# and fails configure early, with a clear message, if another Python took
# precedence without synapseclient installed.
.importSynapseclient()

print("*** Using Python Configuration:")
reticulate::py_config()

reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf(
  "sys.path.append(\"%s\")",
  file.path(baseDir, "inst", "python")
))

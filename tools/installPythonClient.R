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
# Must be declared before any Python call (including py_config() below)
# so reticulate's uv-managed ephemeral environment resolves this
# requirement instead of provisioning a fresh empty environment.
reticulate::py_require(c(paste(
  "synapseclient[pandas]==",
  PYTHON_CLIENT_VERSION,
  sep = ""
)))

print("*** Using Python Configuration:")
reticulate::py_config()
reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf(
  "sys.path.append(\"%s\")",
  file.path(baseDir, "inst", "python")
))

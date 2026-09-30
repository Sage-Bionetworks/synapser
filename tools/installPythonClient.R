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

# py_require() declares a requirement; it only installs when reticulate
# builds its own managed environment. When another Python wins its
# Order of Discovery -- an activated virtualenv, a project .venv, or an
# existing r-reticulate -- reticulate only warns that the requirement is
# unmet. Install into that environment here, otherwise the
# `import synapseclient` in tools/createRdFiles.R fails and configure dies.
# R/zzz.R does the same thing at load time.
#https://rstudio.github.io/reticulate/articles/python_packages.html
tryCatch(
  reticulate::py_run_string("import synapseclient"),
  error = function(e) {
    tryCatch(
      reticulate::py_install(
        paste("synapseclient[pandas]==", PYTHON_CLIENT_VERSION, sep = ""),
        pip = TRUE
      ),
      error = function(installError) {
        stop(
          "Could not install synapseclient into the Python environment that ",
          "reticulate selected:\n  ",
          reticulate::py_config()$python,
          "\nThat environment must be Python 3.10 to 3.14 and must have pip ",
          "available. Note that a virtual environment created by `uv venv` ",
          "has no pip unless you pass --seed. To use reticulate's managed ",
          "environment instead, deactivate or remove the environment above ",
          "and install again.\nUnderlying error: ",
          conditionMessage(installError)
        )
      }
    )
    reticulate::py_run_string("import synapseclient")
  }
)

reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf(
  "sys.path.append(\"%s\")",
  file.path(baseDir, "inst", "python")
))

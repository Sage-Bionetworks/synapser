# R script to install the Synapse Python client
# The script itself is written in Python.  This is simply a wrapper to call it
# via the rWithPython package
#
# Author: bhoff
###############################################################################

# library(reticulate)
args <- commandArgs(trailingOnly = TRUE)
baseDir<-args[1]

if (is.null(baseDir) || is.na(baseDir) || !file.exists(baseDir)) {
	stop(paste("baseDir", baseDir, "is invalid"))
}
print("*** Using Python Configuration:")
reticulate::py_config()
reticulate::py_run_string("import sys")
reticulate::py_run_string(sprintf("sys.path.append(\"%s\")", file.path(baseDir, "inst", "python")))
reticulate::py_install(c("requests", "synapseclient[pandas,pysftp]", "jinja2", "markupsafe"), pip=T)
# reticulate::py_run_string("import installPythonClient")

# command<-sprintf("installPythonClient.main('%s')", baseDir)
# reticulate::py_eval(command)

# Run all tests
# run this from the base folder (i.e. the folder above 'src' and 'test'
# 
# Author: bhoff
###############################################################################
library(testthat)
library("synapse")

test_check("synapse", filter="unit")

canExecute<-TRUE

username<-Sys.getenv("SYNAPSE_USERNAME")
if (nchar(username)==0) {
	message("WARNING: Cannot run integration test.  Environment variable SYNAPSE_USERNAME is missing.")
	canExecute<-FALSE
}
apiKey<-Sys.getenv("SYNAPSE_APIKEY")
if (nchar(apiKey)==0) {
	message("WARNING: Cannot run integration test.  Environment variable SYNAPSE_APIKEY is missing.")
	canExecute<-FALSE
}

if (canExecute) {
	test_check("synapse", filter="integration")
}

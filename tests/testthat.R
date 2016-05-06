# Run all tests
# run this from the base folder (i.e. the folder above 'src' and 'test'
# 
# Author: bhoff
###############################################################################
library(testthat)
library("synapse")

test_check("synapse", filter="unit")
if (FALSE) { # if credentials are available
	test_check("synapse", filter="integration")
	
}

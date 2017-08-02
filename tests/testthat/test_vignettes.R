# This script runs all the markdown files and tests that they do not fail
# 
# Author: bhoff
###############################################################################

require(testthat)
require(synapser)

context("test_vignettes")

# build_vignettes either returns TRUE or throws an exception
expect_true(try(devtools::build_vignettes()))

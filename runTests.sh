#!/bin/bash
echo ".libPaths(c('$R_LIBS_USER', .libPaths()));" > runTests.R
echo "setwd(sprintf('%s/tests', getwd()));" >> runTests.R
echo "source('testthat.R')" >> runTests.R
echo "library(synapser);" >> runTests.R
echo "detach(\"package:synapser\", unload=TRUE);" >> runTests.R
echo "library(synapser)" >> runTests.R
R --vanilla < runTests.R
rm runTests.R

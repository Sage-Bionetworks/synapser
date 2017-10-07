# This script runs all the markdown files and tests that they do not fail
# 
# Author: bhoff
###############################################################################

require(testthat)
require(synapser)

context("test_createRdFiles")

source("../../tools/createRdFiles.R")

rawString<-":param modified_time: float representing seconds since unix epoch"
expected<-"\nmodified_time: float representing seconds since unix epoch"
expect_equal(processDetails(rawString), expected)

rawString<-":returns: some returned value"
expected<-"returns: some returned value"
expect_equal(processDetails(rawString), expected)

rawString<-"foo bar.  Example:: for example..."
expected<-"foo bar.  "
expect_equal(processDetails(rawString), expected)

rawString<-"end of the text we want:: text we don't want"
expected<-"end of the text we want"
expect_equal(processDetails(rawString), expected)

rawString<-"An updated :py:class:`synapseclient.activity.Activity` object"
expected<-"An updated Activity object"
expect_equal(processDetails(rawString), expected)

rawString<-"Once that's done, you'll be able to load the library, create a :py:class:`Synapse` object and login"
expected<-"Once that's done, you'll be able to load the library, create a Synapse object and login"
expect_equal(processDetails(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery`"
expected<-"See also: synChunkedQuery"
expect_equal(processDetails(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery` ... More robust than :py:func:`synapseclient.Synapse.query`"
expected<-"See also: synChunkedQuery ... More robust than synQuery"
expect_equal(processDetails(rawString), expected)



# Unit tests for blacklist checking logic
# 
# Author: brucehoff
###############################################################################



unitTestMajorVersion <- function() {
  expect_equal("0.10", synapseClient:::.majorVersion("0.10"))
  expect_equal("0.10", synapseClient:::.majorVersion("0.10-1"))
  expect_equal("1.0", synapseClient:::.majorVersion("1.0-0"))
  expect_true(synapseClient:::.majorVersionDiff("1.0-1", "1.1-1"))
  expect_true(!synapseClient:::.majorVersionDiff("1.0-1", "1.0"))
  expect_true(!synapseClient:::.majorVersionDiff("1.0-1", "1.0-2"))
}


# Unit tests for blacklist checking logic
# 
# Author: brucehoff
###############################################################################



unitTestMajorVersion <- function() {
  checkEquals("0.10", synapseClient:::.majorVersion("0.10"))
  checkEquals("0.10", synapseClient:::.majorVersion("0.10-1"))
  checkEquals("1.0", synapseClient:::.majorVersion("1.0-0"))
  checkTrue(synapseClient:::.majorVersionDiff("1.0-1", "1.1-1"))
  checkTrue(!synapseClient:::.majorVersionDiff("1.0-1", "1.0"))
  checkTrue(!synapseClient:::.majorVersionDiff("1.0-1", "1.0-2"))
}


# Unit tests for blacklist checking logic
# 
# Author: brucehoff
###############################################################################

.generateBlackList<-function() {
  list(	list("server"="*","client"="0.0.0"),
		list("server"="1.15.0-8-ge79db7a","client"="0.10"),
    list("server"="1.14.0-1-f84egda0","client"="<0.70"),
    list("server"="1.14.9-1-fj7383hd","client"="<=0.70"),
    list("server"="1.13.0-2-vj474hdh","client"=">0.10-0"),
    list("server"="xyz","client"=">=0.10-0"),
    list("server"="1.12.0-7-ch24528f","client"="0.05"),
		list("server"="1.12.0-7-ch24528f","client"="0.19-0"))
}

unitTestOK <- function() {
  checkTrue(!synapseClient:::.versionIsBlackListed("0.19", "1234", .generateBlackList()))
}

# not black listed for this server
unitTestServerSpecific<-function() {
  checkTrue(!synapseClient:::.versionIsBlackListed("0.10", "1234", .generateBlackList()))
  
}

unitTestWildcard <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.0.0", "1234", .generateBlackList()))
}

unitTestEquals <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.10", "1.15.0-8-ge79db7a", .generateBlackList()))
}

unitTestMulti <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.05", "1.12.0-7-ch24528f", .generateBlackList()))
  checkTrue(synapseClient:::.versionIsBlackListed("0.19-0", "1.12.0-7-ch24528f", .generateBlackList()))
}

unitTestLessThan <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.60", "1.14.0-1-f84egda0", .generateBlackList()))
  checkTrue(!synapseClient:::.versionIsBlackListed("0.70", "1.14.0-1-f84egda0", .generateBlackList()))
}

unitTestLessThanOrEquals <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.60", "1.14.9-1-fj7383hd", .generateBlackList()))
  checkTrue(synapseClient:::.versionIsBlackListed("0.70", "1.14.9-1-fj7383hd", .generateBlackList()))
  checkTrue(!synapseClient:::.versionIsBlackListed("0.70-3", "1.14.9-1-fj7383hd", .generateBlackList()))
}

unitTestGreaterThan <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.11", "1.13.0-2-vj474hdh", .generateBlackList()))
  checkTrue(!synapseClient:::.versionIsBlackListed("0.10-0", "1.13.0-2-vj474hdh", .generateBlackList()))
  checkTrue(!synapseClient:::.versionIsBlackListed("0.09", "1.13.0-2-vj474hdh", .generateBlackList()))
}

unitTestGreaterThanOrEquals <- function() {
  checkTrue(synapseClient:::.versionIsBlackListed("0.11", "xyz", .generateBlackList()))
  checkTrue(synapseClient:::.versionIsBlackListed("0.10-0", "xyz", .generateBlackList()))
  checkTrue(!synapseClient:::.versionIsBlackListed("0.09", "xyz", .generateBlackList()))
}
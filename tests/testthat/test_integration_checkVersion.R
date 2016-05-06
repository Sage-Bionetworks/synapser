
.setUp <-
  function()
{
  # set versions service endpoint
  synapseClient:::.setCache('oldVersionsEndpoint', synapseClient:::.getVersionsEndpoint())
  synapseClient:::synapseVersionsServiceEndpoint("http://dev-versions.synapse.sagebase.org/synapseRClient")
  .clearCachedVersionInfo()
}

.tearDown <- 
  function()
{
  # set versions service endpoint
  synapseClient:::synapseVersionsServiceEndpoint(synapseClient:::.getCache('oldVersionsEndpoint'))
  .clearCachedVersionInfo()
}

.clearCachedVersionInfo<-function() {
  cacheTimestampName<-"versionsInfoTimestamp"
  cacheVersionInfoName<-"versionsInfo"
  synapseClient:::.setCache(cacheTimestampName, NULL)
  synapseClient:::.setCache(cacheVersionInfoName, NULL)
}

integrationTestCheckServerVersion <- function() 
{
  v <- synapseClient:::getServerVersion()
  checkTrue(!is.null(v))
}

integrationTestCheckVersionLatest <- function()
{
  genericMessage<-"\n\nOn January 1, all clients will be required to upgrade to the latest version.\n"

  # latest version, should just display the 'message' field
  message<-synapseClient:::.checkLatestVersionGivenMyVersion("0.19-0", "1.15.0-8-ge79db7a")
  checkEquals(genericMessage, message)
  error<-try(synapseClient:::.checkBlackListGivenMyVersion("0.19-0", "1.15.0-8-ge79db7a"), silent=TRUE)
  checkTrue(is.null(error))
  }

integrationTestCheckVersionOld <- function()
{
   
  # old version (not blacklisted), should display message to upgrade
  message<- synapseClient:::.checkLatestVersionGivenMyVersion("0.18", "1.15.0-8-ge79db7a")
  upgradeMessage<-"Please upgrade to the latest version of the Synapse Client, 0.19-0, by running the following commands:\n\tsource('http://depot.sagebase.org/CRAN.R')\n\tpkgInstall(\"synapseClient\")\n\nThis version includes new provenance features.\n\nOn January 1, all clients will be required to upgrade to the latest version.\n"
  
  checkEquals(upgradeMessage, message)
  error<-try(synapseClient:::.checkBlackListGivenMyVersion("0.18", "1.15.0-8-ge79db7a"), silent=TRUE)
  checkTrue(is.null(error))

}

integrationTestCheckVersionOldLatestIsBlacklisted <- function()
{
  
  # old version (not blacklisted), should suppress message to upgrade
  message<- synapseClient:::.checkLatestVersionGivenMyVersion("0.18", "1.12.0-7-ch24528f")
  upgradeMessage<-"\n\nOn January 1, all clients will be required to upgrade to the latest version.\n"
  checkEquals(upgradeMessage, message)
  error<-try(synapseClient:::.checkBlackListGivenMyVersion("0.18", "1.12.0-7-ch24528f"), silent=TRUE)
  checkTrue(is.null(error))
  
}


integrationTestCheckVersionBlackListed <- function()
{
  # black listed version, should throw exception
  error<-try(synapseClient:::.checkBlackListGivenMyVersion("0.10", "1.15.0-8-ge79db7a"), silent=TRUE)
  checkEquals("try-error", class(error))
  blackListMessage<-"This version of the Synapse Client, 0.10, has been disabled.  Please upgrade to the latest version, 0.19-0.\nTo upgrade:\n\tsource('http://depot.sagebase.org/CRAN.R')\n\tpkgInstall('synapseClient')\nOn January 1, all clients will be required to upgrade to the latest version.\n"
  checkTrue(any(grep(blackListMessage, error[1], fixed=TRUE)))
}

integrationTestCheckVersionBlackListedLatestIsBlacklisted <- function()
{
  # black listed version, should throw exception
  error<-try(synapseClient:::.checkBlackListGivenMyVersion("0.05", "1.12.0-7-ch24528f"), silent=TRUE)
  checkEquals("try-error", class(error))
  blackListMessage<-"This version of the Synapse Client, 0.05, has been disabled.  To upgrade:\n\tsource('http://depot.sagebase.org/CRAN.R')\n\tpkgInstall('synapseClient')\nOn January 1, all clients will be required to upgrade to the latest version.\n"
  checkTrue(any(grep(blackListMessage, error[1], fixed=TRUE)))
}


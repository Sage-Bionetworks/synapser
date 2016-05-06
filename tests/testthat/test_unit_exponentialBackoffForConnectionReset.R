# Test expontential backoff/retry
# 
# Author: brucehoff
###############################################################################

.setUp <-
  function()
{
  synapseClient:::.setCache("exponentialBackoffWillFail", TRUE)
  synapseClient:::.setCache("permanent.redirects.resolved.REPO", TRUE)
  synapseClient:::.setCache("permanent.redirects.resolved.FILE", TRUE)
  ## this function will 'time out' the first time but pass the second time
  myGetUrl <- function(url, 
    customrequest, 
    .opts, 
    httpheader, 
    curl, 
    debugfunction) { 
    if (regexpr("/version", url, fixed=T)>=0) return("HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n{\"version\":\"foo\"}")
    willFail <-synapseClient:::.getCache("exponentialBackoffWillFail")
    if (willFail) {
      synapseClient:::.setCache("exponentialBackoffWillFail", FALSE)
      stop("Error in function (type, msg, asError = TRUE)  : Connection reset by peer") 
    } else {
      return(list(headers="HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n", body="{\"foo\":\"bar\"}"))
    }
  }
  attr(myGetUrl, "origDef") <- synapseClient:::.getURLIntern
  assignInNamespace(".getURLIntern", myGetUrl, "synapseClient")
  
  # also spoof checking black list, latest version
  myCheckBlackList<-function() {"ok"}
  attr(myCheckBlackList, "origDef") <- synapseClient:::checkBlackList
  assignInNamespace("checkBlackList", myCheckBlackList, "synapseClient")
  
  myCheckLatestVersion<-function() {"ok"}
  attr(myCheckLatestVersion, "origDef") <- synapseClient:::checkLatestVersion
  assignInNamespace("checkLatestVersion", myCheckLatestVersion, "synapseClient")
  
  myLogErrorToSynapse<-function(label, message) {NULL}
  attr(myLogErrorToSynapse, "origDef") <- synapseClient:::.logErrorToSynapse
  assignInNamespace(".logErrorToSynapse", myLogErrorToSynapse, "synapseClient")
}

.tearDown <-
  function()
{
  synapseClient:::.setCache("permanent.redirects.resolved.REPO", NULL)
  synapseClient:::.setCache("permanent.redirects.resolved.FILE", NULL)
  assignInNamespace(".getURLIntern", attr(synapseClient:::.getURLIntern, "origDef"), "synapseClient")
  assignInNamespace("checkBlackList", attr(synapseClient:::checkBlackList, "origDef"), "synapseClient")
  assignInNamespace("checkLatestVersion", attr(synapseClient:::checkLatestVersion, "origDef"), "synapseClient")
  assignInNamespace(".logErrorToSynapse", attr(synapseClient:::.logErrorToSynapse, "origDef"), "synapseClient")
  unloadNamespace('synapseClient')
  library(synapseClient)
}




unitTestExponentialBackoffShouldTimeout <- 
  function()
{
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will time out
  synapseClient:::.setCache("maxWaitDiffTime", 0)
  shouldBeError<-try(synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", 
      anonymous=T, opts=opts), silent=T)
  checkEquals("try-error", class(shouldBeError))
   
}

unitTestExponentialBackoffShouldComplete <- 
  function()
{
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will complete
  synapseClient:::.setCache("maxWaitDiffTime", as.difftime("00:30:00")) # 30 min
  synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", 
    anonymous=T, opts=opts)
  
}
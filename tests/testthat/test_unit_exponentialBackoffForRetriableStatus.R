# Test expontential backoff/retry
# 
# Author: brucehoff
###############################################################################


# note, I want slightly different set-ups for different tests, so I invoke it myself 
# (instead of letting the framework do it), passing a parameter
# example, mySetUp(503, "HTTP/1.1 503 Service Unavailable\r\nContent-Type: application/json\r\n\r\n")

mySetUp <- function(httpErrorStatusCode, errorMessage)
{
  synapseClient:::.setCache("httpRequestCount", 0)
  synapseClient:::.setCache("httpStatus", 200)
  synapseClient:::.setCache("permanent.redirects.resolved.REPO", TRUE)
  synapseClient:::.setCache("permanent.redirects.resolved.FILE", TRUE)
 ## this function will 'time out' the first time but pass the second time
  myGetUrl <- function(url, 
    customrequest, 
    httpheader, 
    curl, 
    debugfunction,
    .opts 
    ) { 
    if (regexpr("/version", url, fixed=T)>=0) {
      synapseClient:::.setCache("httpStatus", 200)
      return("HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n{\"version\":\"foo\"}")
    }
    httpRequestCount <-synapseClient:::.getCache("httpRequestCount")
    synapseClient:::.setCache("httpRequestCount", httpRequestCount+1)
    if (httpRequestCount<1) { # first time, it fails
      synapseClient:::.setCache("httpStatus", httpErrorStatusCode)
      return(errorMessage)
    } else {
      synapseClient:::.setCache("httpStatus", 200)
      return(list(headers="HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n", body="{\"foo\":\"bar\"}"))
    }
  }
  attr(myGetUrl, "origDef") <- synapseClient:::.getURLIntern
  assignInNamespace(".getURLIntern", myGetUrl, "synapseClient")
  
  myGetCurlInfo<-function(curlHandle=NULL) {
    list(response.code=synapseClient:::.getCache("httpStatus"))
  }
  attr(myGetCurlInfo, "origDef") <- synapseClient:::.getCurlInfo
  assignInNamespace(".getCurlInfo", myGetCurlInfo, "synapseClient")
  
  # also spoof checking black list, latest version
  myCheckBlackList<-function() {"ok"}
  myCheckLatestVersion<-function() {"ok"}
  attr(myCheckBlackList, "origDef") <- synapseClient:::checkBlackList
  assignInNamespace("checkBlackList", myCheckBlackList, "synapseClient")
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
  
  origDef<-attr(synapseClient:::.getURLIntern, "origDef")
  if (!is.null(origDef)) assignInNamespace(".getURLIntern", origDef, "synapseClient")
  
  origDef<-attr(synapseClient:::.getCurlInfo, "origDef")
  if (!is.null(origDef)) assignInNamespace(".getCurlInfo", origDef, "synapseClient")
  
  origDef<-attr(synapseClient:::checkBlackList, "origDef")
  if (!is.null(origDef)) assignInNamespace("checkBlackList", origDef, "synapseClient")
  
  origDef<-attr(synapseClient:::checkLatestVersion, "origDef")
  if (!is.null(origDef)) assignInNamespace("checkLatestVersion", origDef, "synapseClient")
  
  origDef<-attr(synapseClient:::.logErrorToSynapse, "origDef")
  if (!is.null(origDef)) assignInNamespace(".logErrorToSynapse", origDef, "synapseClient")
  
  unloadNamespace('synapseClient')
  library(synapseClient)
}




unitTestExponentialBackoffFor503ShouldFail <- 
  function()
{
  mySetUp(503, list(headers="HTTP/1.1 503 Service Unavailable\r\nContent-Type: application/json\r\n", body=""))
  
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will get a 503, and an empty response
	synapseClient:::.setCache("maxWaitDiffTime", 0)
  shouldBeEmpty<-synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", 
      anonymous=T, opts=opts, checkHttpStatus=FALSE)
  expect_equal("", shouldBeEmpty)
  expect_equal(503, synapseClient:::.getCurlInfo()$response.code)
}

unitTestExponentialBackoffFor503ShouldComplete <- 
  function()
{
  mySetUp(503, list(headers="HTTP/1.1 503 Service Unavailable\r\nContent-Type: application/json\r\n", body=""))
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will complete
	synapseClient:::.setCache("maxWaitDiffTime", as.difftime("00:30:00")) # 30 min
	result<-synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", anonymous=T, opts=opts)
  expect_equal(list(foo="bar"), result)
  expect_equal(200, synapseClient:::.getCurlInfo()$response.code)
}


unitTestExponentialBackoffFor502ShouldFail <- 
  function()
{
  mySetUp(502, list(headers="HTTP Error: 502 for request https://file-prod.prod.sagebase.org/repo/v1/query\r\n", body=""))
  
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will get a 502, and an empty response
	synapseClient:::.setCache("maxWaitDiffTime", 0)
	shouldBeEmpty<-synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", 
    anonymous=T, opts=opts, checkHttpStatus=FALSE)
  expect_equal("", shouldBeEmpty)
  expect_equal(502, synapseClient:::.getCurlInfo()$response.code)
}

unitTestExponentialBackoffFor502ShouldComplete <- 
  function()
{
  mySetUp(502, list(headers="HTTP Error: 502 for request https://file-prod.prod.sagebase.org/repo/v1/query\r\n", body=""))
  opts<-synapseClient:::.getCache("curlOpts")
  opts$timeout.ms<-100
  
  # this will complete
	synapseClient:::.setCache("maxWaitDiffTime", as.difftime("00:30:00")) # 30 min
	result<-synapseClient:::synapseGet("/query?query=select+id+from+entity+limit==500", anonymous=T, opts=opts)
  expect_equal(list(foo="bar"), result)
  expect_equal(200, synapseClient:::.getCurlInfo()$response.code)
}

unitTestExponentialBackoffFor404ShouldComplete <- function()
{
  synapseClient:::.setCache("httpRequestCount", 0)
  myGetCurlInfo<-function(curlHandle=NULL) {
    httpRequestCount <-synapseClient:::.getCache("httpRequestCount")
    synapseClient:::.setCache("httpRequestCount", httpRequestCount+1)
    if (httpRequestCount<2) { # first two times it fails
      synapseClient:::.setCache("httpStatus", 404)
    } else {
      synapseClient:::.setCache("httpStatus", 200)
    }
    list(response.code=synapseClient:::.getCache("httpStatus"))
  }
  attr(myGetCurlInfo, "origDef") <- synapseClient:::.getCurlInfo
  assignInNamespace(".getCurlInfo", myGetCurlInfo, "synapseClient")
  
  myLogErrorToSynapse<-function(label, message) {NULL}
  attr(myLogErrorToSynapse, "origDef") <- synapseClient:::.logErrorToSynapse
  assignInNamespace(".logErrorToSynapse", myLogErrorToSynapse, "synapseClient")
  
  curlHandle <- getCurlHandle() 
  synapseClient:::webRequestWithRetries(
    fcn=function(curlHandle) {
      "this is the response body"
    },
    curlHandle,
    extraRetryStatusCodes=404
  )  

}



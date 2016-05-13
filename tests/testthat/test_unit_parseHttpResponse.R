# 
# 
# Author: brucehoff
###############################################################################



unitTestBasicCase <- 
  function()
{
  # this is the response to an invalid log in
  # Note, it doesn't matter what version of HTTP is in the string (here we use A.B)
  s<-"HTTP/A.B 500 Internal Server Error\r\nContent-Type: application/json\r\nDate: Wed, 02 Jan 2013 17:42:18 GMT\r\nServer: Apache-Coyote/1.1\r\ntransfer-encoding: chunked\r\nConnection: keep-alive\r\n\r\n"
  ans <- synapseClient:::parseHttpHeaders(s)
  # parsed response has (1) status code, (2) status string, (3) headers
  expect_equal(3, length(ans))
  expect_equal(500, ans$statusCode)
  expect_equal("Internal Server Error", ans$statusString)
  expect_equal(5, length(ans$headers))
  expect_equal("Wed, 02 Jan 2013 17:42:18 GMT", ans$headers$Date)
  expect_equal("Apache-Coyote/1.1", ans$headers$Server)
  expect_equal("chunked", ans$headers$`transfer-encoding`)
  expect_equal("keep-alive", ans$headers$Connection)
}


unitTestRedirect <-
  function()
{
  # this is the response indicating a redirect.  there is no response body
  s<-"HTTP/1.1 301 Moved Permanently\r\nContent-Type: text/plain; charset=UTF-8\r\nDate: Wed, 02 Jan 2013 17:50:10 GMT\r\nLocation: https://auth-dev-xschildw.dev.sagebase.org/auth/v1/session\r\nServer: Apache-Coyote/1.1\r\nContent-Length: 0\r\nConnection: keep-alive\r\n\r\n"
  ans <- synapseClient:::parseHttpHeaders(s)
  # parsed response has (1) status code, (2) status string, (3) headers
  expect_equal(3, length(ans))
  expect_equal(301, ans$statusCode)
  expect_equal("Moved Permanently", ans$statusString)
  expect_equal(6, length(ans$headers))
  expect_equal("Wed, 02 Jan 2013 17:50:10 GMT", ans$headers$Date)
  expect_equal("https://auth-dev-xschildw.dev.sagebase.org/auth/v1/session", ans$headers$Location)
  expect_equal("Apache-Coyote/1.1", ans$headers$Server)
  expect_equal("0", ans$headers$`Content-Length`)
  expect_equal("keep-alive", ans$headers$Connection) 
}

unitTestConnectionEstablished <-
  function()
{
  s<-"HTTP/1.0 200 Connection established\r\n\r\nHTTP/1.1 200 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Type: application/json\r\nDate: Thu, 20 Feb 2014 00:44:53 GMT\r\nServer: Apache-Coyote/1.1\r\nContent-Length: 29\r\nConnection: keep-alive\r\n\r\n"
  ans <- synapseClient:::parseHttpHeaders(s)
  # parsed response has (1) status code, (2) status string, (3) headers
  expect_equal(3, length(ans))
  expect_equal(200, ans$statusCode)
  expect_equal("OK", ans$statusString)
  expect_equal(6, length(ans$headers))
  expect_equal("Thu, 20 Feb 2014 00:44:53 GMT", ans$headers$Date)
  expect_equal("Apache-Coyote/1.1", ans$headers$Server)
  expect_equal("29", ans$headers$`Content-Length`)
  expect_equal("keep-alive", ans$headers$Connection)
}

unitTestConnectionEstablishedPROXY<-function() {
	s<-"HTTP/1.0 200 Connection established\r\nVia: HTTP/1.1 proxy10415\r\n\r\n\r\nHTTP/1.1 299 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Type: application/json;charset=UTF-8\r\nDate: Fri, 17 Apr 2015 17:39:21 GMT\r\nETag: 6955836b-e2d4-48bc-b986-589979e94c41\r\nServer: Apache-Coyote/1.1\r\nVary: Accept-Encoding,User-Agent\r\nContent-Length: 481\r\nConnection: keep-alive"
	ans <- synapseClient:::parseHttpHeaders(s)
	# parsed response has (1) status code, (2) status string, (3) headers
	expect_equal(3, length(ans))
	expect_equal(299, ans$statusCode) # using a made-up code, just to check the parser
	expect_equal("OK", ans$statusString)
	expect_equal(8, length(ans$headers))
	expect_equal("*", ans$headers$`Access-Control-Allow-Origin`)
	expect_equal("application/json;charset=UTF-8", ans$headers$`Content-Type`)
	expect_equal("Fri, 17 Apr 2015 17:39:21 GMT", ans$headers$Date)	
	expect_equal("6955836b-e2d4-48bc-b986-589979e94c41", ans$headers$ETag)
	expect_equal("Apache-Coyote/1.1", ans$headers$Server)
	expect_equal("Accept-Encoding,User-Agent", ans$headers$Vary)	
	expect_equal("481", ans$headers$`Content-Length`)
	expect_equal("keep-alive", ans$headers$Connection)	
}


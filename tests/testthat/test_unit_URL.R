## Unit test URL parser
## 
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

.setUp <- 
  function()
{
  synapseClient:::.setCache("testInput","https://fakehost.com/fakePathPrefix.org/fakeFile.zip?Expires=1307658150&AWSAccessKeyId=AKIAI3BTGJG752CCJUVA&Signature=sN%2FNePyyQnkKwOWgTOxnLB5f42s%3D")
}

.tearDown <- 
  function()
{
  synapseClient:::.deleteCache("testInput")
}

unitTestGetProtocol <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@protocol, "https")
}

unitTestGetHost <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@host, "fakehost.com")
}

unitTestGetPathPrefix <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@pathPrefix, "/fakePathPrefix.org")
}

unitTestGetFileName <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@file, "fakeFile.zip")
}

unitTestGetQueryString <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@queryString, "Expires=1307658150&AWSAccessKeyId=AKIAI3BTGJG752CCJUVA&Signature=sN%2FNePyyQnkKwOWgTOxnLB5f42s%3D")
}

unitTestGetPath <- 
  function()
{
  url <- synapseClient:::.ParsedUrl(synapseClient:::.getCache("testInput"))
  expect_equal(url@path, "/fakePathPrefix.org/fakeFile.zip")
}

unitTestGetHostWithPort <- 
  function() 
{
  url <- synapseClient:::.ParsedUrl('http://fakeHost:0000/services-authentication-fakeRelease-SNAPSHOT/auth/v1')
  expect_equal(url@authority, 'fakeHost:0000')
  expect_equal(url@host, 'fakeHost')
  expect_equal(url@port, '0000')
  expect_equal(url@path, '/services-authentication-fakeRelease-SNAPSHOT/auth/v1')
  expect_equal(url@file, 'v1')
  expect_equal(url@pathPrefix, '/services-authentication-fakeRelease-SNAPSHOT/auth')
}

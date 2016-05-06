# unit tests for functions in uploadFile and uploadStringToFile
# 
# Author: brucehoff
###############################################################################

unitTestGetDirectorySequence <- function() {
  checkEquals(synapseClient:::getDirectorySequence(""), "")
  checkEquals(synapseClient:::getDirectorySequence("/"), "/")
  checkEquals(synapseClient:::getDirectorySequence("foo"), "foo")
  checkEquals(synapseClient:::getDirectorySequence("/foo"), "/foo")
  checkEquals(synapseClient:::getDirectorySequence("foo/"), "foo")
  checkEquals(synapseClient:::getDirectorySequence("/foo/"), "/foo")
  checkEquals(synapseClient:::getDirectorySequence("foo/bar"), c("foo", "foo/bar"))
  checkEquals(synapseClient:::getDirectorySequence("foo/bar/"), c("foo", "foo/bar"))
  checkEquals(synapseClient:::getDirectorySequence("/foo/bar"), c("/foo", "/foo/bar"))
  checkEquals(synapseClient:::getDirectorySequence("/foo/bar/"), c("/foo", "/foo/bar"))
  checkEquals(synapseClient:::getDirectorySequence("/foo/bar/bas"), c("/foo", "/foo/bar", "/foo/bar/bas"))
  checkEquals(synapseClient:::getDirectorySequence("foo/bar/bas"), c("foo", "foo/bar", "foo/bar/bas"))
  checkEquals(synapseClient:::getDirectorySequence("foo/bar/bas/"), c("foo", "foo/bar", "foo/bar/bas"))
}

unitTestCacheCredentials<-function() {
  testuser<-sprintf("testuser_%s", sample(1000, 1))
  testpassword<-sprintf("testpassword_%s", sample(1000, 1))
  synapseClient:::.setCache("sftp://testhost.com_credentials", list(username=testuser, password=testpassword))
  creds<-synapseClient:::getCredentialsForHost(synapseClient:::.ParsedUrl("sftp://testhost.com/foo/bar"))
  checkEquals(testuser, creds$username)
  checkEquals(testpassword, creds$password)
}

unitTestStringMd5<-function() {
	checkEquals(synapseClient:::stringMd5("foo"), "acbd18db4cc2f85cedef654fccc4a4d8")
}


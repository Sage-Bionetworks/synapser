# Unit test of downloadFromServiceWithCaching
# 
# Author: bhoff
###############################################################################

fileHandleId<-function() {"11111"}

.setUp <- function() {
	unlink(synapseClient:::defaultDownloadLocation(fileHandleId()), recursive=T, force=T)
	
	content<-"this is a test"
	filePath<- tempfile(fileext = ".txt")
	connection<-file(filePath)
	writeChar(content, connection, eos=NULL)
	close(connection)  
	
	synapseClient:::.setCache("filePath", filePath)
	
	synapseClient:::.mock("downloadFromService", function(...) {list(downloadedFile=filePath, fileName="foo.txt")})

}

.tearDown <- function() {
	synapseClient:::.setCache("filePath", NULL)
	synapseClient:::.unmockAll()
}

unitTest_downloadFromServiceWithCaching<-function() {
	filePath<-synapseClient:::.getCache("filePath")
	synapseClient:::downloadFromServiceWithCaching("/foo", "FILE", fileHandleId(), tools::md5sum(path.expand(filePath)))
}

unitTest_downloadFromServiceWithCachingWrongMD5<-function() {
	 expect_error(synapseClient:::downloadFromServiceWithCaching("/foo", "FILE", fileHandleId(), "xxxxxxx"))
}


## Unit test getCachedInLocation
## 
## 
###############################################################################

createFile<-function(content, filePath) {
	if (missing(content)) content<-"this is a test"
	if (missing(filePath)) filePath<- tempfile()
	connection<-file(filePath)
	writeChar(content, connection, eos=NULL)
	close(connection)  
	filePath
}

.tearDown <- function() {
	unlink(synapseClient:::cacheMapFilePath(10100))
}

unitTestGetCachedInLocation <-function() {
	fileHandleId<-10100
	filePath1<-createFile()
	filePath2<-createFile()
	
	# filePath1 will be in the cacheMap, but with a last-modified date of yesterday
	day_incr <- -1
	mod_timestamp<-as.Date(as.numeric(
					synapseClient:::lastModifiedTimestamp(filePath1))/(24*3600)+day_incr, 
			"1970-01-01")
	synapseClient:::addToCacheMap(fileHandleId, filePath1, timestamp=mod_timestamp)
	
	# filePath2 is in the cacheMap, unmodified
	synapseClient:::addToCacheMap(fileHandleId, filePath2)
	
	result<-synapseClient:::getCachedInLocation(fileHandleId, dirname(filePath1))
	checkEquals(normalizePath(result$any), normalizePath(filePath1))
	checkEquals(normalizePath(result$unchanged), normalizePath(filePath2))
	
	# findCachedFile is like getCachedInLocation but is not specific to any location
	result<-synapseClient:::findCachedFile(fileHandleId)
	checkEquals(normalizePath(result$any), normalizePath(filePath1))
	checkEquals(normalizePath(result$unchanged), normalizePath(filePath2))
	
}




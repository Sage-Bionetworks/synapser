# Test Chunked File Upload
# 
# Author: brucehoff
###############################################################################
library(rjson)

# this is a set of convenience functions for global variables
# global getter
g<-function(key) {synapseClient:::.getCache(key)}
# global getter, turning nulls to zeros
gInt<-function(key) {
	result<-g(key)
	if (is.null(result)) result<-as.integer(0)
	result
}
s<-function(key, value) {
	synapseClient:::.setCache(key, value)
	allCtrs<-g("test_ChunkedFileUpload_counters")
	allCtrs<-unique(c(allCtrs, key))
	synapseClient:::.setCache("test_ChunkedFileUpload_counters", allCtrs)
}
clearAllCtrs<-function() {
	toClear<-synapseClient:::.getCache("test_ChunkedFileUpload_counters")
	for (key in toClear) synapseClient:::.setCache(key, NULL)
	synapseClient:::.setCache("test_ChunkedFileUpload_counters", NULL)
}

inc<-function(key) {
	value<-gInt(key)
	s(key, value+1)
	value+1
}

o<-function(key) {
	message(key, ": ", g(key))
}

# return TRUE iff the string 's' contains the substring 'sub'
contains<-function(s, sub) {regexpr(sub, s)[1]>=0}

.setUp <- function() {
	clearAllCtrs()
	# mock a file which will have three 'chunks'
	synapseClient:::.mock("syn.file.info", function(...) {list(size=as.integer(5242880*2.5))})
	synapseClient:::.mock("syn.readBin", function(conn,what,n) {"some file content"})
	
	synapseClient:::.mock("syn.seek", function(conn,n) {
				key<-"seek"
				cntr<-gInt(key) # how many times has this mock been called?
				inc(key)
				s(sprintf("seek.%s", cntr), n)
				n
	})
}

.tearDown <- function() {
	clearAllCtrs()
  synapseClient:::.unmockAll()
}

createFileToUpload<-function() {
	# create a file to upload
	content<-"this is a test"
	filePath<- tempfile(fileext = ".txt")
	connection<-file(filePath)
	writeChar(content, connection, eos=NULL)
	close(connection)  
	filePath
}

mockSynapsePost<-function() {
	synapseClient:::.mock("synapsePost", function(uri, entity, ...) {
				if (uri=="/file/multipart") {
					s("/file/multipart_filename", entity$fileName)
					s("/file/multipart_filesize", entity$fileSize)
					key<-"post_/file/multipart"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					# let's say two of three chunks need to be uploaded
					list(uploadId="101", partsState="100")
				} else if (contains(uri, "/presigned/url/batch")) {
					key<-"post_/presigned/url/batch"
					inc(key)
					list(partPresignedUrls=list(
									list(partNumber=as.integer(2), uploadPresignedUrl="/url22"),
									list(partNumber=as.integer(3), uploadPresignedUrl="/url33")
							)
					)
				} else {
					stop("unexpected uri: ", uri)
				}
			})
}

mockSynapsePut<-function() {
	synapseClient:::.mock("synapsePut", function(uri, ...) {
				if (contains(uri, "add")) {
					key<-"put_add"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					# there are just two parts to put
					if (cntr>=2) stop(sprintf("Unexpected value for %s %d.", key, cntr))
					list(addPartState="ADD_SUCCESS")
				} else if (contains(uri, "complete")) {
					key<-"put_complete"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					# should just be called once (so counter is zero)
					if (cntr>=1) stop(sprintf("Unexpected value for %s %d.", key, cntr))
					list(state="COMPLETED", resultFileHandleId="202")
				} else {
					stop("unexpected uri: ", uri)
				}
			})
}

mockSynapseGet<-function() {
	synapseClient:::.mock("synapseGet", function(uri, ...) {
				if (contains(uri, "/fileHandle")) {
					key<-"get_fileHandle"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					# should just be called once (so counter is zero)
					if (cntr>=1) stop(sprintf("Unexpected value for %s %d.", key, cntr))
					list(id="222")
				} else {
					stop("unexpected uri: ", uri)
				}
			})
}

mockCurlRawUpload<-function() {
	synapseClient:::.mock("curlRawUpload", function(...) {
				key<-"curlRawUpload"
				inc(key)
				TRUE # success
			})
}

# In this 'happy case', there are three chunks, one already uploaded.
# The remaining two are uploaded and the job completes.
unitTestChunkedUpload <- function() {
	
	filePath<-createFileToUpload()
	
	mockSynapsePost()
	
	mockSynapsePut()
	
	mockSynapseGet()
	
	mockCurlRawUpload()
	  
	#
	# This is the method under test
	#
	fileHandle <- synapseClient:::chunkedUploadFile(filePath)
	
	checkEquals(fileHandle$id, "222")
 
	checkEquals(g("/file/multipart_filename"), basename(filePath))
	checkEquals(g("/file/multipart_filesize"), as.integer(5242880*2.5))
	
	# should have called 'POST /file/multipart' once
	checkEquals(gInt("post_/file/multipart"), as.integer(1))
	
	# check that /presigned/url/batch was called once
	checkEquals(gInt("post_/presigned/url/batch"), as.integer(1))
	
	# check that two parts were added
	checkEquals(gInt("put_add"), as.integer(2))
	
	# check that 'complete' was called once
	checkEquals(gInt("put_complete"), as.integer(1))
	
	# check that GET /fileHandle was called once
	checkEquals(gInt("get_fileHandle"), as.integer(1))
	
	# check that two parts were uploaded
	checkEquals(gInt("curlRawUpload"), as.integer(2))
	
	# check that 'seek' was called the right number of times
	# remember, only two of three chunks needed to be uploaded
	checkEquals(g("seek"), as.integer(2))

	# check that 'seek' was called with the right values
	checkEquals(g("seek.0"), as.integer(5242880)) # chunk #2
	checkEquals(g("seek.1"), as.integer(2*5242880)) # chunk #3

}

# check the case in which a chunk fails to upload on the first try,
# (curlRawUpload returns false) but works on the second try
# count the 'PUT .../add...' calls to make sure we don't try to add a part
# that wasn't uploaded
unitTestChunkedUploadTempFailure <- function() {
	
	filePath<-createFileToUpload()
	
	synapseClient:::.mock("synapsePost", function(uri, entity, ...) {
				if (uri=="/file/multipart") {
					key<-"post_/file/multipart"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					if (cntr==0) {
						# let's say two of three chunks need to be uploaded
						list(uploadId="101", partsState="100")
					} else if (cntr==1) {
						# just the last of three chunks need to be uploaded
						list(uploadId="101", partsState="110")
					} else {
						stop(sprintf("Unexpected value for %s %d.", key, cntr))
					}
				} else if (contains(uri, "/presigned/url/batch")) {
					key<-"post_/presigned/url/batch"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					if (cntr==0) {
						list(partPresignedUrls=list(
										list(partNumber=as.integer(2), uploadPresignedUrl="/url22"),
										list(partNumber=as.integer(3), uploadPresignedUrl="/url33")
								)
						)
					} else if (cntr==1) {
						list(partPresignedUrls=list(
										list(partNumber=as.integer(3), uploadPresignedUrl="/url33")
								)
						)
					} else {
						# shouldn't call a third time
						stop(sprintf("Unexpected value for %s %d.", key, cntr))
					}
				} else {
					stop("unexpected uri: ", uri)
				}
			})	
	
	synapseClient:::.mock("synapsePut", function(uri, ...) {
				if (contains(uri, "add")) {
					key<-"put_add"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					# there are just two parts to put
					if (cntr>=2) stop(sprintf("Unexpected value for %s %d.", key, cntr))
					list(addPartState="ADD_SUCCESS")
				} else if (contains(uri, "complete")) {
					key<-"put_complete"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					if (cntr==0) {
						list(state="INCOMPLETE", partsState="110") # must not have a value for resultFileHandleId
					} else if (cntr==1) {
						list(state="COMPLETED", partsState="111", resultFileHandleId="202")
					} else {
						# shouldn't call a third time
						stop(sprintf("Unexpected value for %s %d.", key, cntr))
					}
				} else {
					stop("unexpected uri: ", uri)
				}
			})
	
	mockSynapseGet()
	
	synapseClient:::.mock("curlRawUpload", function(...) {
				key<-"curlRawUpload"
				cntr<-gInt(key) # how many times has this mock been called?
				inc(key)
				# should  be called three times
				if (cntr==0) {
					TRUE # first of two chunks uploads successfully
				} else if (cntr==1) {
					FALSE # second of two chunks fails
				} else if (cntr==2) {
					TRUE # second of two chunks works on the third try
				} else {
					stop(sprintf("Unexpected value for %s %d.", key, cntr))
				}
			})
	
	#
	# This is the method under test
	#
	fileHandle <- synapseClient:::chunkedUploadFile(filePath)
	
	checkEquals(fileHandle$id, "222")
	
	# should have called 'POST /file/multipart' twice
	checkEquals(gInt("post_/file/multipart"), as.integer(2))
	
	# check that /presigned/url/batch was called twice
	checkEquals(gInt("post_/presigned/url/batch"), as.integer(2))
	
	# check that two parts were added
	checkEquals(gInt("put_add"), as.integer(2))
	
	# check that 'complete' was called twice
	checkEquals(gInt("put_complete"), as.integer(2))
	
	# check that GET /fileHandle was called once
	checkEquals(gInt("get_fileHandle"), as.integer(1))
	
	# check that there were three calls to curlRawUpload
	checkEquals(gInt("curlRawUpload"), as.integer(3))
	
	# check that 'seek' was called the right number of times
	# remember, only two of three chunks needed to be uploaded
	checkEquals(g("seek"), as.integer(3))
	
	# check that 'seek' was called with the right values
	checkEquals(g("seek.0"), as.integer(5242880)) # chunk #2
	checkEquals(g("seek.1"), as.integer(2*5242880)) # chunk #3
	checkEquals(g("seek.2"), as.integer(2*5242880)) # chunk #3
	
}

# The case in which the upload never completes
unitTestChunkedUploadPermFailure <- function() {
	
	filePath<-createFileToUpload()
	
	# whenever it's asked it says the same two chunks need to be uploaded
	mockSynapsePost()
	
	# the 'add chunk' step fails
	synapseClient:::.mock("synapsePut", function(uri, ...) {
				if (contains(uri, "add")) {
					key<-"put_add"
					inc(key)
					list(addPartState="ADD_FAILURE")
				} else if (contains(uri, "complete")) {
					key<-"put_complete"
					inc(key)
					list(state="INCOMPLETE", partsState="100")
				} else {
					stop("unexpected uri: ", uri)
				}
			})
	
	mockSynapseGet()
	
	# the actual chunk upload works, it's the 'add chunk' step that fails in this scenario
	mockCurlRawUpload()
	
	#
	# This is the method under test
	#
	checkException(
			synapseClient:::chunkedUploadFile(filePath)
	)
	
	# should have called 'POST /file/multipart' 7 times
	checkEquals(gInt("post_/file/multipart"), as.integer(7))
	
	# check that /presigned/url/batch was called 7 times
	checkEquals(gInt("post_/presigned/url/batch"), as.integer(7))
	
	# check that we tried to add two parts seven times
	checkEquals(gInt("put_add"), as.integer(14))
	
	# check that 'complete' was called 7 times
	checkEquals(gInt("put_complete"), as.integer(7))

	# check that GET /fileHandle was never called
	checkEquals(gInt("get_fileHandle"), as.integer(0))
	
	# check that there were 14 calls to curlRawUpload
	checkEquals(gInt("curlRawUpload"), as.integer(14))
}

# This  case in which the URL time limit is exceeded
unitTestChunkedUploadURLTimeLimitExceeded <- function() {
	
	filePath<-createFileToUpload()
	
	mockSynapsePost()
	
	synapseClient:::.mock("synapsePut", function(uri, ...) {
				if (contains(uri, "add")) {
					key<-"put_add"
					inc(key)
					list(addPartState="ADD_SUCCESS")
				} else if (contains(uri, "complete")) {
					key<-"put_complete"
					cntr<-gInt(key) # how many times has this mock been called?
					inc(key)
					if (cntr==0) {
						list(state="INCOMPLETE", partsState="100")
					} else {
						list(state="COMPLETED", partsState="111", resultFileHandleId="202")
					}
				} else {
					stop("unexpected uri: ", uri)
				}
			})
	
	mockSynapseGet()
	
	mockCurlRawUpload()
	
	# First time through we simulate the expiration
	synapseClient:::.mock("batchUrlTimeLimit", 
			function() {
				key<-"timelimit"
				cntr<-gInt(key) # how many times has this mock been called?
				inc(key)
				if (cntr==0) {
					"00:00:00" # expired!
				} else {
					"00:15:00" # the usual value
				}
			}
	)
	
	#
	# This is the method under test
	#
	fileHandle <- synapseClient:::chunkedUploadFile(filePath)
	
	checkEquals(fileHandle$id, "222")
	
	checkEquals(g("/file/multipart_filename"), basename(filePath))
	checkEquals(g("/file/multipart_filesize"), as.integer(5242880*2.5))
	
	# should have called 'POST /file/multipart' twice
	checkEquals(gInt("post_/file/multipart"), as.integer(2))
	
	# check that /presigned/url/batch was called twice
	checkEquals(gInt("post_/presigned/url/batch"), as.integer(2))
	
	# check that two parts were added
	checkEquals(gInt("put_add"), as.integer(2))
	
	# check that 'complete' was called twice
	checkEquals(gInt("put_complete"), as.integer(2))
	
	# check that GET /fileHandle was called once
	checkEquals(gInt("get_fileHandle"), as.integer(1))
	
	# check that two parts were uploaded
	checkEquals(gInt("curlRawUpload"), as.integer(2))
	
}

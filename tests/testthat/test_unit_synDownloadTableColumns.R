# unit tests for synDownloadTableColumns.R
# 
# Author: brucehoff
###############################################################################

.setUp <- function() {

}

.tearDown <- function() {
	synapseClient:::.unmockAll()
}

createFile<-function(dir) {
	if (!file.exists(dir)) dir.create(dir, recursive=T)
	filePath<- tempfile(tmpdir=dir)
	connection<-file(filePath)
	writeChar("this is a test", connection, eos=NULL)
	close(connection)  
	filePath
}

unitTest_synDownloadTableColumnsHappyPath<-function() {
	fileHandleIds<-as.character(sample(1000000, 3))
	# make sure there is no cached information
	for (fileHandleId in fileHandleIds) {
		unlink(synapseClient:::defaultDownloadLocation(fileHandleId))
	}
	df<-data.frame(string=c("a", "b", "c"), files=fileHandleIds, stringsAsFactors=FALSE)
	table<-Table("syn123", df)
	synapseClient:::.mock("downloadTableFileHandles",
			function(fhasToDownload) {
				successes<-list()
				for (fha in fhasToDownload) {
					fhId<-fha@fileHandleId
					filePath<-createFile(synapseClient:::defaultDownloadLocation(fhId))
					filePath<-normalizePath(filePath, winslash="/")
					synapseClient:::addToCacheMap(fhId, filePath)
					successes[[fhId]]<-filePath
				}
				list(successes=successes) # return the permanent failures (NONE)
			}
	)
	downloadResult<-synDownloadTableColumns(table, "files")
	
	expectedDownloadResult<-list()
	for (fhid in fileHandleIds) {
		expectedDownloadResult[[fhid]]<-synapseClient:::getCachedInLocation(fhid, 
				synapseClient:::defaultDownloadLocation(fhid))$unchanged
	}
	checkEquals(downloadResult, expectedDownloadResult)
}

unitTest_synDownloadTableColumnsIllegalFile<-function() {
	fileHandleIds<-as.character(sample(1000000, 3))
	illegalFHID<-fileHandleIds[length(fileHandleIds)] # let's say the last one is illegal (invalid or forbidden)
	# make sure there is no cached information
	for (fileHandleId in fileHandleIds) {
		unlink(synapseClient:::defaultDownloadLocation(fileHandleId))
	}
	df<-data.frame(string=c("a", "b", "c"), files=fileHandleIds, stringsAsFactors=FALSE)
	table<-Table("syn123", df)
	synapseClient:::.mock("downloadTableFileHandles",
			function(fhasToDownload) {
				permanentFailures<-list() 
				successes<-list()
				for (fha in fhasToDownload) {
					fhId<-fha@fileHandleId
					if (fhId==illegalFHID) {
						permanentFailures[[fhId]]<-"NOT FOUND"
					} else {
						filePath<-createFile(synapseClient:::defaultDownloadLocation(fhId))
						filePath<-normalizePath(filePath, winslash="/")
						synapseClient:::addToCacheMap(fhId, filePath)
						successes[[fhId]]<-filePath
					}
				}
				list(successes=successes, permanentFailures=permanentFailures)
			}
	)
	downloadResult<-synDownloadTableColumns(table, "files")
	
	expectedDownloadResult<-list()
	for (i in 1:2) {
		fhid<-fileHandleIds[i]
		expectedDownloadResult[[fhid]]<-synapseClient:::getCachedInLocation(fhid, 
				synapseClient:::defaultDownloadLocation(fhid))$unchanged
	}

	checkEquals(downloadResult[1:2], expectedDownloadResult)
  checkTrue(is.null(downloadResult[[3]]))
}

unitTest_synDownloadTableColumnsCachedFiles<-function() {
	fileHandleIds<-as.character(sample(1000000, 3))
	# make sure there is no cached information
	for (fileHandleId in fileHandleIds) {
		unlink(synapseClient:::defaultDownloadLocation(fileHandleId))
	}
	df<-data.frame(string=c("a", "b", "c"), files=fileHandleIds, stringsAsFactors=FALSE)
	table<-Table("syn123", df)
	
	# let's say one file is already downloaded
	filePath<-createFile(synapseClient:::defaultDownloadLocation(fileHandleIds[3]))
	synapseClient:::addToCacheMap(fileHandleIds[3], normalizePath(filePath, winslash="/"))
	
	synapseClient:::.mock("downloadTableFileHandles",
			function(fhasToDownload) {
				successes<-list()
				for (fha in fhasToDownload) {
					fhId<-fha@fileHandleId
					filePath<-createFile(synapseClient:::defaultDownloadLocation(fhId))
					filePath<-normalizePath(filePath, winslash="/")
					synapseClient:::addToCacheMap(fhId, filePath)
					successes[[fhId]]<-filePath
				}
				list(successes=successes) # return the permanent failures (NONE)
			}
	)
	downloadResult<-synDownloadTableColumns(table, "files")
	
	expectedDownloadResult<-list()
	for (fhid in fileHandleIds) {
		expectedDownloadResult[[fhid]]<-synapseClient:::getCachedInLocation(fhid, 
				synapseClient:::defaultDownloadLocation(fhid))$unchanged
	}
	checkEquals(downloadResult, expectedDownloadResult)
}

unitTest_synDownloadTableColumnsTemporaryFailure<-function() {
	fileHandleIds<-as.character(sample(1000000, 3))
	# make sure there is no cached information
	for (fileHandleId in fileHandleIds) {
		unlink(synapseClient:::defaultDownloadLocation(fileHandleId))
	}
	df<-data.frame(string=c("a", "b", "c"), files=fileHandleIds, stringsAsFactors=FALSE)
	table<-Table("syn123", df)
	synapseClient:::.mock("downloadTableFileHandles",
			function(fhasToDownload) {
				count<-synapseClient:::.getCache("synDownloadTableColumnsTemporaryFailure_count")
				synapseClient:::.setCache("synDownloadTableColumnsTemporaryFailure_count", count+1)
				successes<-list()
				fhaToSkip<-fhasToDownload[[1]]@fileHandleId
				for (fha in fhasToDownload) {
					fhId<-fha@fileHandleId
					if (count==0 && fhId==fhaToSkip) {
						# this simulates a file not being downloaded because either the zip file or the request itself was too big
					} else {
						filePath<-createFile(synapseClient:::defaultDownloadLocation(fhId))
						filePath<-normalizePath(filePath, winslash="/")
						synapseClient:::addToCacheMap(fhId, filePath)
						successes[[fhId]]<-filePath
					}
				}
				list(successes=successes) # return the permanent failures (NONE)
			}
	)
	synapseClient:::.setCache("synDownloadTableColumnsTemporaryFailure_count", 0)
	
	# this will make two passes, the first time getting two files and the second time getting the remaining one
	downloadResult<-synDownloadTableColumns(table, "files")
	
	# now check that we got all three files
	expectedDownloadResult<-list()
	for (fhid in fileHandleIds) {
		expectedDownloadResult[[fhid]]<-synapseClient:::getCachedInLocation(fhid, 
				synapseClient:::defaultDownloadLocation(fhid))$unchanged
	}
	checkEquals(downloadResult, expectedDownloadResult)
}


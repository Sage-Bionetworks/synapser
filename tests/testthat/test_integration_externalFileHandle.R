# integration test for external file handle
# 
# Author: bhoff
###############################################################################

.setUp <- function() {
	## create a project to fill with entities
	project <- createEntity(Project())
	synapseClient:::.setCache("testProject", project)
}

.tearDown <- function() {
	## delete the test projects
	deleteEntity(synapseClient:::.getCache("testProject"))

	synapseClient:::.unmockAll()
}

createFile<-function(content, filePath) {
	if (missing(content)) content<-"this is a test"
	if (missing(filePath)) filePath<- tempfile()
	connection<-file(filePath)
	writeChar(content, connection, eos=NULL)
	close(connection)  
	filePath
}

integrationTestExternalLinkLocalFile<-function() {
	project <- synapseClient:::.getCache("testProject")
	pid<-propertyValue(project, "id")
	
	# create a file to be uploaded
	synapseStore<-FALSE
	localfile<-createFile()
	localfile<-normalizePath(localfile, winslash="/")
	if (substr(localfile,1,2)=="C:") localfile=substr(localfile,3,nchar(localfile))
	filePath<-paste0("file://", localfile)
	file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
	
	# now store it
	storedFile<-synStore(file)
	
	# check that it worked
	checkTrue(!is.null(storedFile))
	id<-propertyValue(storedFile, "id")
	checkTrue(!is.null(id))
	checkEquals(propertyValue(project, "id"), propertyValue(storedFile, "parentId"))
	checkEquals(filePath, getFileLocation(storedFile))
	checkEquals(synapseStore, storedFile@synapseStore)
	
	# now download it.  This will pull a copy into the cache
	downloadedFile<-synGet(id)
	
	checkEquals(id, propertyValue(downloadedFile, "id"))
	checkEquals(FALSE, downloadedFile@synapseStore)

	fh<-downloadedFile@fileHandle
	checkEquals(filePath, fh$externalURL)
	checkEquals(file.info(localfile)$size, fh$contentSize)
	checkEquals(tools::md5sum(path.expand(localfile))[[1]], fh$contentMd5)
}


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
	expect_true(!is.null(storedFile))
	id<-propertyValue(storedFile, "id")
	expect_true(!is.null(id))
	expect_equal(propertyValue(project, "id"), propertyValue(storedFile, "parentId"))
	expect_equal(filePath, getFileLocation(storedFile))
	expect_equal(synapseStore, storedFile@synapseStore)
	
	# now download it.  This will pull a copy into the cache
	downloadedFile<-synGet(id)
	
	expect_equal(id, propertyValue(downloadedFile, "id"))
	expect_equal(FALSE, downloadedFile@synapseStore)

	fh<-downloadedFile@fileHandle
	expect_equal(filePath, fh$externalURL)
	expect_equal(file.info(localfile)$size, fh$contentSize)
	expect_equal(tools::md5sum(path.expand(localfile))[[1]], fh$contentMd5)
}


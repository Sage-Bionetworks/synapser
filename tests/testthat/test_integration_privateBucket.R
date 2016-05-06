# Integration tests for private S3 bucket
# 
# Author: bhoff
###############################################################################

.setUp <- function() {
	## create a project to fill with entities
	project <- createEntity(Project())
	synapseClient:::.setCache("testProject", project)
	projectId<-propertyValue(project, "id")
	
	sl<-synapseClient:::ExternalS3StorageLocationSetting()
	sl@bucket<-"r-client-integration-test.sagebase.org"
	sl@concreteType<-"org.sagebionetworks.repo.model.project.ExternalS3StorageLocationSetting"
	sl@uploadType<-"S3"
	sl@banner<-"*** Using private storage: r-client-integration-test.sagebase.org ***"
	response<-synRestPOST("/storageLocation", synapseClient:::createListFromS4Object(sl))
	
	sl<-synapseClient:::createS4ObjectFromList(response, "ExternalS3StorageLocationSetting")
	
	uds<-synapseClient:::UploadDestinationListSetting()
	uds@projectId<-projectId
	uds@settingsType<-"upload"
	uds@concreteType<-"org.sagebionetworks.repo.model.project.UploadDestinationListSetting"
	uds@locations<-c(sl@storageLocationId)
	
	response<-synRestPOST("/projectSettings", synapseClient:::createListFromS4Object(uds))
	
	uds<-synapseClient:::createS4ObjectFromList(response, "UploadDestinationListSetting")	
	synapseClient:::.setCache("testProjectSettings", uds)
}

.tearDown <- function() {
	projectSettings<-synapseClient:::.getCache("testProjectSettings")
	synRestDELETE(sprintf("/projectSettings/%s", projectSettings@id))
	## delete the test project
	deleteEntity(synapseClient:::.getCache("testProject"))
}


integrationTestPrivateBucketRoundTrip <- function() {
	project<-synapseClient:::.getCache("testProject")
	projectSettings<-synapseClient:::.getCache("testProjectSettings")
	projectId<-propertyValue(project, "id")
	
	# upload to private bucket
	filePath<- tempfile()
	connection<-file(filePath)
	writeChar(sprintf("this is a test %s", sample(999999999, 1)), connection, eos=NULL)
	close(connection)  
	originalMd5<-as.character(tools::md5sum(filePath))
	file<-File(path=filePath, parentId=projectId)
	file<-synStore(file)
	# check that it was uploaded to the right place
	storageLocationId<-projectSettings@locations[1]
	checkEquals(storageLocationId, file@fileHandle$storageLocationId)
	fileHandleId<-file@fileHandle$id
	
	# download file
	file<-synGet(propertyValue(file, "id"))
	checkEquals(originalMd5, as.character(tools::md5sum(getFileLocation(file))))
	checkEquals(storageLocationId, file@fileHandle$storageLocationId)
	
	# update file
	Sys.sleep(1.1) # make sure new timestamp will be different from original
	connection<-file(getFileLocation(file))
	writeChar(sprintf("this is a test %s", sample(999999999, 1)), connection, eos=NULL)
	close(connection)  
	modifiedMd5<-as.character(tools::md5sum(getFileLocation(file)))
	checkTrue(originalMd5!=modifiedMd5)
	file<-synStore(file)
	
	# download one last time
	file<-synGet(propertyValue(file, "id"), downloadLocation=tempdir())
	# check that it's a new file but stored in the same, private bucket
	checkEquals(modifiedMd5, as.character(tools::md5sum(getFileLocation(file))))
	checkEquals(storageLocationId, file@fileHandle$storageLocationId)
	checkTrue(file@fileHandle$id!=fileHandleId)
	
}
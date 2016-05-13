.setUp <-
  function()
{
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
}

.tearDown <-
  function()
{
  ## delete the test project
  deleteEntity(synapseClient:::.getCache("testProject"))
}

#
# This code exercises the file services underlying upload/download to/from an entity
#
integrationTestEntityFileAccess <-
  function()
{
    # create a Project
    project <- synapseClient:::.getCache("testProject")
    expect_true(!is.null(project))
    
    # create a file attachment which will be used in the wiki page
    # upload a file and receive the file handle
    filePath<- tempfile()
    connection<-file(filePath)
    writeChar("this is a test", connection, eos=NULL)
    close(connection)  
    
    fileHandle<-synapseClient:::chunkedUploadFile(filePath)
    
    # create an entity with the file
    entity <- list(
      concreteType="org.sagebionetworks.repo.model.FileEntity", # doesn't work for 'Data'
      name="foo", 
      parentId=propertyValue(project, "id"), 
      dataFileHandleId=fileHandle$id)
    entity <- synapseClient:::synapsePost("/entity", entity)
            
    # download the file
    # /entity/{enityId}/file
    downloadUri<-sprintf("/entity/%s/file?redirect=FALSE", entity$id)
    # download into a temp file
    downloadedFile<-synapseClient:::downloadFromService(downloadUri, destdir=synapseCacheDir())$downloadedFile
    origChecksum<- as.character(tools::md5sum(filePath))
    downloadedChecksum <- as.character(tools::md5sum(downloadedFile))
    expect_equal(origChecksum, downloadedChecksum)
    
    # delete the entity
    deleteEntity(entity$id)
}
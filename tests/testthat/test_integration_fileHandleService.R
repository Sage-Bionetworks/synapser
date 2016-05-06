
# this tests the file services underlying storeEntity
integrationTestFileHandle <-
  function()
{
    # upload a file and receive the file handle
    filePath<- tempfile()
    connection<-file(filePath)
    writeChar("this is a test", connection, eos=NULL)
    close(connection)  
    fileHandle<-synapseClient:::chunkedUploadFile(filePath)
    checkEquals(basename(filePath), fileHandle$fileName)
    checkEquals(synapseClient:::getMimeTypeForFile(basename(filePath)), fileHandle$contentType)
    # now try to retrieve the file handle given the id
    handleUri<-sprintf("/fileHandle/%s", fileHandle$id)
    fileHandle2<-synapseClient:::synapseGet(handleUri, endpoint=synapseFileServiceEndpoint())
    checkEquals(fileHandle, fileHandle2)
    # now delete the handle
    synapseClient:::synapseDelete(handleUri, endpoint=synapseFileServiceEndpoint())
    # now we should not be able to get the handle
    fileHandle3<-synapseClient:::synapseGet(handleUri, endpoint=synapseFileServiceEndpoint(), checkHttpStatus=F)
    checkTrue(regexpr("The resource you are attempting to access cannot be found", fileHandle3, fixed=T)[[1]]>0)
}

integrationTestExternalFileHandle <- function() {
  externalURL<-"http://google.com"
  contentType<-"text/html"
	contentSize<-1000
	contentMd5<-"abcdef"
  fileHandle <- synapseClient:::synapseLinkExternalFile(externalURL, contentType, contentSize, contentMd5, storageLocationId=NULL)
  checkTrue(!is.null(fileHandle$id))
  checkEquals("org.sagebionetworks.repo.model.file.ExternalFileHandle", fileHandle$concreteType)
  checkEquals(externalURL, fileHandle$externalURL)
  fileName<-basename(externalURL)
  checkEquals(fileName, fileHandle$fileName)
	checkEquals(contentType, fileHandle$contentType)
	checkEquals(contentSize, fileHandle$contentSize)
	checkEquals(contentMd5, fileHandle$contentMd5)
}

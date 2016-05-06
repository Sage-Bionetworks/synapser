#
#  integration tests for services around Wikis
#

.setUp <- function() {
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
}

.tearDown <- function() {
  ## delete the test project
  deleteEntity(synapseClient:::.getCache("testProject"))  
}

createFile<-function() {
  filePath<- tempfile()
  fileName<-basename(filePath)
  connection<-file(filePath)
  writeChar("this is a test", connection, eos=NULL)
  close(connection) 
  filePath
}



#
# this tests the file services underlying the wiki CRUD for entities
#
integrationTestWikiService <-
  function()
{
    project <- synapseClient:::.getCache("testProject")
    checkTrue(!is.null(project))
    
    # create a file attachment which will be used in the wiki page
    filePath<-createFile()
    fileName<-basename(filePath)
    fileHandle<-synapseClient:::chunkedUploadFile(filePath)
    
    # create a wiki page
    wikiContent<-list(title="wiki title", markdown="some — stuff, maybe from Zürich", attachmentFileHandleIds=list(fileHandle$id))
    # /{ownertObjectType}/{ownerObjectId}/wiki
    ownerUri<-sprintf("/entity/%s/wiki", propertyValue(project, "id"))
    wiki<-synapseClient:::synapsePost(ownerUri, wikiContent)
    
    # check that non-ascii characters are handled correctly
   	if (F) { # See Jira issue SYNR-886
    	checkEquals(wikiContent$markdown, wiki$markdown)
 	}
 	 
    # see if we can get the wiki from its ID
    wikiUri<-sprintf("%s/%s", ownerUri, wiki$id)
    wiki2<-synapseClient:::synapseGet(wikiUri)
    checkEquals(wiki, wiki2)
    
    # check that fileHandle is in the wiki
    checkEquals(fileHandle$id, wiki2$attachmentFileHandleIds[1])
    
    # get the file handles
    # /{ownerObjectType}/{ownerObjectId}/wiki/{wikiId}/attachmenthandles
    fileHandles<-synapseClient:::synapseGet(sprintf("%s/attachmenthandles", wikiUri))
    checkEquals(fileHandle, fileHandles$list[[1]])
    
    # download the raw file attachment
    # /{ownerObjectType}/{ownerObjectId}/wiki/{wikiId}/attachment?redirect=false&fileName={attachmentFileName}
    downloadUri<-sprintf("%s/attachment?redirect=false&fileName=%s", wikiUri, fileName)
    # download into a temp file
    downloadedFile<-synapseClient:::downloadFromService(downloadUri, destdir=synapseCacheDir())$downloadedFile
    origChecksum<- as.character(tools::md5sum(filePath))
    downloadedChecksum <- as.character(tools::md5sum(downloadedFile))
    checkEquals(origChecksum, downloadedChecksum)
    
    # Now delete the wiki page
    #/{ownertObjectType}/{ownerObjectId}/wiki/{wikiId}
    synapseClient:::synapseDelete(wikiUri)
    
    # delete the file handle
    handleUri<-sprintf("/fileHandle/%s", fileHandle$id)
    synapseClient:::synapseDelete(handleUri, endpoint=synapseFileServiceEndpoint())
}

# This repeats the basic CRUD of the previous test but using WikiPage, synStore, etc.
integrationTestWikiCRUD <-
  function()
{
  project <- synapseClient:::.getCache("testProject")
  checkTrue(!is.null(project))
  
  # create file attachments which will be used in the wiki page
  filePath1<-createFile()
  filePath2<-createFile()
  filePath3<-createFile()
  fileHandle<-synapseClient:::chunkedUploadFile(filePath3)
  
  wikiPage<-WikiPage(
    owner=project, 
    title="wiki title", 
    markdown="some — stuff, maybe from Zürich", 
    attachments=list(filePath1, filePath2), 
    fileHandles=list(fileHandle$id)
  )
  
	retrievedWikiPage<-checkWikiCRUD(project, wikiPage, 3)
	
	filePath4<-createFile()
	# the wiki page comes back with attachment IDs in the properties, but the 
	# 'attachments' fields is empty
	checkEquals(0, length(retrievedWikiPage@attachments))
	retrievedWikiPage@attachments<-list(filePath4)
	propertyValue(retrievedWikiPage, "markdown")<-"some new markdown"

	checkAndCleanUpWikiCRUD(project, retrievedWikiPage, 4)
}

integrationTestWikiCRUD_NoAttachments <- function() {
  project <- synapseClient:::.getCache("testProject")
  checkTrue(!is.null(project))
  
  # Create a file attachment which will be used in the wiki page
  filePath1<-createFile()
  fileHandle<-synapseClient:::chunkedUploadFile(filePath1)
  
  wikiPage<-WikiPage(
    owner=project, 
    title="wiki title", 
    markdown="some — stuff, maybe from Zürich", 
    fileHandles=list(fileHandle$id)
  )
  
  checkAndCleanUpWikiCRUD(project, wikiPage, 1)
}

integrationTestWikiCRUD_NoFileHandles <- function() {
  project <- synapseClient:::.getCache("testProject")
  checkTrue(!is.null(project))
  
  # Create a file attachment which will be used in the wiki page
  filePath1<-createFile()
  
  wikiPage<-WikiPage(
    owner=project, 
    title="wiki title", 
    markdown="some — stuff, maybe from Zürich", 
    attachments=list(filePath1)
  )
  
  checkAndCleanUpWikiCRUD(project, wikiPage, 1)
}

checkWikiCRUD <- function(project, wikiPage, expectedAttachmentLength) {
  markdown<-wikiPage$markdown
  wikiPage<-synStore(wikiPage)
  if (F) { # See Jira issue SYNR-886
  	# check that non-ascii characters are handled correctly
  	message(sprintf("test_wikiService.checkAndCleanUpWikiCRUD: markdown: <<%s>>, wikiPage$markdown: <<%s>>", markdown, wikiPage$markdown))
  	checkEquals(markdown, wikiPage$markdown)
  }
  
  # see if we can get the wiki from its parent
  wikiPage2<-synGetWiki(project)
  
  checkEquals(wikiPage, wikiPage2)
  
  # check that fileHandle is in the wiki
  fileHandleIds<-propertyValue(wikiPage2, "attachmentFileHandleIds")
  checkEquals(expectedAttachmentLength, length(fileHandleIds))
  
	wikiPage2
}

checkAndCleanUpWikiCRUD <- function(project, wikiPage, expectedAttachmentLength) {
	retrievedWikiPage<-checkWikiCRUD(project, wikiPage, expectedAttachmentLength)
	synDelete(retrievedWikiPage)
	checkException(synGetWiki(project, propertyValue(retrievedWikiPage, "id")))
}

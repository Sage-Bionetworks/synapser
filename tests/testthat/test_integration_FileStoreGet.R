#
# Integration tests for synGet, synStore and related functions
#

.setUp <- function() {
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
  # initialize this list
  synapseClient:::.setCache("foldersToDelete", list())
}

.tearDown <- function() {
  ## delete the test projects
  deleteEntity(synapseClient:::.getCache("testProject"))
  project <- synapseClient:::.getCache("testProject2")
  if (!is.null(project)) {
    deleteEntity(project)
    synapseClient:::.setCache("testProject2", NULL)
  }
  
  foldersToDelete<-synapseClient:::.getCache("foldersToDelete")
  for (folder in foldersToDelete) {
    if (file.exists(folder)) {
      unlink(folder, recursive=TRUE)
    }
  }
  synapseClient:::.setCache("foldersToDelete", list())
  
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

integrationTestMakeRestricted<-function() {
  # mock services to create restriction and check it
  myHasAccessRequirement<-function(entityId) {F}
  attr(myHasAccessRequirement, "origDef") <- synapseClient:::.hasAccessRequirement
  assignInNamespace(".hasAccessRequirement", myHasAccessRequirement, "synapseClient")

  synapseClient:::.mock(".createLockAccessRequirement", 
    function(entityId) {synapseClient:::.setCache("createLockAccessRequirementWasInvoked", TRUE)})
  synapseClient:::.setCache("createLockAccessRequirementWasInvoked", NULL)
  
  # now create a file and make sure it is restricted
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  
  # create a File
  filePath<- createFile()
  synapseStore<-TRUE
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  # store, indicating it is restricted
  storedFile<-synStore(file, isRestricted=TRUE)
  id<-propertyValue(storedFile, "id")
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  expect_true(synapseClient:::.getCache("createLockAccessRequirementWasInvoked"))
}

integrationTestUpdateProvenance <- function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  updateProvenanceIntern(project)
}

# this embodies the use case crafted by D. Burdick: https://github.com/Sage-Bionetworks/Synapse-Repository-Services/blob/develop/tools/provenance/Provenance_wiki_example.R
updateProvenanceIntern<-function(project) {
  projectId <- propertyValue(project, "id")
  
  # create some resources to use
  myAnnotationFilePath<-createFile() # replaces "/tmp/myAnnotationFile.txt"
  myAnnotationFile <- synStore(File(myAnnotationFilePath, name="myAnnotationFile.txt", parentId=projectId))
  myRawDataFilePath<-createFile() # replaces "/tmp/myRawDataFile.txt"
  myRawDataFile <- synStore(File(myRawDataFilePath, name="myRawDataFile.txt", parentId=projectId))
  myScriptFilePath <- createFile() # replaces "/tmp/myScript.txt"
  myScript <- synStore(File(myScriptFilePath, name="myScript.txt", parentId=projectId))
  
  ## Example 1
  # Here we explicitly define an "Activity" object, then we create the myOutputFile
  # entity and use the activity to describe how it was made.
  
  activity<-createEntity(Activity(list(name="Manual Curation")))
  myOutputFilePath<-createFile() # replaces "/tmp/myOutputFile.txt"
  myOutputFile <- synStore(File(myOutputFilePath, name="myOutputFile.txt", parentId=projectId), activity)
    
  ## Example 2
  # Create an activity implicitly by describing it in the synStore call for myOutputFile.
  # Here the combination of myAnnotationFile and myRawDataFile are used to generate myOutputFile.
  
  myOutputFile <- synStore(File(myOutputFilePath, name="myOutputFile.txt", parentId=projectId),
  used=list(myAnnotationFile, myRawDataFile),
    activityName="Manual Annotation of Raw Data",
    activityDescription="...")
  
  # the File should be a new version
  expect_equal(2, propertyValue(myOutputFile, "versionNumber"))
  
  # verify that the provenance can be retrieved
  retrievedFile<-synGet(propertyValue(myOutputFile, "id"), downloadFile=FALSE)
  gb<-generatedBy(retrievedFile)
  expect_equal("Manual Annotation of Raw Data", propertyValue(gb, "name"))
  expect_equal("...", propertyValue(gb, "description"))
  used<-propertyValue(gb, "used")
  expect_equal("org.sagebionetworks.repo.model.provenance.UsedEntity", used[[1]]$concreteType)
  expect_equal(FALSE, used[[1]]$wasExecuted)
  targetIds<-c(used[[1]]$reference$targetId, used[[2]]$reference$targetId)
  expect_true(any(propertyValue(myAnnotationFile, "id")==targetIds))
  expect_equal("org.sagebionetworks.repo.model.provenance.UsedEntity", used[[2]]$concreteType)
  expect_equal(FALSE, used[[2]]$wasExecuted)
  expect_true(any(propertyValue(myRawDataFile, "id")==targetIds))
  
  ## Example 3
  # Create a provenance record for myOutputFile that uses resources external to Synapse.
  # Here we are describing the execution of Script.py (stored in GitHub)
  # where myAnnotationFile and a raw data file from GEO are used as inputs
  # to generate myOutputFile with the "used" list
  
  myOutputFile <- synStore(File(myOutputFilePath, name="myOutputFile.txt", parentId=projectId), 
    used=list(list(name="Script.py", url="https://raw.github.com/.../Script.py", wasExecuted=T),
      list(entity=myAnnotationFile, wasExecuted=F),
      list(name="GSM349870.CEL", url="http://www.ncbi.nlm.nih.gov/geo/download/...", wasExecuted=F)),
    activityName="Scripted Annotation of Raw Data",
    activityDescription="To execute run: python Script.py [Annotation] [CEL]")
  
  # the File should be a new version
  expect_equal(3, propertyValue(myOutputFile, "versionNumber"))

  # verify that the provenance can be retrieved
  retrievedFile<-synGet(propertyValue(myOutputFile, "id"), downloadFile=FALSE)
  gb<-generatedBy(retrievedFile)
  expect_equal("Scripted Annotation of Raw Data", propertyValue(gb, "name"))
  expect_equal("To execute run: python Script.py [Annotation] [CEL]", propertyValue(gb, "description"))
  used<-propertyValue(gb, "used")
  expect_equal(3, length(used))
  
  
  ## Example 4
  # Create an activity describing the execution of myScript with myRawDataFile as the input
  
  activity<-createEntity(Activity(list(name="Process data and plot",
        used=list(list(entity=myScript, wasExecuted=T),
          list(entity=myRawDataFile, wasExecuted=F)))))
  
  # Record that the script's execution generated two output files, and upload those files
  
  myOutputFile <- synStore(File(myOutputFilePath, name="myOutputFile.txt", parentId=projectId), activity)
  
  # the File should be a new version
  expect_equal(4, propertyValue(myOutputFile, "versionNumber"))
  # ... and should have the activity as its 'generatedBy'
  expect_equal(propertyValue(activity, "id"), propertyValue(generatedBy(myOutputFile), "id"))
  
  # create another output created by the same activity
  myPlotFilePath <-createFile() # replaces "/tmp/myPlot.png"
  myPlot <- synStore(File(myPlotFilePath, name="myPlot.png", parentId=projectId), activity)
  
  # verify that the provenance can be retrieved
  retrievedFile<-synGet(propertyValue(myOutputFile, "id"), downloadFile=FALSE)
  gb<-generatedBy(retrievedFile)
  expect_equal("Process data and plot", propertyValue(gb, "name"))
  used<-propertyValue(gb, "used")
  expect_equal(2, length(used))
}

# Per SYNR-501, if you update an entity the new version
# should not carry forward the provenance record of the old one
integrationTestReviseWithoutProvenance <- function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  projectId <- propertyValue(project, "id")
  
  myOutputFilePath<-createFile()
  
  myOutputFile <- synStore(File(myOutputFilePath, name="myOutputFile.txt", parentId=projectId), 
    used=list(list(name="Script.py", url="https://raw.github.com/.../Script.py", wasExecuted=T),
      list(name="GSM349870.CEL", url="http://www.ncbi.nlm.nih.gov/geo/download/...", wasExecuted=F)),
    activityName="Scripted Annotation of Raw Data",
    activityDescription="To execute run: python Script.py [Annotation] [CEL]")
  
  # its the first new version
  expect_equal(1, propertyValue(myOutputFile, "versionNumber"))
  
  # verify that the provenance can be retrieved
  retrievedFile<-synGet(propertyValue(myOutputFile, "id"))
  gb<-generatedBy(retrievedFile)
  expect_equal("Scripted Annotation of Raw Data", propertyValue(gb, "name"))
  expect_equal("To execute run: python Script.py [Annotation] [CEL]", propertyValue(gb, "description"))
  used<-propertyValue(gb, "used")
  expect_equal(2, length(used))
  
  # now modify the file
  createFile(content="some other content", getFileLocation(retrievedFile))
  
  retrievedFile<-synStore(retrievedFile)
  
  # it's the second new version
  expect_equal(2, propertyValue(retrievedFile, "versionNumber"))
  
  # since we specified no provenance in synStore, there should be none
  expect_true(is.null(generatedBy(retrievedFile)))
  
  # now modify again
  createFile(content="yet some other, other content", getFileLocation(retrievedFile))
  retrievedFile<-synStore(retrievedFile, used="syn101")
  
  # its the third new version
  expect_equal(3, propertyValue(retrievedFile, "versionNumber"))
  
  # the specified provenance is there!
  gb<-generatedBy(retrievedFile)
  used<-propertyValue(gb, "used")
  expect_equal(1, length(used))
  
}

integrationTestCacheMapRoundTrip <- function() {
  fileHandleId<-"101"
  filePath<- createFile()
  filePath2<- createFile()
  
  unlink(synapseClient:::defaultDownloadLocation(fileHandleId), recursive=TRUE)
  synapseClient:::addToCacheMap(fileHandleId, filePath)
  synapseClient:::addToCacheMap(fileHandleId, filePath2)
  content<-synapseClient:::getCacheMapFileContent(fileHandleId)
  expect_equal(2, length(content))
  expect_true(any(normalizePath(filePath, winslash="/")==names(content)))
  expect_true(any(normalizePath(filePath2, winslash="/")==names(content)))
  expect_equal(synapseClient:::.formatAsISO8601(file.info(filePath)$mtime), synapseClient:::getFromCacheMap(fileHandleId, filePath))
  expect_equal(synapseClient:::.formatAsISO8601(file.info(filePath2)$mtime), synapseClient:::getFromCacheMap(fileHandleId, filePath2))
  expect_true(synapseClient:::localFileUnchanged(fileHandleId, filePath))
  expect_true(synapseClient:::localFileUnchanged(fileHandleId, filePath2))
  
  # now clean up
  scheduleCacheFolderForDeletion(fileHandleId)
}

scheduleFolderForDeletion<-function(folder) {
  folderList<-synapseClient:::.getCache("foldersToDelete")
  folderList[[length(folderList)+1]]<-folder
  synapseClient:::.setCache("foldersToDelete", folderList)
}

scheduleCacheFolderForDeletion<-function(fileHandleId) {
  if (is.null(fileHandleId)) stop("In scheduleCacheFolderForDeletion fileHandleId must not be null")
  scheduleFolderForDeletion(synapseClient:::defaultDownloadLocation(fileHandleId))
}

integrationTestMetadataRoundTrip_URL <- function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  
  # create a file to be uploaded
  synapseStore<-FALSE
  filePath<-"http://versions.synapse.sagebase.org/synapseRClient"
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  
  # now store it
  storedFile<-synStore(file)
  metadataRoundTrip(storedFile, synapseStore, expectedFileLocation=filePath)
}

integrationTestMetadataRoundTrip_S3File <- function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  
  # create a file to be uploaded
  filePath<- createFile()
  synapseStore<-TRUE
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  expect_true(!is.null(propertyValue(file, "name")))
  expect_equal(propertyValue(project, "id"), propertyValue(file, "parentId"))
  
  # now store it
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  metadataRoundTrip(storedFile, synapseStore)
}

metadataRoundTrip <- function(storedFile, synapseStore, expectedFileLocation=character(0)) {  
  metadataOnly<-synGet(propertyValue(storedFile, "id"),downloadFile=F)
  metadataOnly@synapseStore<-synapseStore
  
  # Change some metadata
  metadataOnly<-synapseClient:::synAnnotSetMethod(metadataOnly, "annot", "value")
  
  # Also change the project the entity belongs to (SYNR-625(
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject2", project)
  propertyValue(metadataOnly, "parentId") <- propertyValue(project, "id")
  
  # Update the metadata
  storedMetadata<-synStore(metadataOnly, forceVersion=F)
  expect_equal("value", synapseClient:::synAnnotGetMethod(storedMetadata, "annot"))
  expect_equal(propertyValue(project, "id"), propertyValue(storedMetadata, "parentId"))
  expect_equal(1, propertyValue(storedMetadata, "versionNumber"))
  
  # now store again, but force a version update
  storedMetadata<-synStore(storedMetadata) # default is forceVersion=T
  
  retrievedMetadata<-synGet(propertyValue(storedFile, "id"),downloadFile=F)
  expect_equal(2, propertyValue(retrievedMetadata, "versionNumber"))
  expect_equal(expectedFileLocation, getFileLocation(retrievedMetadata))
  
  # of course we should still be able to get the original version
  originalVersion<-synGet(propertyValue(storedFile, "id"), version=1, downloadFile=F)
  expect_equal(1, propertyValue(originalVersion, "versionNumber"))
  # ...whether or not we download the file
  originalVersion<-synGet(propertyValue(storedFile, "id"), version=1, downloadFile=T)
  expect_equal(1, propertyValue(originalVersion, "versionNumber"))
  # file location is NOT missing
  expect_true(length(getFileLocation(originalVersion))>0)
}

integrationTestGovernanceRestriction <- function() {
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  
  # create a File
  filePath<- createFile()
  synapseStore<-TRUE
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  storedFile<-synStore(file)
  id<-propertyValue(storedFile, "id")
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  # mock Governance restriction
  # return TRUE, i.e. yes, there are unfulfilled access requirements
  synapseClient:::.mock("hasUnfulfilledAccessRequirements", function(id) {TRUE})
  
  # try synGet with downloadFile=F, load=F, should be OK
  synGet(id, downloadFile=F, load=F)
  
  # try synGet with downloadFile=T, should NOT be OK
  result<-try(synGet(id, downloadFile=T, load=F), silent=TRUE)
  expect_equal("try-error", class(result))
  
  # try synGet with load=T, should NOT be OK
  result<-try(synGet(id, downloadFile=F, load=T), silent=TRUE)
  expect_equal("try-error", class(result))

}

# utility to change the timestamp on a file
touchFile<-function(location) {
  orginalTimestamp<-synapseClient:::lastModifiedTimestamp(location)
  Sys.sleep(1.0) # make sure new timestamp will be different from original
  connection<-file(location)
  # result<-paste(readLines(connection), collapse="\n")
  originalSize<-file.info(location)$size
  originalMD5<-tools::md5sum(location)
  result<-readChar(connection, originalSize)
  close(connection)
  connection<-file(location)
  # writeLines(result, connection)
  writeChar(result, connection, eos=NULL)
  close(connection)  
  # check that we indeed modified the time stamp on the file
  newTimestamp<-synapseClient:::lastModifiedTimestamp(location)
  expect_true(newTimestamp!=orginalTimestamp)
  # check that the file has not been changed
  expect_equal(originalMD5, tools::md5sum(location))
}

checkFilesEqual<-function(file1, file2) {
  expect_equal(normalizePath(file1, winslash="/"), normalizePath(file2, winslash="/"))
}

integrationTestCreateOrUpdate<-function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  createOrUpdateIntern(project)
  
}

createOrUpdateIntern<-function(project) {
  filePath<- createFile()
  name<-"createOrUpdateTest"
  pid<-propertyValue(project, "id")
  file<-File(filePath, name=name, parentId=pid)
  file<-synStore(file)
  
  filePath2<- createFile()
  file2<-File(filePath2, name=name, parentId=pid)
  # since createOrUpdate=T is the default, this should update 'file' rather than create a new one
  file2<-synStore(file2)
  expect_equal(propertyValue(file, "id"), propertyValue(file2, "id"))
  expect_equal(2, propertyValue(file2, "versionNumber")) # this is the test for SYNR-429
  
  # SYNR-450: using the same file twice, if forceVersion=F should result in no version change!
  file25<-File(filePath2, name=name, parentId=pid)
  file25<-synStore(file25, forceVersion=FALSE)
  expect_equal(propertyValue(file, "id"), propertyValue(file25, "id"))
  expect_equal(2, propertyValue(file25, "versionNumber"))
  expect_equal(propertyValue(file2, "dataFileHandleId"), propertyValue(file25, "dataFileHandleId"))
  
  filePath3 <- createFile()
  file3<-File(filePath3, name=name, parentId=pid)
  result<-try(synStore(file3, createOrUpdate=F), silent=T)
  expect_equal("try-error", class(result))
  
  # check an entity with no parent
  project2<-Project(name=propertyValue(project, "name"))
  project2<-synStore(project2)
  expect_equal(propertyValue(project2, "id"), pid)
  
  project3<-Project(name=propertyValue(project, "name"))
  result<-try(synStore(project3, createOrUpdate=F), silent=T)
  expect_equal("try-error", class(result))
}

integrationTestCreateOrUpdate_MergeAnnotations <- function() {
    # Test for SYNR-586
    project <- synapseClient:::.getCache("testProject")
    expect_true(!is.null(project))
    pid<-propertyValue(project, "id")
    
    # Add some annotations to the project
    annotValue(project, "a") <- "1"
    annotValue(project, "b") <- "2"
    project <- synStore(project)
    
    # Create another project with the same name and slighly different annotations
    project2 <- Project(name=propertyValue(project, "name"))
    annotValue(project2, "b") <- "3"
    annotValue(project2, "c") <- "4"
    project2 <- synStore(project2)
    
    # Check for the expected ID and annotations
    expect_equal(propertyValue(project2, "id"), pid)
    expect_equal(annotValue(project2, "a"), "1")
    expect_equal(annotValue(project2, "b"), "3")
    expect_equal(annotValue(project2, "c"), "4")
}

integrationTestContentType <- function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  # create a file to be uploaded
  filePath<- createFile(content="Some content")
  file<-File(filePath, parentId=propertyValue(project, "id"))
  # now store it
  myContentType<-"text/plain"
  storedFile<-synStore(file, contentType=myContentType)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  expect_equal(myContentType, synapseClient:::getFileHandle(storedFile)$contentType)
}

#
# This code exercises the file services underlying upload/download to/from an entity
#
integrationTestRoundtrip <- function()
{
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  roundTripIntern(project)
}

roundTripIntern<-function(project) {  
  # create a file to be uploaded
  filePath<- createFile(content="Some content")
  md5_version_1<- as.character(tools::md5sum(filePath))
  synapseStore<-TRUE
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  expect_true(!is.null(propertyValue(file, "name")))
  expect_equal(propertyValue(project, "id"), propertyValue(file, "parentId"))
  
  # now store it
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  # check that it worked
  expect_true(!is.null(storedFile))
  id<-propertyValue(storedFile, "id")
  expect_true(!is.null(id))
  expect_equal(propertyValue(project, "id"), propertyValue(storedFile, "parentId"))
  expect_equal(propertyValue(file, "name"), propertyValue(storedFile, "name"))
  expect_equal(filePath, getFileLocation(storedFile))
  expect_equal(synapseStore, storedFile@synapseStore)
  
  # check that cachemap entry exists
  fileHandleId<-storedFile@fileHandle$id
  cachePath<-sprintf("%s/.cacheMap", synapseClient:::defaultDownloadLocation(fileHandleId))
  expect_true(file.exists(cachePath))
  modifiedTimeStamp<-synapseClient:::getFromCacheMap(fileHandleId, filePath)
  expect_true(!is.null(modifiedTimeStamp))
  
  # now download it.
  downloadedFile<-synGet(id)
  downloadedFilePath<-getFileLocation(downloadedFile)
  expect_equal(id, propertyValue(downloadedFile, "id"))
  expect_equal(propertyValue(project, "id"), propertyValue(downloadedFile, "parentId"))
  expect_equal(synapseStore, downloadedFile@synapseStore)
  expect_true(length(getFileLocation(downloadedFile))>0)
  # The retrieved object is bound to the existing copy of the file.
  expect_equal(downloadedFilePath, normalizePath(filePath, winslash="/"))
  
  # Now repeat, after removing the cachemap record
  # This will download the file into the default cache location
  unlink(cachePath)
  downloadedFile<-synGet(id)
  downloadedFilePathInCache<-getFileLocation(downloadedFile)
  # verify that the new copy is in the cache
  expect_equal(substr(downloadedFilePathInCache,1,nchar(synapseCacheDir())), synapseCacheDir())
    
  # compare MD-5 checksum of filePath and downloadedFile@filePath
  md5_version_1_retrieved <- as.character(tools::md5sum(getFileLocation(downloadedFile)))
  expect_equal(md5_version_1, md5_version_1_retrieved)
  
  expect_equal(storedFile@fileHandle, downloadedFile@fileHandle)
  
  # test synStore of retrieved entity, no change to file
  modifiedTimeStamp<-synapseClient:::getFromCacheMap(fileHandleId, downloadedFilePathInCache)
  expect_true(!is.null(modifiedTimeStamp))
  Sys.sleep(1.0)
  updatedFile <-synStore(downloadedFile, forceVersion=F)
  # the file handle should be the same
  expect_equal(fileHandleId, propertyValue(updatedFile, "dataFileHandleId"))
  # there should be no change in the time stamp.
  expect_equal(modifiedTimeStamp, synapseClient:::getFromCacheMap(fileHandleId, downloadedFilePathInCache))
  # we are still on version 1
  expect_equal(1, propertyValue(updatedFile, "versionNumber"))

  #  test synStore of retrieved entity, after changing file
  # modify the file, byt making a new one then copying it over
  createFile(content="Some other content", filePath=downloadedFilePathInCache)
  md5_version_2<- as.character(tools::md5sum(downloadedFilePathInCache))
  expect_true(md5_version_1!=md5_version_2)
  
  updatedFile2 <-synStore(updatedFile, forceVersion=F)
  scheduleCacheFolderForDeletion(updatedFile2@fileHandle$id)
  # fileHandleId is changed
  expect_true(fileHandleId!=propertyValue(updatedFile2, "dataFileHandleId"))
  # we are now on version 2
  expect_equal(2, propertyValue(updatedFile2, "versionNumber"))
  
  # of course we should still be able to get the original version
  originalVersion<-synGet(propertyValue(storedFile, "id"), version=1, downloadFile=F)
  expect_equal(1, propertyValue(originalVersion, "versionNumber"))
  # ...whether or not we download the file
  originalVersion<-synGet(propertyValue(storedFile, "id"), version=1, downloadFile=T)
  expect_equal(1, propertyValue(originalVersion, "versionNumber"))
  md5_version_1_retrieved_again <- as.character(tools::md5sum(getFileLocation(originalVersion)))
  # make sure the right version was retrieved (SYNR-447)
  expect_equal(md5_version_1, md5_version_1_retrieved_again)
  
  # get the current version of the file, but download it to a specified location
  # (make the location unique)
  specifiedLocation<-file.path(tempdir(), "subdir")
  if (file.exists(specifiedLocation)) unlink(specifiedLocation, recursive=T) # in case it already exists
  expect_true(dir.create(specifiedLocation))
  scheduleFolderForDeletion(specifiedLocation)
  downloadedToSpecified<-synGet(id, downloadLocation=specifiedLocation)
  checkFilesEqual(specifiedLocation, dirname(getFileLocation(downloadedToSpecified)))
  fp<-getFileLocation(downloadedToSpecified)
  expect_equal(fp, file.path(specifiedLocation, basename(filePath)))
  expect_true(file.exists(fp))
  expect_equal(md5_version_2, as.character(tools::md5sum(fp)))
  touchFile(fp)

  timestamp<-synapseClient:::lastModifiedTimestamp(fp)
  
  # download again with the 'keep.local' choice
  downloadedToSpecified<-synGet(id, downloadLocation=specifiedLocation, ifcollision="keep.local")
  # file path is the same, timestamp should not change
  Sys.sleep(1.0)
  expect_equal(normalizePath(getFileLocation(downloadedToSpecified)), normalizePath(fp))
  expect_equal(timestamp, synapseClient:::lastModifiedTimestamp(fp))
  
  # download again with the 'overwrite' choice
  downloadedToSpecified<-synGet(id, downloadLocation=specifiedLocation, ifcollision="overwrite.local")
  expect_equal(normalizePath(getFileLocation(downloadedToSpecified)), normalizePath(fp))
  # timestamp SHOULD change
  expect_true(timestamp!=synapseClient:::lastModifiedTimestamp(fp)) 

  touchFile(fp)
  Sys.sleep(1.0)
  # download with the 'keep both' choice (the default)
  downloadedToSpecified<-synGet(id, downloadLocation=specifiedLocation)
  # there should be a second file
  expect_true(normalizePath(getFileLocation(downloadedToSpecified))!=normalizePath(fp))
  # it IS in the specified directory
  checkFilesEqual(normalizePath(specifiedLocation), normalizePath(dirname(getFileLocation(downloadedToSpecified))))
  
  # delete the cached file
  deleteEntity(downloadedFile)
}


# test that legacy *Entity based methods work on File objects
integrationTestAddToNewFILEEntity <-
  function()
{
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  pid <- propertyValue(project, "id")
  expect_true(!is.null(pid))
  filePath<- createFile()
  file<-synapseClient:::createFileFromProperties(list(parentId=pid))
  file<-addFile(file, filePath)
  storedFile<-storeEntity(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  expect_true(!is.null(storedFile))
  id<-propertyValue(storedFile, "id")
  expect_true(!is.null(id))
  expect_equal(pid, propertyValue(storedFile, "parentId"))
  expect_equal(propertyValue(file, "name"), propertyValue(storedFile, "name"))
  expect_equal(filePath, getFileLocation(storedFile))
  expect_equal(TRUE, storedFile@synapseStore) # this is the default
  expect_true(!is.null(propertyValue(storedFile, "dataFileHandleId")))
  
  gotEntity<-getEntity(storedFile) # get metadata, don't download file
  
  expect_true(!is.null(gotEntity))
  id<-propertyValue(gotEntity, "id")
  expect_true(!is.null(id))
  expect_equal(pid, propertyValue(gotEntity, "parentId"))
  expect_equal(propertyValue(file, "name"), propertyValue(gotEntity, "name"))
  expect_true(!is.null(propertyValue(gotEntity, "dataFileHandleId")))
  expect_true(length(getFileLocation(gotEntity))==0) # empty since it hasn't been downloaded
  
  # test update of metadata
  annotValue(gotEntity, "foo")<-"bar"
  updatedEntity<-updateEntity(gotEntity)
  gotEntity<-getEntity(updatedEntity)
  expect_equal("bar", annotValue(gotEntity, "foo"))
  
  downloadedFile<-downloadEntity(id)
  expect_equal(id, propertyValue(downloadedFile, "id"))
  expect_equal(pid, propertyValue(downloadedFile, "parentId"))
  expect_equal(TRUE, downloadedFile@synapseStore) # this is the default
  expect_true(!is.null(getFileLocation(downloadedFile)))
  
  # compare MD-5 checksum of filePath and downloadedFile@filePath
  origChecksum<- as.character(tools::md5sum(filePath))
  downloadedChecksum <- as.character(tools::md5sum(getFileLocation(downloadedFile)))
  expect_equal(origChecksum, downloadedChecksum)
  
  expect_equal(storedFile@fileHandle, downloadedFile@fileHandle)
  
  # check that downloading a second time doesn't retrieve again
  timeStamp<-synapseClient:::lastModifiedTimestamp(getFileLocation(downloadedFile))
  Sys.sleep(1.0)
  downloadedFile<-downloadEntity(id)
  expect_equal(timeStamp, synapseClient:::lastModifiedTimestamp(getFileLocation(downloadedFile)))
 
  # delete the file
  deleteEntity(downloadedFile)
}

# test that legacy *Entity based methods work on File objects, cont.
integrationTestReplaceFile<-function() {
    project <- synapseClient:::.getCache("testProject")
    filePath<- createFile()
    file<-synapseClient:::createFileFromProperties(list(parentId=propertyValue(project, "id")))
    file<-addFile(file, filePath)
    # replace storeEntity with createEntity
    storedFile<-createEntity(file)
    scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
    
    # now getEntity, add a different file, store, retrieve
    gotEntity<-getEntity(storedFile) # get metadata, don't download file
    newFile<-system.file("DESCRIPTION", package = "synapseClient")
    gotEntity<-addFile(gotEntity, newFile)
    newStoredFile<-storeEntity(gotEntity)
    scheduleCacheFolderForDeletion(newStoredFile@fileHandle$id)
    
    downloadedFile<-downloadEntity(newStoredFile)
 
    # compare MD-5 checksum of filePath and downloadedFile@filePath
    origChecksum<- as.character(tools::md5sum(newFile))
    downloadedChecksum <- as.character(tools::md5sum(getFileLocation(downloadedFile)))
    expect_equal(origChecksum, downloadedChecksum)
    
    expect_equal(newStoredFile@fileHandle, downloadedFile@fileHandle)
    
    # delete the file
    deleteEntity(downloadedFile)
  }



integrationTestLoadEntity<-function() {
  project <- synapseClient:::.getCache("testProject")
  filePath<- createFile()
  file<-synapseClient:::createFileFromProperties(list(parentId=propertyValue(project, "id")))
  dataObject<-list(a="A", b="B", c="C")
  file<-addObject(file, dataObject, "dataObjectName")
  storedFile<-createEntity(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  
  loadedEntity<-loadEntity(propertyValue(storedFile, "id"))
  
  expect_equal(dataObject, getObject(loadedEntity, "dataObjectName"))
  
  # can load from an entity as well as from an ID
  loadedEntity2<-loadEntity(storedFile)
  expect_equal(dataObject, getObject(loadedEntity2, "dataObjectName"))
  
  expect_equal("dataObjectName", listObjects(loadedEntity2))
  
  # check getObject(owner) function
  expect_equal(getObject(loadedEntity2), getObject(loadedEntity2, "dataObjectName"))
  
  
  # delete the file
  deleteEntity(loadedEntity)
}

integrationTestSerialization<-function() {
  project <- synapseClient:::.getCache("testProject")
  myData<-list(foo="bar", foo2="bas")
  file<-File(parentId=propertyValue(project, "id"))
  result<-try(synStore(file), silent=TRUE) # try storing before adding anything. Should be an error
  expect_equal("try-error", class(result))
  file<-addObject(file, myData)
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  expect_true(!is.null(getFileLocation(storedFile)))
  id<-propertyValue(storedFile, "id")
  expect_true(!is.null(id))
  retrievedFile<-synGet(id, load=T)
  expect_true(synapseClient:::hasObjects(retrievedFile))
  retrievedObject<-getObject(retrievedFile, "myData")
  expect_equal(myData, retrievedObject)
  
  # check that I can add more data and save again
  newData<-diag(10)
  retrievedFile<-addObject(retrievedFile, newData)
  retrievedFile<-synStore(file)
}

integrationTestLoadZipped<-function() {
  project <- synapseClient:::.getCache("testProject")
  myData<-list(foo="bar", foo2="bas")
  objects<-new.env(parent=emptyenv())
  assign(x="myData", value=myData, envir=objects)
  filePath<-tempfile()
  save(list=ls(objects), file=filePath, envir=objects)
  zipped<-tempfile()
  zip(zipped, filePath)
  zippedName<-sprintf( "%s.zip", zipped)
  expect_true(file.exists(zippedName))
  file<-File(zippedName, parentId=propertyValue(project, "id"))
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  expect_true(!is.null(getFileLocation(storedFile)))
  id<-propertyValue(storedFile, "id")
  expect_true(!is.null(id))
  retrievedFile<-synGet(id, load=T)
  expect_true(synapseClient:::hasObjects(retrievedFile))
  retrievedObject<-getObject(retrievedFile, "myData")
  expect_equal(myData, retrievedObject)
}

integrationTestSerializeToEmptyFile<-function() {
  # Skip the existence check within the File constructor
  synapseClient:::.mock("mockable.file.exists", function(...) {TRUE})
  
  # Random, non-existent file
  filePath<-sprintf("%s/integrationTestSerializeToEmptyFile_%d", tempdir(), sample(1000,1))
  
  project <- synapseClient:::.getCache("testProject")
  myData<-list(foo="bar", foo2="bas")
  file<-File(path=filePath, parentId=propertyValue(project, "id"))
  file<-addObject(file, myData)
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  # check that data was written into file
  expect_true(file.exists(filePath))
  expect_true(file.info(filePath)$size>0)
}

integrationTestOverwriteProtection<-function() {
  # Random, non-existent file
  filePath<-sprintf("%s/integrationTestOverwriteProtection_%d", tempdir(), sample(1000,1))
  
  connection<-file(filePath)
  writeLines("some text data, not serialized R object", connection)
  close(connection)
  
  project <- synapseClient:::.getCache("testProject")
  myData<-list(foo="bar", foo2="bas")
  file<-File(path=filePath, parentId=propertyValue(project, "id"))
  file<-addObject(file, myData)
  # if you try to store in-memory data to Synapse, and the intermediate file containing non-binary data, then stop, to prevent overwriting
  expect_equal("try-error", class(try(synStore(file), silent=TRUE)))
}

integrationTestNonFile<-function() {
  project <- synapseClient:::.getCache("testProject")
  folder<-Folder(name="test folder", parentId=propertyValue(project, "id"))
  folder<-synapseClient:::synAnnotSetMethod(folder, "annot", "value")
  storedFolder<-synStore(folder)
  id<-propertyValue(storedFolder, "id")
  expect_true(!is.null(id))
  
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  expect_equal("value", synapseClient:::synAnnotGetMethod(retrievedFolder, "annot"))
 
  # now test updating
  retrievedFolder<-synapseClient:::synAnnotSetMethod(retrievedFolder, "annot", "value2")
  retrievedFolder<-synStore(retrievedFolder)
  
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  # verify that updated value was persisted
  expect_equal("value2", synapseClient:::synAnnotGetMethod(retrievedFolder, "annot"))
  
  
  # test createORUpdate=T
  folder<-Folder(name="test folder", parentId=propertyValue(project, "id"))
  folder<-synapseClient:::synAnnotSetMethod(folder, "annot", "value3")
  storedFolder<-synStore(folder)
  # check that the id is the same as before (i.e. the previous folder was updated)
  expect_equal(id, propertyValue(storedFolder, "id"))
  
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  expect_equal("value3", synapseClient:::synAnnotGetMethod(retrievedFolder, "annot"))
  
  # test createORUpdate=FALSE
  folder<-Folder(name="test folder", parentId=propertyValue(project, "id"))
   expect_error(synStore(folder, createOrUpdate=FALSE), silent=TRUE)
  
}

# this tests synStore in which the activity name, description, used, and executed param's are passed in
integrationTestProvenance<-function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  executed<-Folder(name="executed", parentId=pid)
  executed<-synStore(executed)
  
  folder<-Folder(name="test folder", parentId=pid)
  # this tests (1) linking a URL, (2) passing a list, (3) passing a single entity, (4) passing an entity ID
  storedFolder<-synStore(folder, used=list("http://foo.bar.com", project), executed=propertyValue(executed, "id"), 
    activityName="activity name", activityDescription="activity description")
  id<-propertyValue(storedFolder, "id")
  expect_true(!is.null(id))
  
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  activity<-generatedBy(retrievedFolder)
  expect_equal("activity name", propertyValue(activity, "name"))
  expect_equal("activity description", propertyValue(activity, "description"))
  
  # now check the 'used' list
  used<-propertyValue(activity, "used")
  expect_equal(3, length(used))
  foundURL<-F
  foundProject<-F
  foundExecuted<-F
  for (u in used) {
    if (u$concreteType=="org.sagebionetworks.repo.model.provenance.UsedURL") {
      expect_equal(FALSE, u$wasExecuted)
      expect_equal("http://foo.bar.com", u$url)
      expect_equal("http://foo.bar.com", u$name)
      foundURL<-T
    } else {
      expect_equal(u$concreteType, "org.sagebionetworks.repo.model.provenance.UsedEntity")
      if (u$wasExecuted) {
        expect_equal(u$reference$targetId, propertyValue(executed, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundExecuted<- T
      } else {
        expect_equal(u$reference$targetId, propertyValue(project, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundProject<- T
      }
    }
  }
  expect_true(foundURL)
  expect_true(foundProject)
  expect_true(foundExecuted)
  
  # while we're here, test synGetActivity
  activity2<-synGetActivity(retrievedFolder)
  expect_equal(activity$id, activity2$id)
  activity3<-synGetActivity(propertyValue(retrievedFolder, "id"))
  expect_equal(activity$id, activity3$id)
  }

# this tests synStore in which used and executed param's are passed, not as lists
integrationTestProvenanceNonList<-function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  executed<-Folder(name="executed", parentId=pid)
  executed<-synStore(executed)
  
  folder<-Folder(name="test folder", parentId=pid)
  # this tests (1) linking a URL, (2) passing a list, (3) passing a single entity, (4) passing an entity ID
  storedFolder<-synStore(folder, used=project, executed=executed, 
    activityName="activity name", activityDescription="activity description")
  id<-propertyValue(storedFolder, "id")
  expect_true(!is.null(id))
  
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  activity<-generatedBy(retrievedFolder)
  expect_equal("activity name", propertyValue(activity, "name"))
  expect_equal("activity description", propertyValue(activity, "description"))
  
  # now check the 'used' list
  used<-propertyValue(activity, "used")
  expect_equal(2, length(used))
  foundProject<-F
  foundExecuted<-F
  for (u in used) {
    if (u$concreteType=="org.sagebionetworks.repo.model.provenance.UsedEntity") {
      if (u$wasExecuted) {
        expect_equal(u$reference$targetId, propertyValue(executed, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundExecuted<- T
      } else {
        expect_equal(u$reference$targetId, propertyValue(project, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundProject<- T
      }
    }
  }
  expect_true(foundProject)
  expect_true(foundExecuted)
}

# this tests synStore where an Activity is constructed separately, then passed in
integrationTestProvenance2<-function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  executed<-Folder(name="executed", parentId=pid)
  executed<-synStore(executed)
  
  folder<-Folder(name="test folder", parentId=pid)
  # this tests (1) linking a URL, (2) passing a list, (3) passing a single entity, (4) passing an entity ID
  activity<-Activity(
    list(name="activity name", description="activity description",
            used=list(
              list(url="http://foo.bar.com", wasExecuted=F),
              list(entity=pid, wasExecuted=F),
              list(entity=propertyValue(executed, "id"), wasExecuted=T)
          )
      )
  )
  activity<-storeEntity(activity)
  
  storedFolder<-synStore(folder, activity=activity)
  id<-propertyValue(storedFolder, "id")
  expect_true(!is.null(id))
  
  # make sure that using an Activity elsewhere doesn't cause a problem
  anotherFolder<-Folder(name="another folder", parentId=pid)
  anotherFolder<-synStore(anotherFolder, activity=activity)
  
  expect_equal(propertyValue(generatedBy(storedFolder), "id"), propertyValue(generatedBy(anotherFolder), "id"))
  
  # now retrieve the first folder and check the provenance
  retrievedFolder<-synGet(id)
  expect_equal(propertyValue(project, "id"), propertyValue(retrievedFolder, "parentId"))
  activity<-generatedBy(retrievedFolder)
  expect_equal("activity name", propertyValue(activity, "name"))
  expect_equal("activity description", propertyValue(activity, "description"))
  
  # now check the 'used' list
  used<-propertyValue(activity, "used")
  expect_equal(3, length(used))
  foundURL<-F
  foundProject<-F
  foundExecuted<-F
  for (u in used) {
    if (u$concreteType=="org.sagebionetworks.repo.model.provenance.UsedURL") {
      expect_equal(FALSE, u$wasExecuted)
      expect_equal("http://foo.bar.com", u$url)
      expect_equal("http://foo.bar.com", u$name)
      foundURL<-T
    } else {
      expect_equal(u$concreteType, "org.sagebionetworks.repo.model.provenance.UsedEntity")
      if (u$wasExecuted) {
        expect_equal(u$reference$targetId, propertyValue(executed, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundExecuted<- T
      } else {
        expect_equal(u$reference$targetId, propertyValue(project, "id"))
        expect_equal(u$reference$targetVersionNumber, 1)
        foundProject<- T
      }
    }
  }
  expect_true(foundURL)
  expect_true(foundProject)
  expect_true(foundExecuted)
}

# cannot store a missing external link
integrationTestExternalLinkNoFile<-function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  
  # create a file to be uploaded
  file<-File(synapseStore=FALSE, parentId=propertyValue(project, "id"))
  
  expect_equal("try-error", class(try(synStore(file), silent=TRUE)))
}

integrationTestExternalLink<-function() {
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  
  # create a file to be uploaded
  synapseStore<-FALSE
  filePath<-"http://versions.synapse.sagebase.org/synapseRClient"
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
  
  # check that cachemap entry does NOT exist
  fileHandleId<-storedFile@fileHandle$id
  cachePath<-sprintf("%s/.cacheMap", synapseClient:::defaultDownloadLocation(fileHandleId))
  expect_true(!file.exists(cachePath))
  
  # retrieve the metadata (no download)
  metadataOnly<-synGet(id, downloadFile=FALSE)
  # we get external URL when retrieving only metadata
  expect_equal(filePath, getFileLocation(metadataOnly))
  
  # now download it.  This will pull a copy into the cache
  downloadedFile<-synGet(id)
  scheduleCacheFolderForDeletion(downloadedFile@fileHandle$id)
  
  expect_equal(id, propertyValue(downloadedFile, "id"))
  expect_equal(propertyValue(project, "id"), propertyValue(downloadedFile, "parentId"))
  expect_equal(FALSE, downloadedFile@synapseStore)
  # we get external URL when retrieving only metadata
  expect_equal(filePath, getFileLocation(metadataOnly))
  expect_equal(filePath, downloadedFile@fileHandle$externalURL)
}

integrationTestUpdateExternalLink<-function() {
  # in this test we update a File having an external URL, using
  # the createOrUpdate setting, i.e. we submit a 'new' entity
  # which becomes an update of an existing one
  # This case was captured as SYNR-752
  project <- synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  
  originalUrl <- "https://github.com/brian-bot/rGithubClient/blob/d3960fdbb8b1a4ef6990d90283d6ec474e424d5d/R/view.R"
  f <- synStore(File(path=originalUrl, parentId=pid, synapseStore=FALSE))
  expect_equal(originalUrl, f@fileHandle$externalURL)
  
  newUrl <- "https://github.com/brian-bot/rGithubClient/blob/ca29bba76e8fcae8c9a206d8ba760fe951e442ab/R/view.R"
  f <- synStore(File(path=newUrl, parentId=pid, synapseStore=FALSE))  
  expect_equal(newUrl, f@fileHandle$externalURL)
  expect_equal(newUrl, getFileLocation(f))
  
  retrieved<-synGet(propertyValue(f, "id"), downloadFile=FALSE)
  expect_equal(newUrl, retrieved@fileHandle$externalURL)
  expect_equal(newUrl, getFileLocation(retrieved))
}

integrationTestNullStorageLocationId <- function() {
  # create a Project
  project <- synapseClient:::.getCache("testProject")
  expect_true(!is.null(project))
  # create a file to be uploaded
  filePath<- createFile(content="Some content")
  file<-File(filePath, parentId=propertyValue(project, "id"))
  # now store it
  storedFile<-synStore(file)
  scheduleCacheFolderForDeletion(storedFile@fileHandle$id)
  # simulate an 'old' fileHandle, having a NULL storageLocationId
  storedFile@fileHandle$storageLocationId<-NULL
  touchFile(filePath)
  synStore(storedFile) # in SYNR-938 this throws an error
}




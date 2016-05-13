
#
###############################################################################

.setUp <-
    function()
{
  synapseClient:::.setCache("oldWarn", options("warn")[[1]])
  options(warn=2L)
}

.tearDown <-
    function()
{
  options(warn = synapseClient:::.getCache("oldWarn"))
  if(!is.null(name <- synapseClient:::.getCache("detachMe"))){
    detach(name)
    synapseClient:::.deleteCache('detachMe')
  }
}

unitTestSimpleConstructor<-function() {
  # Skip the existence check within the File constructor
  synapseClient:::.mock("mockable.file.exists", function(...) {TRUE})
  
  # test that it works to give just a file path and parentId
  file<-File("/path/to/file", parentId="syn1234")
  
  # now check that S4 is not confused by annotation parameters
  file<-File("/path/to/file", parentId="syn1234", annotName=FALSE)
  expect_true(file@synapseStore) # this is the default and S4 should not mistake 'annotName' for 'synapseStore'
  expect_equal("FALSE", annotValue(file, "annotName")) # the extra param should become an annotation on the file
  expect_equal("/path/to/file", getFileLocation(file))
  
  # now check that S4 is not confused by annotation parameters WHEN FILE PATH IS OMITTED
  file<-File(parentId="syn1234", annotName=FALSE)
  expect_true(file@synapseStore) # this is the default and S4 should not mistake 'annotName' for 'synapseStore'
  expect_equal("FALSE", annotValue(file, "annotName")) # the extra param should become an annotation on the file
  expect_equal(character(0), getFileLocation(file))
}

unitTestParentIdRequired<-function() {
  # Skip the existence check within the File constructor
  synapseClient:::.mock("mockable.file.exists", function(...) {TRUE})
  
  # this is OK...
  File("/path/to/file", parentId="syn101")
  # ... but check that there's an error if parentId is ommitted
  expect_equal("try-error", class(try(File("/path/to/file"), silent=T)))
}

unitTestObjectConstructor<-function() {
  anObject<-list(foo="bar")
  file<-File(parentId="syn1234")
  file<-addObject(file, anObject)
  expect_true(synapseClient:::hasObjects(file))
  expect_equal(anObject, getObject(file, "anObject"))
  expect_equal(character(0), getFileLocation(file))
  
  
   file<-File(parentId="syn124", annotName="annot value")
   file<-addObject(file, anObject)
   expect_true(synapseClient:::hasObjects(file))
   expect_equal(anObject, getObject(file, "anObject"))
   expect_equal("syn124", propertyValue(file, "parentId"))
   expect_equal("annot value", annotValue(file, "annotName"))
 }

unitTestConstructor<-function() {
  # Skip the existence check within the File constructor
  synapseClient:::.mock("mockable.file.exists", function(...) {TRUE})
  
  description<-"this describes my File"
  versionComment<-"this is the first version"
  annotName<-"anAnnotation"
  annotValue<-"assigned annotation value"
  file<-File(
    "/path/to/file", 
    TRUE, 
    parentId="syn1234",
    description=description, 
    versionComment=versionComment,
    anAnnotation=annotValue)
  
  expect_equal("/path/to/file", file@filePath)
  expect_equal(TRUE, file@synapseStore)
  expect_equal("/path/to/file", getFileLocation(file))
  expect_equal(description, propertyValue(file, "description"))
  expect_equal(description, synapseClient:::synAnnotGetMethod(file, "description"))
  expect_equal(versionComment, propertyValue(file, "versionComment"))
  expect_equal("file", propertyValue(file, "name"))
  expect_equal(annotValue, annotValue(file, annotName))
  expect_equal(annotValue, synapseClient:::synAnnotGetMethod(file, annotName))
  expect_true(!synapseClient:::hasObjects(file))
  expect_equal("org.sagebionetworks.repo.model.FileEntity", propertyValue(file, "concreteType"))
}

unitTestListConstructor<-function() {
  description<-"this describes my File"
  annotValue<-"assigned annotation value"
  file<-synapseClient:::createFileFromProperties(list(description=description, anAnnotation=annotValue))
  expect_equal(description, propertyValue(file, "description"))
  expect_equal(annotValue, annotValue(file, "anAnnotation"))
}

unitTestSynAnnotSetMethod<-function() {
  file<-new("File")
  description<-"this describes my File"
  versionComment<-"this is the first version"
  annotName<-"anAnnotation"
  annotValue<-"assigned annotation value"
  file<-synapseClient:::synAnnotSetMethod(file, "description", description)
  expect_equal(description, synapseClient:::synAnnotGetMethod(file, "description"))
  file<-synapseClient:::synAnnotSetMethod(file, annotName, annotValue)
  expect_equal(annotValue, synapseClient:::synAnnotGetMethod(file, annotName))
}

unitTestFileUtilities<-function() {
  file<-new("File")
  file@fileHandle<-list(concreteType="S3FileHandle", storageLocationId="101")
  expect_true(!synapseClient:::isExternalFileHandle(file@fileHandle))
  expect_true(!synapseClient:::fileHasFileHandleId(file))
  expect_true(!synapseClient:::fileHasFilePath(file))
  file@fileHandle<-list(concreteType="org.sagebionetworks.repo.model.file.ExternalFileHandle")
  file@fileHandle$id<-"1234"
  file@filePath<-"/path/to/file"
  expect_true(synapseClient:::isExternalFileHandle(file@fileHandle))
  expect_true(synapseClient:::fileHasFileHandleId(file))
  expect_true(synapseClient:::fileHasFilePath(file))
}

unitTestValidateFile<-function() {
  file<-new("File")
  
  synapseClient:::validateFile(file)
  file@synapseStore<-FALSE
  result<-try(synapseClient:::validateFile(file), silent=T)
  expect_equal("try-error", class(result))
  
  file@fileHandle<-list(concreteType="org.sagebionetworks.repo.model.file.ExternalFileHandle")
  file@synapseStore<-TRUE
  result<-try(synapseClient:::validateFile(file), silent=T)
  expect_true("try-error"!=class(result))
}

unitTestAddObject <-
    function()
{
  own <- new("File")
  
  expect_true(!synapseClient:::hasObjects(own))

  foo<-diag(10)
  copy <- addObject(own, foo)
  expect_equal(foo, getObject(copy, "foo"))
  expect_true(synapseClient:::hasObjects(copy))
  
  copy<-renameObject(copy, "foo", "boo")
  expect_equal(foo, getObject(copy, "boo"))
  result<-try(getObject(copy, "foo"),silent=T)
  expect_true(class(result)=="try-error")
  
  deleted<-deleteObject(copy, "boo")
  result<-try(getObject(deleted, "boo"),silent=T)
  expect_true(class(result)=="try-error")
  expect_true(!synapseClient:::hasObjects(own))
}


unitTestGetObject <-
    function()
{
  own <- new("File")
  foo <- "boo"
  own<-addObject(own, foo)
  expect_equal(getObject(own, "foo"), "boo")
}

unitTestIsLoadable <- function() {
  foo<-diag(10)
  filePath<-tempfile()
  save(foo, file=filePath)
  expect_true(file.exists(filePath))
  origWarn<-options()$warn
  expect_true(synapseClient:::isLoadable(filePath))
  expect_equal(origWarn, options()$warn) # make sure options("warn") is restored
  
  connection<-file(filePath)
  writeLines("My dog has fleas", connection)
  close(connection)

  expect_true(file.exists(filePath))
  origWarn<-options()$warn
  expect_true(!synapseClient:::isLoadable(filePath))
  expect_equal(origWarn, options()$warn) # make sure options("warn") is restored
}

unitTestSelectUploadDestination<-function() {
	expected<-synapseClient:::S3UploadDestination(storageLocationId=as.integer(101))
  	uploadDestinations<-synapseClient:::UploadDestinationList(expected)
	file<-File(parentId="syn101")
	file@fileHandle <- list(storageLocationId=as.integer(101), concreteType = "org.sagebionetworks.repo.model.file.S3FileHandle")
  	expect_equal(expected, synapseClient:::selectUploadDestination(file, uploadDestinations))
	file@fileHandle <- list(storageLocationId=as.integer(202),  concreteType = "org.sagebionetworks.repo.model.file.S3FileHandle")
	expect_equal(NULL, synapseClient:::selectUploadDestination(file, uploadDestinations))
	
	# remove later
	url<-"sftp://host.com/some_uuid"
	eud<-synapseClient:::ExternalUploadDestination(url=url, storageLocationId=as.integer(303))
	uploadDestinations<-synapseClient:::UploadDestinationList(expected, eud)
	file@fileHandle<-list(externalURL="sftp://host.com/foo/bar", concreteType = "org.sagebionetworks.repo.model.file.ExternalFileHandle")
	expect_equal(eud, synapseClient:::selectUploadDestination(file, uploadDestinations))
}

unitTestMatchUrlHosts<-function() {
	expect_true(synapseClient:::matchURLHosts("sftp://host.com/foo", "sftp://host.com/folder/uuid"))
	expect_true(!synapseClient:::matchURLHosts("sftp://host.com/foo", "http://host.com/folder/uuid"))
	expect_true(!synapseClient:::matchURLHosts("sftp://host.com/foo", "sftp://someotherhost.com/folder/uuid"))
}

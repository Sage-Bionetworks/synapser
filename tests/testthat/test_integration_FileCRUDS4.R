### This is a test of the retrofit of the Entity-based commands to the File class
### 
### Author: bruce.hoff@sagebase.org
################################################################################ 

.setUp <-
		function()
{
	activity<-Activity(list(name="test activity"))
	activity<-createEntity(activity)
	synapseClient:::.setCache("testActivity", activity)
}

.tearDown <- 
  function()
{
	if(!is.null(synapseClient:::.getCache("testActivity"))) {
		try(deleteEntity(synapseClient:::.getCache("testActivity")))
		synapseClient:::.deleteCache("testActivity")
	}
	if(!is.null(synapseClient:::.getCache("testProject"))) {
		try(deleteEntity(synapseClient:::.getCache("testProject")))
		synapseClient:::.deleteCache("testProject")
	}
	if(!is.null(synapseClient:::.getCache("testProject2"))) {
		try(deleteEntity(synapseClient:::.getCache("testProject2")))
		synapseClient:::.deleteCache("testProject2")
	}
}

createFileInMemory<-function(project) {
  filePath<- tempfile()
  connection<-file(filePath)
  writeChar("this is a test", connection, eos=NULL)
  close(connection)  
  synapseStore<-TRUE
  file<-File(filePath, synapseStore, parentId=propertyValue(project, "id"))
  file
}

integrationTestCreateS4Files <- 
  function()
{
  ## Create Project
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  
  ## Create File
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  createdFile <- createEntity(file)
  expect_equal(propertyValue(createdFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(createdFile,"parentId"), propertyValue(createdProject, "id"))
  file <- createdFile
}

integrationTestCreateFileWithAnnotations <- 
		function()
{
	## Create Project
	project <- Project()
	annotValue(project, "annotationKey") <- "projectAnnotationValue"
	createdProject <- createEntity(project)
	synapseClient:::.setCache("testProject", createdProject)
	expect_equal(annotValue(createdProject, "annotationKey"), annotValue(project, "annotationKey"))
	
  ## Create File
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  annotValue(file, "annotKey") <- "annotValue"
  createdFile <- createEntity(file)
	expect_equal(propertyValue(createdFile,"name"), propertyValue(file, "name"))
	expect_equal(propertyValue(createdFile,"parentId"), propertyValue(createdProject, "id"))
	expect_equal(annotValue(createdFile,"annotKey"), annotValue(file, "annotKey"))
	expect_equal(NULL, generatedBy(createdFile))
	
}

integrationTestCreateFileWithGeneratedBy <- 
  function()
{
  ## Create Project
  project <- Project()
  annotValue(project, "annotationKey") <- "projectAnnotationValue"
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  expect_equal(annotValue(createdProject, "annotationKey"), annotValue(project, "annotationKey"))
  
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  testActivity <-synapseClient:::.getCache("testActivity")
  expect_true(!is.null(testActivity))
  generatedBy(file)<-testActivity
  file <- createEntity(file)
  createdFile<-getEntity(propertyValue(file, "id"))
  expect_equal(propertyValue(createdFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(createdFile,"parentId"), propertyValue(createdProject, "id"))
  expect_true(!is.null(generatedBy(createdFile)))
  expect_equal(propertyValue(testActivity,"id"), propertyValue(generatedBy(createdFile), "id"))
}

integrationTestUpdateFileWithGeneratedBy <- 
  function()
{
  ## Create Project
  project <- Project()
  annotValue(project, "annotationKey") <- "projectAnnotationValue"
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  expect_equal(annotValue(createdProject, "annotationKey"), annotValue(project, "annotationKey"))
  
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  file <- createEntity(file)
  testActivity <-synapseClient:::.getCache("testActivity")
  expect_true(!is.null(testActivity))
  generatedBy(file)<-testActivity
  file <- updateEntity(file)
  updatedFile<-getEntity(propertyValue(file, "id"))
  expect_equal(propertyValue(updatedFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(updatedFile,"parentId"), propertyValue(createdProject, "id"))
  expect_true(!is.null(generatedBy(updatedFile)))
  expect_equal(propertyValue(testActivity,"id"), propertyValue(generatedBy(updatedFile), "id"))
}

integrationTestStoreFileWithGeneratedBy <- 
  function()
{
  ## Create Project
  project <- Project()
  annotValue(project, "annotationKey") <- "projectAnnotationValue"
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  expect_equal(annotValue(createdProject, "annotationKey"), annotValue(project, "annotationKey"))
  
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  file <- createEntity(file)
  testActivity <-synapseClient:::.getCache("testActivity")
  expect_true(!is.null(testActivity))
  generatedBy(file)<-testActivity
  file <- storeEntity(file)
  updatedFile<-getEntity(propertyValue(file, "id"))
  expect_equal(propertyValue(updatedFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(updatedFile,"parentId"), propertyValue(createdProject, "id"))
  expect_true(!is.null(generatedBy(updatedFile)))
  expect_equal(propertyValue(testActivity,"id"), propertyValue(generatedBy(updatedFile), "id"))
}

integrationTestCreateFileWithNAAnnotations <- 
  function()
{
  ## Create Project
  project <- Project()
  annotValue(project, "annotationKey") <- "projectAnnotationValue"
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  expect_equal(annotValue(createdProject, "annotationKey"), annotValue(project, "annotationKey"))
  
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  
  annots <- list()
  annots$rawdataavailable <- TRUE 
  annots$number_of_samples <- 33 
  annots$contact <- NA 
  annots$platform <- "HG-U133_Plus_2"
  annotationValues(file) <- annots
  
  createdFile <- createEntity(file)
  
  expect_equal(propertyValue(createdFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(createdFile,"parentId"), propertyValue(createdProject, "id"))
  expect_equal(annotValue(createdFile,"platform"), "HG-U133_Plus_2")
  expect_equal(annotValue(createdFile,"number_of_samples"), 33)
  expect_equal(annotValue(createdFile,"rawdataavailable"), "TRUE")
  expect_true(is.null(annotValue(createdFile,"contact")[[1]]))
}

integrationTestUpdateS4File <-
  function()
{
  ## Create Project
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  
  ## set an annotation value and update. 
  annotValue(createdProject, "newKey") <- "newValue"
  updatedProject <- updateEntity(createdProject)
  expect_equal(propertyValue(updatedProject,"id"), propertyValue(createdProject,"id"))
  expect_true(propertyValue(updatedProject, "etag") != propertyValue(createdProject, "etag"))
  
  file<-createFileInMemory(createdProject)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  createdFile <- createEntity(file)
  
  ## update the annotations
  annotValue(createdFile, "newKey") <- "newValue"
  updatedFile <- updateEntity(createdFile)
  expect_equal(annotValue(updatedFile, "newKey"), annotValue(createdFile, "newKey"))
  expect_true(propertyValue(updatedFile, "etag") != propertyValue(createdFile, "etag"))
  expect_equal(propertyValue(updatedFile, "id"), propertyValue(createdFile, "id"))
}

integrationTestDeleteFileById <-
  function()
{
  # Skip the existence check within the File constructor
  synapseClient:::.mock("mockable.file.exists", function(...) {TRUE})
  
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  
  file<-File(synapseStore=TRUE, parentId=propertyValue(createdProject, "id"))
  file <- addObject(file, "foo", "bar")
  
  createdFile <- createEntity(file)
  
  cacheDir <- createdFile@filePath
  expect_true(file.exists(cacheDir))
  deleteEntity(createdFile)
  
  deleteEntity(createdProject$properties$id)
   expect_error(getEntity(createdFile), silent=TRUE)
  synapseClient:::.deleteCache("testProject")
}

integrationTestUpdateS4FileWithGeneratedBy <-
		function()
{
	## Create Project
	project <- Project()
	createdProject <- createEntity(project)
	synapseClient:::.setCache("testProject", createdProject)
	
  file<-createFileInMemory(createdProject)
  file<-storeEntity(file)
  
	## set generatedBy and update. 
	testActivity <-synapseClient:::.getCache("testActivity")
	expect_true(!is.null(testActivity))
	generatedBy(file) <- testActivity
	updatedFile <- updateEntity(file)
	testActivity <- generatedBy(updatedFile)
	# since storing the entity also stores the activity, we need to update the cached value
	synapseClient:::.setCache("testActivity", testActivity)
	expect_equal(propertyValue(testActivity, "id"), propertyValue(generatedBy(updatedFile), "id"))
	expect_true(propertyValue(updatedFile, "etag") != propertyValue(file, "etag"))

  #  get the entity by ID and verify that the generatedBy is not null
  gotFile <- getEntity(propertyValue(file, "id"))
  expect_true(!is.null(gotFile))
  expect_true(!is.null(generatedBy(gotFile)))
  
	## remove generatedBy and update
	file<-updatedFile
	generatedBy(file) <- NULL
  updatedFile <- updateEntity(file)
	expect_true(is.null(generatedBy(updatedFile)))
	
	## now *create* an Entity having a generatedBy initially
	deleteEntity(file)	

  file<-createFileInMemory(createdProject)

	generatedBy(file) <- testActivity
	createdFile <- createEntity(file)
	expect_true(!is.null(generatedBy(createdFile)))

	testActivity <- generatedBy(createdFile)
	# since storing the entity also stores the activity, we need to update the cached value
	synapseClient:::.setCache("testActivity", testActivity)
	
  #  get the entity by ID and verify that the generatedBy is not null
  gotFile <- getEntity(propertyValue(createdFile, "id"))
  expect_true(!is.null(gotFile))
  expect_true(!is.null(generatedBy(gotFile)))
  
  ## remove generatedBy and update
	generatedBy(createdFile)<-NULL
	updatedFile <- updateEntity(createdFile)
	expect_true(is.null(generatedBy(updatedFile)))
	
}

# a variation of the previous test, using the 'used' convenience function
integrationTestUpdateS4FileWithUsed <-
		function()
{
	## Create File
	project <- Project()
	createdProject <- createEntity(project)
	synapseClient:::.setCache("testProject", createdProject)
  file<-createFileInMemory(createdProject)
  createdFile<-storeEntity(file)
  
	project2 <- Project()
	createdProject2 <- createEntity(project2)
	synapseClient:::.setCache("testProject2", createdProject2)
  file2<-createFileInMemory(createdProject2)
  createdFile2<-storeEntity(file2)
  
	expect_true(is.null(used(createdFile)))
	## 2nd file was 'used' to generate 1st file
	used(createdFile)<-list(createdFile2)
	updatedFile <- updateEntity(createdFile)
	expect_true(propertyValue(updatedFile, "etag") != propertyValue(createdFile, "etag"))
	usedList<-used(updatedFile)
	expect_true(!is.null(usedList))
	expect_equal(1, length(usedList))
	targetId<-usedList[[1]]$reference$targetId
	names(targetId)<-NULL # needed to make the following check work
	expect_equal(propertyValue(createdFile2, "id"), targetId)
	
	## remove "used" list and update
	createdFile<-updatedFile
	used(createdFile) <- NULL
  updatedFile <- updateEntity(createdFile)
	expect_true(is.null(used(updatedFile)))
  
  deleteEntity(updatedFile)
	
	## now *create* an Entity having a "used" list initially
  file<-createFileInMemory(createdProject)
  
	used(file)<-list(list(entity=createdFile2, wasExecuted=F))
	
	createdFile <- createEntity(file)
	usedList2 <- used(createdFile)
	expect_true(!is.null(usedList2))
	expect_equal(1, length(usedList2))
	targetId<-usedList2[[1]]$reference$targetId
	names(targetId)<-NULL # needed to make the following check work
	expect_equal(propertyValue(createdFile2, "id"), targetId)
	expect_equal(F, usedList2[[1]]$wasExecuted)
	
	## remove "used" list and update
	used(createdFile)<-NULL
	updatedFile <- updateEntity(createdFile)
	expect_true(is.null(used(updatedFile)))
}

integrationTestDeleteFile <- 
  function()
{
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  
  file<-createFileInMemory(createdProject)
  createdFile <- createEntity(file)

  deleteEntity(createdFile)
  
  # should get a 404 error 
  result<-try(getEntity(propertyValue(createdFile, "id")), silent=TRUE)
  expect_equal("try-error", class(result))
}

integrationTestGetFile <-
  function()
{
  ## Create Project and File
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  file<-createFileInMemory(createdProject)
  createdFile<-storeEntity(file)
  
  fetchedFile <- getEntity(propertyValue(createdFile, "id"))
  expect_equal(propertyValue(fetchedFile, "id"), propertyValue(createdFile, "id"))
  
  fetchedFile <- getEntity(as.character(propertyValue(createdFile, "id")))
  expect_equal(propertyValue(fetchedFile, "id"), propertyValue(createdFile, "id"))
  
  fetchedFile <- getEntity(createdFile)
  expect_equal(propertyValue(fetchedFile, "id"), propertyValue(createdFile, "id"))
}

integrationTestReplaceFileAnnotations <- 
  function()
{
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  file<-createFileInMemory(createdProject)
  
  annotations(file) <- list(annotation1="value1", annotation2="value2")
  createdFile <- createEntity(file)
  
  annotations(createdFile) <- list(annotation3="value3", annotation4="value4", annotation5="value5")
  createdFile <- updateEntity(createdFile)
  
  expect_equal(length(annotationNames(createdFile)), 3L)
  expect_true(all(c("annotation3", "annotation4", "annotation5") %in% annotationNames(createdFile)))
}

integrationTestFileNameOverride <- 
  function()
{
  ## Create Project
  project <- Project()
  createdProject <- createEntity(project)
  synapseClient:::.setCache("testProject", createdProject)
  
  ## Create File
  file<-createFileInMemory(createdProject)  # file name will look like "file11f74c33ab59"
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file, "fileNameOverride")<-"testName.txt"
  propertyValue(file,"parentId") <- propertyValue(createdProject, "id")
  createdFile <- createEntity(file)
  id<-propertyValue(createdFile, "id")
  expect_equal(propertyValue(createdFile,"name"), propertyValue(file, "name"))
  expect_equal(propertyValue(createdFile,"parentId"), propertyValue(createdProject, "id"))
  expect_equal(propertyValue(createdFile,"fileNameOverride"), "testName.txt")
  updatedFile<-synStore(createdFile)
  # the bug in SYNR-989 was that the file-name override disappears
  expect_equal(propertyValue(updatedFile,"fileNameOverride"), "testName.txt")
  # we can also check by downloading
  unlink(getFileLocation(updatedFile))
  retrievedFile<-synGet(id)
  # finally, check that the over ride name is used to download the file
  expect_equal(basename(getFileLocation(retrievedFile)), "testName.txt")
}




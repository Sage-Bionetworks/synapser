### Test CRUD operations for S4 Activity objects
### 
### Author: Bruce Hoff
################################################################################ 

.setUp <-
		function()
{
	### create a project
	project <- createEntity(Project())
	synapseClient:::.setCache("testProject", project)

	## Create Data
	folder <- Folder(list(name="test folder", parentId=propertyValue(project, "id")))
	createdFolder <- createEntity(folder)
	synapseClient:::.setCache("testFolder", createdFolder)
}

.tearDown <- 
  function()
{
	if(!is.null(synapseClient:::.getCache("testActivity"))) {
		try(deleteEntity(synapseClient:::.getCache("testActivity")))
		synapseClient:::.deleteCache("testActivity")
	}
	if(!is.null(synapseClient:::.getCache("testFolder"))) {
		try(deleteEntity(synapseClient:::.getCache("testFolder")))
		synapseClient:::.deleteCache("testFolder")
	}
	if(!is.null(synapseClient:::.getCache("testProject"))) {
	  try(deleteEntity(synapseClient:::.getCache("testProject")))
	  synapseClient:::.deleteCache("testProject")
  }
}

integrationTestCRUDS4Activity <- 
  function()
{
  ## Create Activity
  name<-"testName"
  activity<-Activity(list(name=name))
  description<-"a description of the activity"
  propertyValue(activity, "description")<-description
  testFolder <-synapseClient:::.getCache("testFolder")
  propertyValue(activity, "used")<-list(list(reference=list(targetId=propertyValue(testFolder, "id")), 
      wasExecuted=F, concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"))
  activity<-createEntity(activity)
  activityId<-propertyValue(activity, "id")
  checkTrue(!is.null(activityId))
  synapseClient:::.setCache("testActivity", activity)
  
  # get
  act2<-getActivity(activityId)
  checkEquals(name, propertyValue(act2, "name"))
  checkEquals(description, propertyValue(act2, "description"))
  used2<-propertyValue(act2, "used")
  checkTrue(!is.null(used2))
  checkEquals(1, length(used2))
  checkEquals(3, length(used2[[1]])) # (1) 'wasExecuted', (2) the reference, (3) the concrete type
  targetId<-used2[[1]]$reference$targetId
  names(targetId)<-NULL # needed to make the following check work
  checkEquals(propertyValue(testFolder, "id"), targetId)
  checkEquals(F, used2[[1]]$wasExecuted)
  
  # update
  descr2<-"another description"
  propertyValue(act2, "description")<-descr2
  propertyValue(act2, "used")<-list(list(reference=list(targetId=propertyValue(testFolder, "id")), 
      wasExecuted=T, concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"))
  act2<-updateEntity(act2)
  checkEquals(descr2, propertyValue(act2, "description"))
  used2<-propertyValue(act2, "used")
  checkTrue(!is.null(used2))
  checkEquals(1, length(used2))
  checkEquals(3, length(used2[[1]])) # (1) 'wasExecuted', (2) the reference, (3) the concrete type
  targetId<-used2[[1]]$reference$targetId
  names(targetId)<-NULL # needed to make the following check work
  checkEquals(propertyValue(testFolder, "id"), targetId)
  checkEquals(T, used2[[1]]$wasExecuted)
  
  # delete
  synDelete(activity)	
  synapseClient:::.deleteCache("testActivity")
  shouldBeError<-try(getActivity(activityId), silent=T)
  checkTrue(class(shouldBeError)=="try-error")
}

integrationTestSynStore<-function() {
  name<-"testName"
  description<-"a description of the activity"
  testFolder <-synapseClient:::.getCache("testFolder")
  activity<-Activity(name=name, description=description, used=testFolder)
  activity<-synStore(activity)
  activityId<-propertyValue(activity, "id")
  checkTrue(!is.null(activityId))
  synapseClient:::.setCache("testActivity", activity)
  # now check content
  checkEquals(name, propertyValue(activity, "name"))
  checkEquals(description, propertyValue(activity, "description"))
  used2<-propertyValue(activity, "used")
  checkTrue(!is.null(used2))
  checkEquals(1, length(used2))
  checkEquals(3, length(used2[[1]])) # (1) 'wasExecuted', (2) the reference, (3) the concrete type
  targetId<-used2[[1]]$reference$targetId
  names(targetId)<-NULL # needed to make the following check work
  checkEquals(propertyValue(testFolder, "id"), targetId)
  checkEquals(F, used2[[1]]$wasExecuted)
}

integrationTestReferenceConstructorNoWasExceuted<-function() {
  activity<-Activity(list(name="name", description="description", used="syn1234"))
  
}

integrationTestReferenceConstructor <- 
  function()
{
  ## Create Activity
  name<-"testName"
  description<-"a description of the activity"
  testFolder <-synapseClient:::.getCache("testFolder")
  activity<-Activity(list(name=name, description=description, used=propertyValue(testFolder, "id")))
  activity<-createEntity(activity)
  activityId<-propertyValue(activity, "id")
  checkTrue(!is.null(activityId))
  synapseClient:::.setCache("testActivity", activity)
  
  # check that it can be retrieved
  getActivity(activityId)
  
  # delete
  synDelete(activity)	
  synapseClient:::.deleteCache("testActivity")
  shouldBeError<-try(getActivity(activityId), silent=T)
  checkTrue(class(shouldBeError)=="try-error")
}

integrationTestEntityConstructor <- 
  function()
{
  ## Create Activity
  name<-"testName"
  description<-"a description of the activity"
  testFolder <-synapseClient:::.getCache("testFolder")
  activity<-Activity(list(name=name, description=description, used=list(testFolder)))
  activity<-createEntity(activity)
  activityId<-propertyValue(activity, "id")
  checkTrue(!is.null(activityId))
  synapseClient:::.setCache("testActivity", activity)
  
  # delete
  synDelete(activity)	
  synapseClient:::.deleteCache("testActivity")
  shouldBeError<-try(getActivity(activityId), silent=T)
  checkTrue(class(shouldBeError)=="try-error")
}



# 
# Author: brucehoff
###############################################################################


unitTestCreateS4ObjectFromList<-function() {
  # simple case: list argument has just primitives
  listRep<-list(name="name", description="description")
  e<-synapseClient:::createS4ObjectFromList(listRep, "Evaluation")
  expect_equal("name", e@name)
  expect_equal("description", e@description)
  
  up<-synapseClient:::createS4ObjectFromList( 
    list(ownerId="101", 
      emails=c("foo@bar.com", "bar@bas.com")
    ), "UserProfile")
  expect_equal("101", up@ownerId)
  expect_equal(c("foo@bar.com", "bar@bas.com"), up@emails)
  
  # list argument has content of embedded S4 object
  up<-synapseClient:::createS4ObjectFromList( 
    list(ownerId="101", 
      emails=c("foo@bar.com", "bar@bas.com"),
      notificationSettings=list(sendEmailNotifications=T, markEmailedMessagesAsRead=F)
    ), "UserProfile")
  expect_equal("101", up@ownerId)
  expect_equal(c("foo@bar.com", "bar@bas.com"), up@emails)
  expect_equal(synapseClient:::Settings(sendEmailNotifications=T, markEmailedMessagesAsRead=F), up@notificationSettings)
  
  # list has array of embedded S4 objects
  
  up<-synapseClient:::createS4ObjectFromList( 
    list(ownerId="101", 
      emails=c("foo@bar.com", "bar@bas.com"),
      notificationSettings=list(sendEmailNotifications=T, markEmailedMessagesAsRead=F),
      preferences=list(
        list(concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean", name="foo", value=T),
        list(concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean", name="bar", value=F)
      )
    ), "UserProfile")
  expect_equal("101", up@ownerId)
  expect_equal(c("foo@bar.com", "bar@bas.com"), up@emails)
  expect_equal(synapseClient:::Settings(sendEmailNotifications=T, markEmailedMessagesAsRead=F), up@notificationSettings)
  prefs<-up@preferences
  expect_true(!is.null(prefs))
  expect_equal(2, length(prefs))
  expect_equal(synapseClient:::UserPreferenceBoolean(name="foo", value=T, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean"), prefs[[1]])
  expect_equal(synapseClient:::UserPreferenceBoolean(name="bar", value=F, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean"), prefs[[2]])
}


unitTestS4RoundTrip<-function() {
  e<-Evaluation(name="name", description="description")
  listRep<-synapseClient:::createListFromS4Object(e)
  expect_equal(e, synapseClient:::createS4ObjectFromList(listRep, "Evaluation"))
  emails<-c("foo@bar.com", "bar@bas.com")
  preferences<-new("UserPreferenceList")
  preferences@content<-list(
    synapseClient:::UserPreferenceBoolean(name="foo", value=T, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean"),
    synapseClient:::UserPreferenceBoolean(name="bar", value=F, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean")
  )
  notificationSettings<-synapseClient:::Settings(sendEmailNotifications=T, markEmailedMessagesAsRead=F)
  up<-synapseClient:::UserProfile(
    ownerId="101", 
    emails=emails,
    preferences=preferences,
    notificationSettings=notificationSettings
  )
  
  listRep<-synapseClient:::createListFromS4Object(up)
  expect_equal(up, synapseClient:::createS4ObjectFromList(listRep, "UserProfile"))
  
}

unitTestMissingS4Field<-function() {
  # note:  there's no 'notificationSettings' field
  emails<-c("foo@bar.com", "bar@bas.com")
  preferences<-new("UserPreferenceList")
  preferences@content<-list(
    synapseClient:::UserPreferenceBoolean(name="foo", value=T, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean"),
    synapseClient:::UserPreferenceBoolean(name="bar", value=F, concreteType="org.sagebionetworks.repo.model.UserPreferenceBoolean")
  )
  up<-synapseClient:::UserProfile(
    ownerId="101", 
    emails=emails,
    preferences=preferences
  )
  
  listRep<-synapseClient:::createListFromS4Object(up)
  
  # There should not be a list entry for 'notificationSettings'
  expect_true(is.null(listRep$notificationSettings))
  
  # Also double check that it generates the original UserProfile
  expect_equal(up, synapseClient:::createS4ObjectFromList(listRep, "UserProfile"))
}

unitTestRoundTripWithEnumField<-function() {
  # Note:  'status' is defined as an enum field
  s<-synapseClient:::SubmissionStatus(id="12345", status="SCORED", entityId="syn101")
  li<-synapseClient:::createListFromS4Object(s)
  s2<-synapseClient:::createS4ObjectFromList(li, "SubmissionStatus")
  expect_equal(s,s2)
}

unitTestVector<-function() {
  x<-c(concreteType="org.sagebionetworks.repo.model.table.UploadToTableRequest", tableId="syn12345", uploadFileHandleId="1111")
  obj<-synapseClient:::createS4ObjectFromList(x, "AsynchronousRequestBody")
  expect_equal("UploadToTableRequest", as.character(class(obj)))
}

unitTestIntegerAssignment<-function() {
  # constructor converts numeric to integer
  TableColumn(maximumSize=10)
  # an edge case...
  TableColumn(maximumSize=numeric(0))
}

unitTestFileHandle<-function() {
  fileHandle<-synapseClient:::S3FileHandle(id="999", fileName="foo.txt")
  fileHandleAsList<-synapseClient:::createListFromS4Object(fileHandle)
}

unitTestExtraField<-function() {
  listRep<-list(name="name", description="description", foo="bar")
  # should hang on to the unexpected field "foo"
  e<-synapseClient:::createS4ObjectFromList(listRep, "Evaluation")
  expect_equal("name", e@name)
  expect_equal("description", e@description)
  expect_equal(e@autoGeneratedExtra$foo, "bar")
  expect_equal(synapseClient:::createListFromS4Object(e), listRep)
}

unitTestEmptyExceptConcreteType<-function() {
  fileHandle<-c(concreteType="org.sagebionetworks.repo.model.file.S3FileHandle")
  s4FileHandle<-synapseClient:::createS4ObjectFromList(fileHandle, "FileHandle")
  expect_equal(s4FileHandle, synapseClient:::S3FileHandle())
}



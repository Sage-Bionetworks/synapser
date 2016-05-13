#
# Tests for schema parsing / class generating functions
#
#########################################################

unitTestGetImplements<-function() {
  expect_true(is.null(synapseClient:::getImplements(synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath()))))
  folderSchemaDef<-
    synapseClient:::readSchema("org.sagebionetworks.repo.model.Folder", synapseClient:::getSchemaPath())
  expect_true(!is.null(synapseClient:::getImplements(folderSchemaDef)))
  expect_equal("org.sagebionetworks.repo.model.Entity", synapseClient:::getImplements(folderSchemaDef)[[1]][["$ref"]])
}

unitTestisVirtual<-function() {
  expect_true(!synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.table.Row", synapseClient:::getSchemaPath())))
  expect_true(!synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.Folder", synapseClient:::getSchemaPath())))
  expect_true(synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.Entity", synapseClient:::getSchemaPath())))
}

unitTestGetPropertyTypes<-function() {
  userPreference <- synapseClient:::readSchema("org.sagebionetworks.repo.model.UserPreference", synapseClient:::getSchemaPath())
  expect_equal(list(name="string", concreteType="string"), synapseClient:::getPropertyTypes(userPreference))
  userProfileSchema <- synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  upProperties<-synapseClient:::getPropertyTypes(userProfileSchema)
  expect_equal("string", upProperties$lastName)
  expect_equal("org.sagebionetworks.repo.model.message.Settings", upProperties$notificationSettings)
}

unitTestInstantiateGetAndSet<-function() {
  e<-Evaluation(name="name", description="description")
  expect_equal("name", e@name)
  expect_equal("name", e$name)
  expect_equal("name", propertyValue(e, "name"))
  e@name<-"foo"
  expect_equal("foo", e@name)
  expect_equal("foo", e$name)
  expect_equal("foo", propertyValue(e, "name"))
  expect_equal("description", e@description)
  e$name<-"bar"
  expect_equal("bar", e@name)
  expect_equal("bar", e$name)
  expect_equal("bar", propertyValue(e, "name"))
  expect_equal("description", e@description)
  propertyValue(e, "name")<-"bas"
  expect_equal("bas", e@name)
  expect_equal("bas", e$name)
  expect_equal("bas", propertyValue(e, "name"))
  expect_equal("description", e@description)
}

unitTestS4Equals<-function() {
  e1<-Evaluation()
  e2<-Evaluation()
  expect_true(identical(e1, e2))
  
  up1<-UserProfile()
  up2<-UserProfile()
  expect_true(identical(up1, up2))
  
  up1<-UserProfile(ownerId="foo", openIds=c("foo1", "foo2"), 
    notificationSettings=Settings(sendEmailNotifications=TRUE, markEmailedMessagesAsRead=FALSE),
    preferences=UserPreferenceList(UserPreferenceBoolean("foo", TRUE)))
  up2<-UserProfile(ownerId="foo", openIds=c("foo1", "foo2"), 
    notificationSettings=Settings(sendEmailNotifications=TRUE, markEmailedMessagesAsRead=FALSE),
    preferences=UserPreferenceList(UserPreferenceBoolean("foo", TRUE)))
  expect_true(identical(up1, up2))
}

unitTestNonPrimitiveField<-function() {
  up<-synapseClient:::UserProfile(ownerId="101")
  settings<-synapseClient:::Settings(sendEmailNotifications=TRUE)
  up$notificationSettings<-settings
  expect_equal("101", up$ownerId)
  expect_equal(TRUE, up$notificationSettings$sendEmailNotifications)
}

unitTestListofS4<-function() {
  expect_equal(getSlots("UserProfile")[["preferences"]],  "UserPreferenceListOrNull")
}

unitTestEnumField<-function() {
  submissionStatus<-synapseClient:::SubmissionStatus(id="101", entityId="syn987", status="RECEIVED")
  expect_equal("101", submissionStatus$id)
  expect_equal("syn987", submissionStatus$entityId)
  expect_equal("RECEIVED", submissionStatus$status)
}

unitTestSchemaTypeFromProperty<-function() {
  upSchema<-synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  propertySchema<-upSchema$properties[["lastName"]]
  expect_equal("string", synapseClient:::schemaTypeFromProperty(propertySchema))
  
  propertySchema<-upSchema$properties[["notificationSettings"]]
  expect_equal("org.sagebionetworks.repo.model.message.Settings", 
    synapseClient:::schemaTypeFromProperty(propertySchema))
}

unitTestArraySubSchema<-function() {
  upSchema<-synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  
  propertySchema<-upSchema$properties[["emails"]]
  expect_equal("string", synapseClient:::schemaTypeFromProperty(
      synapseClient:::getArraySubSchema(propertySchema)))
  
  propertySchema<-upSchema$properties[["preferences"]]
  expect_equal("org.sagebionetworks.repo.model.UserPreference", 
    synapseClient:::schemaTypeFromProperty(
      synapseClient:::getArraySubSchema(propertySchema)))
  
}


unitTestConcreteType<-function() {
  booleanPref<-new("UserPreferenceBoolean")
  expect_equal("org.sagebionetworks.repo.model.UserPreferenceBoolean", booleanPref$concreteType)
}




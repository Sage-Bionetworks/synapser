#
# Tests for schema parsing / class generating functions
#
#########################################################

unitTestGetImplements<-function() {
  checkTrue(is.null(synapseClient:::getImplements(synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath()))))
  folderSchemaDef<-
    synapseClient:::readSchema("org.sagebionetworks.repo.model.Folder", synapseClient:::getSchemaPath())
  checkTrue(!is.null(synapseClient:::getImplements(folderSchemaDef)))
  checkEquals("org.sagebionetworks.repo.model.Entity", synapseClient:::getImplements(folderSchemaDef)[[1]][["$ref"]])
}

unitTestisVirtual<-function() {
  checkTrue(!synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.table.Row", synapseClient:::getSchemaPath())))
  checkTrue(!synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.Folder", synapseClient:::getSchemaPath())))
  checkTrue(synapseClient:::isVirtual(synapseClient:::readSchema("org.sagebionetworks.repo.model.Entity", synapseClient:::getSchemaPath())))
}

unitTestGetPropertyTypes<-function() {
  userPreference <- synapseClient:::readSchema("org.sagebionetworks.repo.model.UserPreference", synapseClient:::getSchemaPath())
  checkEquals(list(name="string", concreteType="string"), synapseClient:::getPropertyTypes(userPreference))
  userProfileSchema <- synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  upProperties<-synapseClient:::getPropertyTypes(userProfileSchema)
  checkEquals("string", upProperties$lastName)
  checkEquals("org.sagebionetworks.repo.model.message.Settings", upProperties$notificationSettings)
}

unitTestInstantiateGetAndSet<-function() {
  e<-Evaluation(name="name", description="description")
  checkEquals("name", e@name)
  checkEquals("name", e$name)
  checkEquals("name", propertyValue(e, "name"))
  e@name<-"foo"
  checkEquals("foo", e@name)
  checkEquals("foo", e$name)
  checkEquals("foo", propertyValue(e, "name"))
  checkEquals("description", e@description)
  e$name<-"bar"
  checkEquals("bar", e@name)
  checkEquals("bar", e$name)
  checkEquals("bar", propertyValue(e, "name"))
  checkEquals("description", e@description)
  propertyValue(e, "name")<-"bas"
  checkEquals("bas", e@name)
  checkEquals("bas", e$name)
  checkEquals("bas", propertyValue(e, "name"))
  checkEquals("description", e@description)
}

unitTestS4Equals<-function() {
  e1<-Evaluation()
  e2<-Evaluation()
  checkTrue(identical(e1, e2))
  
  up1<-UserProfile()
  up2<-UserProfile()
  checkTrue(identical(up1, up2))
  
  up1<-UserProfile(ownerId="foo", openIds=c("foo1", "foo2"), 
    notificationSettings=Settings(sendEmailNotifications=TRUE, markEmailedMessagesAsRead=FALSE),
    preferences=UserPreferenceList(UserPreferenceBoolean("foo", TRUE)))
  up2<-UserProfile(ownerId="foo", openIds=c("foo1", "foo2"), 
    notificationSettings=Settings(sendEmailNotifications=TRUE, markEmailedMessagesAsRead=FALSE),
    preferences=UserPreferenceList(UserPreferenceBoolean("foo", TRUE)))
  checkTrue(identical(up1, up2))
}

unitTestNonPrimitiveField<-function() {
  up<-synapseClient:::UserProfile(ownerId="101")
  settings<-synapseClient:::Settings(sendEmailNotifications=TRUE)
  up$notificationSettings<-settings
  checkEquals("101", up$ownerId)
  checkEquals(TRUE, up$notificationSettings$sendEmailNotifications)
}

unitTestListofS4<-function() {
  checkEquals(getSlots("UserProfile")[["preferences"]],  "UserPreferenceListOrNull")
}

unitTestEnumField<-function() {
  submissionStatus<-synapseClient:::SubmissionStatus(id="101", entityId="syn987", status="RECEIVED")
  checkEquals("101", submissionStatus$id)
  checkEquals("syn987", submissionStatus$entityId)
  checkEquals("RECEIVED", submissionStatus$status)
}

unitTestSchemaTypeFromProperty<-function() {
  upSchema<-synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  propertySchema<-upSchema$properties[["lastName"]]
  checkEquals("string", synapseClient:::schemaTypeFromProperty(propertySchema))
  
  propertySchema<-upSchema$properties[["notificationSettings"]]
  checkEquals("org.sagebionetworks.repo.model.message.Settings", 
    synapseClient:::schemaTypeFromProperty(propertySchema))
}

unitTestArraySubSchema<-function() {
  upSchema<-synapseClient:::readSchema("org.sagebionetworks.repo.model.UserProfile", synapseClient:::getSchemaPath())
  
  propertySchema<-upSchema$properties[["emails"]]
  checkEquals("string", synapseClient:::schemaTypeFromProperty(
      synapseClient:::getArraySubSchema(propertySchema)))
  
  propertySchema<-upSchema$properties[["preferences"]]
  checkEquals("org.sagebionetworks.repo.model.UserPreference", 
    synapseClient:::schemaTypeFromProperty(
      synapseClient:::getArraySubSchema(propertySchema)))
  
}


unitTestConcreteType<-function() {
  booleanPref<-new("UserPreferenceBoolean")
  checkEquals("org.sagebionetworks.repo.model.UserPreferenceBoolean", booleanPref$concreteType)
}




# Integration Tests for ACL management
# 
# Author: brucehoff
###############################################################################

.setUp <- function() {
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
  
}

.tearDown <- function() {
  ## delete the test project
  deleteEntity(synapseClient:::.getCache("testProject"))
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

integrationTestACLRoundtrip <- function() {
  project<-synapseClient:::.getCache("testProject")
  file<-createFileInMemory(project)
  propertyValue(file, "name") <- "testFileName"
  propertyValue(file,"parentId") <- propertyValue(project, "id")
  file <- createEntity(file)
  id<-propertyValue(file, "id")
  checkTrue(!is.null(id))
  
  # make an ACL for the file
  acl<-AccessControlList(id=id)
  myProfile<-synGetUserProfile()
  myId<-myProfile@ownerId
  checkTrue(!is.null(myId))
  ra<-ResourceAccess(principalId=as.integer(myId), 
    accessType=c("CHANGE_PERMISSIONS", "UPDATE", "CREATE", "READ", "DELETE"))
  acl@resourceAccess<-ResourceAccessList(ra)
  acl<-synCreateEntityACL(acl)
  checkEquals(id, acl@id)
  checkEquals(1, length(acl@resourceAccess))
  checkEquals(ra@principalId, acl@resourceAccess[[1]]@principalId)
  checkEquals(length(ra@accessType), length(acl@resourceAccess[[1]]@accessType))
  
  # retrieve the ACL for the file
  retrieved<-synGetEntityACL(id)
  checkEquals(retrieved@id, acl@id)
  checkEquals(length(retrieved@resourceAccess), length(acl@resourceAccess))
  checkEquals(retrieved@resourceAccess[[1]]@principalId, acl@resourceAccess[[1]]@principalId)
  checkEquals(length(retrieved@resourceAccess[[1]]@accessType), length(acl@resourceAccess[[1]]@accessType))
  
  # change the ACL for the file
  newPermissionList<-c("CHANGE_PERMISSIONS", "UPDATE", "READ", "DELETE")
  acl@resourceAccess[[1]]@accessType<-newPermissionList
  acl<-synUpdateEntityACL(acl)
  checkTrue(identical(length(newPermissionList), length(acl@resourceAccess[[1]]@accessType)))
  
  # delete the ACL for the file
  # this just verifies that no error occurs
  synDeleteEntityACL(id)
  
  #TODO check that it's inherited again
  # can't do this properly until PLFM-2951 is done
}
# Integration test for user profile
# 
# Author: brucehoff
###############################################################################


checkEqualsUserProfiles<-function(p1, p2) {
  slotNames<-c("ownerId", "uri", "etag", "firstName", "lastName") # etc.
  for (slotName in slotNames) {
    checkEquals(slot(p1, slotName), slot(p2, slotName))
  }
}

integrationTestUserProfile<-function() {
  profile<-synGetUserProfile()
  origSummary<-propertyValue(profile, "summary")
  
  propertyValue(profile, "summary")<-"test summary text"
  profile2<-synStore(profile)
  propertyValue(profile, "etag")<-propertyValue(profile2, "etag")
  checkEqualsUserProfiles(profile2, profile)
  
  profile3<-synGetUserProfile()
  checkEqualsUserProfiles(profile3, profile)
  
  profile4<-synGetUserProfile(propertyValue(profile, "ownerId"))
  checkEqualsUserProfiles(profile4, profile)
  
  # restore to original settings
  propertyValue(profile, "summary")<-origSummary
  synStore(profile)
}


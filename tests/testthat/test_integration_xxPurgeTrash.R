# purge trash
# 
# Author: brucehoff
###############################################################################


# check the name of the test user, lest we accidently empty the trash can of a 
# real user who happens to be running the integration test suite
integrationTestPurge <- function() {
  myProfile<-synGetUserProfile()
  myName<-myProfile$userName
  if (myName=="RClientTestUser") {
    synRestPUT("/trashcan/purge", list())
  }
}
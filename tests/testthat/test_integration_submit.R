# Test submit (to evaluation)
# 
# Author: brucehoff
###############################################################################

.setUp <- function() {
  project <- createEntity(Project())
  projectId<-propertyValue(project, "id")
  synapseClient:::.setCache("testProject", project)
  submissionReceiptMessage<-"Your submission has been received. Please check the leader board for your score."
  evaluation<-Evaluation(name=sprintf("test_submit_%d", sample(10000,1)), status="OPEN", contentSource=projectId, submissionReceiptMessage=submissionReceiptMessage)
  evaluation<-synStore(evaluation)
  synapseClient:::.setCache("testEvaluation", evaluation)
  
  # create a participant team
  participantTeam<-synapseClient:::Team(name=sprintf("participant_team_%d", sample(10000,1)))
  response<-synRestPOST("/team", synapseClient:::createListFromS4Object(participantTeam))
  participantTeam<-synapseClient:::createS4ObjectFromList(response, "Team")
  synapseClient:::.setCache("participantTeam", participantTeam)
  
  # create a challenge using the participant team
  challenge<-synapseClient:::Challenge(participantTeamId=participantTeam$id, projectId=projectId)
  response<-synRestPOST("/challenge", synapseClient:::createListFromS4Object(challenge))
  challenge<-synapseClient:::createS4ObjectFromList(response, "Challenge")
  synapseClient:::.setCache("testChallenge", challenge)
	
  # create a challenge team
  submitTeam<-synapseClient:::Team(name=sprintf("submit_team_%d", sample(10000,1)))
  response<-synRestPOST("/team", synapseClient:::createListFromS4Object(submitTeam))
  submitTeam<-synapseClient:::createS4ObjectFromList(response, "Team")
  synapseClient:::.setCache("submitTeam", submitTeam)
	
  # register the team for the challenge
  challengeTeam<-synapseClient:::ChallengeTeam(challengeId=challenge$id, teamId=submitTeam$id)
  response<-synRestPOST(sprintf("/challenge/%s/challengeTeam", challenge$id),
		  synapseClient:::createListFromS4Object(challengeTeam))
  challengeTeam<-synapseClient:::createS4ObjectFromList(response, "ChallengeTeam")
  synapseClient:::.setCache("challengeTeam", challengeTeam)
}

.tearDown <- function() {
  # delete the Evaluation
  evaluation<-synapseClient:::.getCache("testEvaluation")
  synDelete(evaluation)
  
  # delete the project.  This will delete the Challenge object as well.
  project<-synapseClient:::.getCache("testProject")
  deleteEntity(project)
  synRestPUT(sprintf("/trashcan/purge/%s", propertyValue(project, "id")), list())
  
  # delete the submit team
  submitTeam<-synapseClient:::.getCache("submitTeam")
  synRestDELETE(sprintf("/team/%s", submitTeam$id))
  
  # delete the participant team 
  participantTeam<-synapseClient:::.getCache("participantTeam")
  synRestDELETE(sprintf("/team/%s", participantTeam$id))
}

integrationTest_submitWithTeam <- function() {
  # create an entity
  project<-synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  file<-File(parentId=pid, name="foo")
  file<-addObject(file,c(1,2,3))
  file<-synStore(file)
  
  # join the evaluation
  evaluation<-synapseClient:::.getCache("testEvaluation")
  eid<-propertyValue(evaluation, "id")
  PUBLIC_GROUP_PRINCIPAL_ID<-273949 # This is defined in org.sagebionetworks.repo.model.AuthorizationConstants
  synapseClient:::.allowParticipation(eid, PUBLIC_GROUP_PRINCIPAL_ID)
  
  # try submitting with a non-existent team name and check that it doesn't work
  dummyTeamName<-sprintf("this_is_not_a_team_name_%d", sample(10000,1))
  result<-try(submit(evaluation=evaluation, entity=file, submissionName=submissionName, teamName=dummyTeamName, silent=T),
		  silent=T)
  expect_equal(class(result), "try-error")
  
  # submit the entity
  submitTeam<-synapseClient:::.getCache("submitTeam")
  submissionName<-"test-sub-name"
  teamName<-submitTeam$name
  submissionResult<-submit(evaluation=evaluation, entity=file, submissionName=submissionName, teamName=teamName, silent=T)
  submission<-submissionResult$submission
  submissionReceiptMessage<-"Your submission has been received. Please check the leader board for your score." # duplicates def'n above
  expect_equal(submissionReceiptMessage, submissionResult$submissionReceiptMessage)
  expect_equal(propertyValue(file, "id"), propertyValue(submission, "entityId"))
  expect_equal(propertyValue(file, "versionNumber"), propertyValue(submission, "versionNumber"))
  expect_equal(eid, propertyValue(submission, "evaluationId"))
  expect_equal(submissionName, submission$name)
  expect_equal(teamName, submission$submitterAlias)
  
  # retrieve the submission
  # first, get rid of the local copy
  origChecksum<- as.character(tools::md5sum(getFileLocation(file)))
  unlink(getFileLocation(file))
  unlink(synapseClient:::cacheMapFilePath(file@fileHandle$id))
  
  submission2<-synGetSubmission(propertyValue(submission, "id"))
  # make sure they're the same (except the download file path)
  submission2MinusFilePath<-submission2
  submission2MinusFilePath@filePath<-character(0)
  expect_equal(submission, submission2MinusFilePath)
  
  # check that the file was downloaded
  expect_true(!is.null(getFileLocation(submission2)))
  expect_true(!is.null(submission2@fileHandle))
  # check that the file content is correct!
  submissionCheckSum<-as.character(tools::md5sum(getFileLocation(submission2)))
  expect_equal(origChecksum, submissionCheckSum)
  
  expect_equal(0, length(listObjects(submission2)))
  
  # now download with load=T
  submission2<-synGetSubmission(submission$id, load=T)
  expect_true(!is.null(getFileLocation(submission2)))
  expect_true(!is.null(submission2@fileHandle))
  expect_equal(1, length(listObjects(submission2)))
  expect_equal(c(1,2,3), getObject(submission2))
  
  # delete the submission
  synDelete(submission)
  
  # rev the entity
  file<-addObject(file, c(4,5,6))
  file<-synStore(file)
  # changing the file automatically increments the version
  expect_equal(2, propertyValue(file, "versionNumber"))
  
  # now submit the old version
  oldFile<-synGet(propertyValue(file, "id"), version=1, downloadFile=F)
  expect_equal(1, propertyValue(oldFile, "versionNumber"))
  submissionResult2<-submit(evaluation, oldFile, teamName=teamName, silent=T)
  submission2<-submissionResult2$submission
  
  expect_equal(propertyValue(oldFile, "id"), propertyValue(submission2, "entityId"))
  expect_equal(propertyValue(oldFile, "versionNumber"), propertyValue(submission2, "versionNumber"))
  expect_equal(eid, propertyValue(submission2, "evaluationId"))
  expect_equal(propertyValue(oldFile, "name"), propertyValue(submission2, "name"))
  
  # retrieve the submission
  submission3<-synGetSubmission(propertyValue(submission2, "id"))
  submission3MinusFilePath<-submission3
  submission3MinusFilePath@filePath<-character(0)
  expect_equal(submission2, submission3MinusFilePath)
  
  # delete the submission
  synDelete(submission3)
  
   expect_error(synGetSubmission(propertyValue(submission3, "id")))
}
  
integrationTest_submit_noTeamName <- function() {
  # create an entity
  project<-synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  file<-File(parentId=pid, name="foo")
  file<-addObject(file,c(1,2,3))
  file<-synStore(file)
  
  # join the evaluation
  evaluation<-synapseClient:::.getCache("testEvaluation")
  eid<-propertyValue(evaluation, "id")
  PUBLIC_GROUP_PRINCIPAL_ID<-273949 # This is defined in org.sagebionetworks.repo.model.AuthorizationConstants
  synapseClient:::.allowParticipation(eid, PUBLIC_GROUP_PRINCIPAL_ID)
  synRestPOST(sprintf("/evaluation/%s/participant", eid), list())
  
  # submit the entity
  submissionName<-"test-sub-name"
  submissionResult<-submit(evaluation=evaluation, entity=file, submissionName=submissionName, silent=T)
  submission<-submissionResult$submission
  submissionReceiptMessage<-"Your submission has been received. Please check the leader board for your score." # duplicates def'n above
  expect_equal(submissionReceiptMessage, submissionResult$submissionReceiptMessage)
  expect_equal(propertyValue(file, "id"), propertyValue(submission, "entityId"))
  expect_equal(propertyValue(file, "versionNumber"), propertyValue(submission, "versionNumber"))
  expect_equal(eid, propertyValue(submission, "evaluationId"))
  expect_equal(submissionName, submission$name)
  
}

# this is the test for SYNR-613
integrationTest_externalURL <- function() {
  # create an entity
  project<-synapseClient:::.getCache("testProject")
  pid<-propertyValue(project, "id")
  file<-File(path="http://versions.synapse.sagebase.org/synapseRClient", parentId=pid, name="foo", synapseStore=FALSE)
  file<-synStore(file)
  
  # join the evaluation
  evaluation<-synapseClient:::.getCache("testEvaluation")
  eid<-propertyValue(evaluation, "id")
  PUBLIC_GROUP_PRINCIPAL_ID<-273949 # This is defined in org.sagebionetworks.repo.model.AuthorizationConstants
  synapseClient:::.allowParticipation(eid, PUBLIC_GROUP_PRINCIPAL_ID)
  synRestPOST(sprintf("/evaluation/%s/participant", eid), list())
  
  # submit the entity
  submissionName<-"test-sub-name"
  submissionResult<-submit(evaluation=evaluation, entity=file, submissionName=submissionName, silent=T)
  
  submission<-submissionResult$submission
  submissionReceiptMessage<-"Your submission has been received. Please check the leader board for your score." # duplicates def'n above
  expect_equal(submissionReceiptMessage, submissionResult$submissionReceiptMessage)
  
  # In SYNR-613 the following breaks due to submitting an external URL
  retrievedSubmission<-synGetSubmission(submission$id)
  
  expect_equal(propertyValue(file, "id"), propertyValue(retrievedSubmission, "entityId"))
  expect_equal(propertyValue(file, "versionNumber"), propertyValue(retrievedSubmission, "versionNumber"))
  expect_equal(eid, propertyValue(retrievedSubmission, "evaluationId"))
  expect_equal(submissionName, retrievedSubmission$name)
  
}

# Integration test for Evaluation, Submission, attached WikiPage, etc.
# 
# Author: brucehoff
###############################################################################

.setUp <- function() {
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
  
}

.tearDown <- function() {
  ## delete the test evaluation
  evaluation<-synapseClient:::.getCache("testEvaluation")
  if (!is.null(evaluation)) synDelete(evaluation)
  
  ## delete the test project
  deleteEntity(synapseClient:::.getCache("testProject"))
}

#
# this tests the file services underlying the wiki CRUD for entities
#
integrationTestEvaluationRoundtrip <-
  function()
{
  project <- synapseClient:::.getCache("testProject")
  checkTrue(!is.null(project))
  projectId<-propertyValue(project, "id")
  
  name<-sprintf("test evaluation %d", sample(1000,1))
  submissionReceiptMessage<-"Your submission has been received. Please check the leader board for your score."
  evaluation<-Evaluation(name=name, status="PLANNED", contentSource=projectId, submissionReceiptMessage=submissionReceiptMessage)
  evaluation<-synStore(evaluation)
  # store for later deletion
  synapseClient:::.setCache("testEvaluation", evaluation)
  
  eid<-propertyValue(evaluation, "id")
  
  homeWikiPage<-WikiPage(evaluation, title="some title", markdown="placeholder for markdown")
  homeWikiPage<-synStore(homeWikiPage)
  homeWikiId<-propertyValue(homeWikiPage, "id")
  lbWiki<-WikiPage(evaluation, title="leaderboard", parentWikiId=homeWikiId)
  lbWiki<-synStore(lbWiki)
  lbWikiId<-propertyValue(lbWiki, "id")
  
  # retrieve both wiki pages and make sure they're correct
  homeWikiPage2<-synGetWiki(evaluation)
  checkEquals(homeWikiPage2, homeWikiPage)
  # there are two ways to get the root page
  homeWikiPage2<-synGetWiki(evaluation, homeWikiId)
  checkEquals(homeWikiPage2, homeWikiPage)
  lbWiki2<-synGetWiki(evaluation, lbWikiId)
  checkEquals(lbWiki2, lbWiki)
  
  headers<-synGetWikiHeaders(evaluation)
  checkEquals(2, length(headers))
  ids<-list()
  for (header in headers) {
    ids[[length(ids)+1]]<-propertyValue(header, "id")
  }
  checkTrue(any(homeWikiId==ids))
  checkTrue(any(lbWikiId==ids))
  
  evaluation2<-synGetEvaluation(eid)
  checkEquals(evaluation2, evaluation)
  
  # Try getting the evaluation through the content source
  paginatedEvaluations <- synGetEvaluationByContentSource(projectId)
  checkEquals(paginatedEvaluations@results[[1]], evaluation)
  
  propertyValue(evaluation, "status")<-"OPEN"
  evaluation<-synStore(evaluation)
  
  # check that the update worked
  evaluation2<-synGetEvaluation(eid)
  checkEquals(evaluation2, evaluation)
  
  participants<-synGetParticipants(eid)
  checkEquals(0, participants@totalNumberOfResults)
  checkEquals(0, length(participants@results))
  
  # Join the Evaluation
  myOwnId<-propertyValue(synGetUserProfile(), "ownerId")
  AUTHENTICATED_USERS_PRINCIPAL_ID<-273948 # This is defined in org.sagebionetworks.repo.model.AuthorizationConstants
  synapseClient:::.allowParticipation(eid, AUTHENTICATED_USERS_PRINCIPAL_ID)
  synRestPOST(sprintf("/evaluation/%s/participant", eid), list())
  
  participants<-synGetParticipants(eid)
  checkEquals(1, participants@totalNumberOfResults)
  checkEquals(1, length(participants@results))
  
  # make an entity to submit
  submittableEntity<-Folder(name="submitted entity", parentId=projectId)
  submittableEntity<-synStore(submittableEntity)
  
  submissionResult<-submit(evaluation, submittableEntity, silent=TRUE)
  createdSubmission<-submissionResult$submission
  checkEquals(evaluation$submissionReceiptMessage, submissionResult$submissionReceiptMessage)
    
  submissions<-synGetSubmissions(eid, "RECEIVED")
  
  checkEquals(1, submissions@totalNumberOfResults)
  checkEquals(1, length(submissions@results))
  submission<-submissions@results[[1]]
  checkEquals(createdSubmission$id, submission$id)
  entityId<-propertyValue(submission, "entityId")
  # check that all submission fields are correct
  checkEquals(myOwnId, propertyValue(submission, "userId"))
  checkEquals(eid, propertyValue(submission, "evaluationId"))
  checkEquals(entityId, propertyValue(submission, "entityId"))
  checkEquals(1, propertyValue(submission, "versionNumber"))
  checkEquals("submitted entity", propertyValue(submission, "name"))
  
  # check that can retrieve a submission by its id
  submission2<-synGetSubmission(propertyValue(submission, "id"))
  checkEquals(submission2, submission)
  
  status<-synGetSubmissionStatus(propertyValue(submission, "id")) 
  # check content of status
  checkEquals(propertyValue(submission, "id"), propertyValue(status, "id"))
  checkEquals("RECEIVED", propertyValue(status, "status"))
  
  # should also be able to retrieve by the submission object itself
  status2<-synGetSubmissionStatus(submission)
  checkEquals(status2, status)
  
  propertyValue(status, "score")<-0.5
  propertyValue(status, "status")<-"SCORED"
  propertyValue(status, "report")<-"a supplementary report"
  status<-synStore(status)
  # now retrieve status and make sure content is correct
  status<-synGetSubmissionStatus(propertyValue(submission, "id")) 
  # check content of status
  checkEquals(propertyValue(submission, "id"), propertyValue(status, "id"))
  checkEquals("SCORED", propertyValue(status, "status"))
  checkEquals(0.5, propertyValue(status, "score"))
  checkEquals("a supplementary report", propertyValue(status, "report"))
  
  # make a second submission
  submittableEntity2<-Folder(name="submitted entity 2", parentId=projectId)
  submittableEntity2<-synStore(submittableEntity2)
  
  submit(evaluation, submittableEntity2, silent=TRUE)
  
  submissions<-synGetSubmissions(eid, "RECEIVED")
  
  # check that filtering on OPEN works
  checkEquals(1, submissions@totalNumberOfResults)
  checkEquals(1, length(submissions@results))
  
  submissions<-synGetSubmissions(eid)

  checkEquals(2, submissions@totalNumberOfResults)
  checkEquals(2, length(submissions@results))
  
  ownSubmissions<-synGetSubmissions(eid, myOwn=TRUE)
  checkEquals(ownSubmissions, submissions)
  
  lbWikiPage<-synGetWiki(evaluation, lbWikiId)
  propertyValue(lbWikiPage, "markdown")<-"my dog has fleas"
  lbWikiPage<-synStore(lbWikiPage)
  # now retrieve to make sure 'synStore' worked
  lbWikiPage2<-synGetWiki(evaluation, lbWikiId)
  checkEquals(lbWikiPage2, lbWikiPage)
  
  synDelete(evaluation)
  synapseClient:::.setCache("testEvaluation", NULL)
  
  checkException(synGetEvaluation(eid))
}


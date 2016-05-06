\name{synGetEvaluation}
\alias{synGetEvaluation}
\alias{synGetEvaluationByContentSource}
\title{
synGetEvaluation
}
\description{
Function to retrieve an Evaluation object.
}
\usage{
synGetEvaluation(evaluationId)
synGetEvaluationByContentSource(projectId)
}
\details{
synGetEvaluation retrieves an Evaluation object, given its ID.
synGetEvaluationByContentSource retrieves all Evaluations that derive their content from a Project, give its ID.  
}
\examples{
\dontrun{
# get an arbitrary Evaluation ID
anEvaluationId<-synRestGET("/evaluation")$results[[1]]["id"]
# retrieve the evaluation
evaluation<-synGetEvaluation(anEvaluationId)
# check its status
propertyValue(evaluation, "status")
# if I have administrative privileges I can update it
propertyValue(evaluation, "description")<-"some new description"
evaluation<-synStore(evaluation)

# Or if you know a project with an evaluation
# For example, the HPN-DREAM 1A challenge
projectId <- "syn1720047" 
paginatedEvaluations <- synGetEvaluationByContentSource(projectId)
evaluation <- paginatedEvaluations@results[[1]]
}
}
\seealso{
\code{\link{synStore}}
}

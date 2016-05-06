\name{synGetSubmissionStatus}
\alias{synGetSubmissionStatus}
\title{
synGetSubmissionStatus
}
\description{
Get the status of a Submission, given the submission ID.
}
\usage{
synGetSubmissionStatus(submission)
synGetSubmissionStatus(submissionId)
}
\examples{
\dontrun{
# one of "RECEIVED","OPEN","CLOSED","SCORED","INVALID","VALIDATED","EVALUATION_IN_PROGRESS","REJECTED",or "ACCEPTED"
status<-"SCORED"
# get the first 100 submissions in the given evaluation queue having the given status
submissions<-synGetSubmissions(evaluationId, status, limit=100, offset=0) 
# get the ID of an arbitrary Submission
submissionId<-submissions@results[[1]]["id"]
submission<-synGetSubmissionStatus(submissionId)
}
}
\seealso{
\code{\link{synGetSubmissions}}
\code{\link{synGetOwnSubmissions}}
\code{\link{synGetSubmission}}
}

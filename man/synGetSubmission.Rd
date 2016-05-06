\name{synGetSubmission}
\alias{synGetSubmission}
\title{
synGetSubmission
}
\description{
Get a Submission object, given its ID.
}
\usage{
synGetSubmission("123456")
}
\arguments{
 \item{id}{
 The id of the submission to retrieve.
}
 \item{downloadFile}{
 For File submissions only.  If TRUE then the attached file is downloaded to the 'downloadLocation'
}
 \item{downloadLocation}{
 For File submissions only.  The folder in the local file system to which the attached file is to be downloaded. 
 If omitted, then a default location in a cache is used.  See \code{\link{getFileLocation}}
}
 \item{ifcollision}{
 For File submissions only.  if.collision is one of "keep.both", "keep.local", or "overwrite.local", 
telling the system what to do if a different file is found at the given local file location.
}
 \item{load}{
 For File submissions only.  If TRUE then deserialize the downloaded file into memory, using the R 'load' command (See \code{\link{getObject}}, \code{\link{listObjects}})
}
}
\examples{
\dontrun{
# one of "RECEIVED","OPEN","CLOSED","SCORED","INVALID","VALIDATED","EVALUATION_IN_PROGRESS","REJECTED",or "ACCEPTED"
status<-"SCORED"
# get the first 100 submissions in the given evaluation queue having the given status
submissions<-synGetSubmissions(evaluationId, status, limit=100, offset=0) 
# get the ID of an arbitrary Submission
submissionId<-submissions@results[[1]]["id"]
submission<-synGetSubmission(submissionId)
}
}
\seealso{
\code{\link{synGetSubmissions}}
\code{\link{synGetOwnSubmissions}}
\code{\link{synGetSubmissionStatus}}
}

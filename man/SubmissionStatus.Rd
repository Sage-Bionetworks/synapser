\name{SubmissionStatus}
\alias{SubmissionStatus}
\docType{methods}
\title{
Constructor for SubmissionStatus
}
\description{
Constructor for SubmissionStatus
}
\usage{SubmissionStatus()}
\details{
This constructor is not called directly, rather an instance is returned by synGetSubmissionStatus(id), where id is the ID of a Submission.
}

\examples{
\dontrun{
status<-synGetSubmissionStatus("12345")
propertyValue(status, "STATUS")<-"SCORED"
status<-synStore(status)
}
}
\seealso{
\code{\link{synGetSubmissions}}
\code{\link{synGetSubmissionStatus}}
\code{\link{synStore}}
}

\name{synGetSubmissionStatus}
\alias{synGetSubmissionStatus}
\docType{methods}
\title{
synGetSubmissionStatus
}
\description{
Downloads the status of a Submission.
}
\usage{
synGetSubmissionStatus(submission)
}
\arguments{
\item{submission}{ The Submission to lookup}
}
\value{
 A SubmissionStatus object
}
\examples{
\dontrun{
ss<-synGetSubmissionStatus(submissionId)
for (a in ss$annotations["longAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
for (a in ss$annotations["stringAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
for (a in ss$annotations["doubleAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
}
}




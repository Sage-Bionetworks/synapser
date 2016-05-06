\name{synGetOwnSubmissions}
\alias{synGetOwnSubmissions}
\title{
synGetOwnSubmissions
}
\description{
Get the Submissions for a given Evaluation submitted by me.
}
\usage{
synGetOwnSubmissions(evaluationId, limit, offset)
}
\arguments{
\item{evaluationId}{
The evaluation queue containing the submissions of interest.
}
\item{limit}{
The optional limit 'paging' parameter, default is 10.
}
\item{offset}{
The optional offset 'paging' parameter, default is 0.
}
}
\value{
an object of type PaginatedResults.  Note, this function does not download files associated with Submissions. 
For that please see synGetSubmission.
}
\examples{
\dontrun{
# get the first 10 submissions in the given evaluation queue that I submitted.
submissions<-synGetSubmissions(evaluationId, limit=10, offset=0) 
# get an arbitrary Submission from the list
submission<-submissions@results[[1]]
}
}
\seealso{
\code{\link{synGetSubmission}}
\code{\link{synGetSubmissions}}
\code{\link{synGetSubmissionStatus}}
\code{\link{PaginatedResults}}
}

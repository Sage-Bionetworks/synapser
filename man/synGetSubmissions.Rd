\name{synGetSubmissions}
\alias{synGetSubmissions}
\docType{methods}
\title{
synGetSubmissions
}
\description{
    Get submissions from an evaluation
}
\usage{
synGetSubmissions(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
}
\arguments{
\item{evaluation}{ Evaluation to get submissions from.\cr
}
\item{status}{     Optionally filter submissions for a specific status.\cr
                   One of {OPEN, CLOSED, SCORED,INVALID,VALIDATED,\cr
                   EVALUATION_IN_PROGRESS,RECEIVED, REJECTED, ACCEPTED}\cr
}
\item{myOwn}{      Determines if only your Submissions should be fetched.\cr
                   Defaults to FALSE (all Submissions)\cr
}
\item{limit}{      Limits the number of submissions in a single response.\cr
                   Because this method returns a generator and repeatedly\cr
                   fetches submissions, this argument is limiting the\cr
                   size of a single request and NOT the number of sub-\cr
                   missions returned in total.\cr
}
\item{offset}{     Start iterating at a submission offset from the first\cr
                   submission.}
}
\value{
 A generator over Submission objects for an Evaluation.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
submissions<-synGetSubmissions("1234567")
}
}




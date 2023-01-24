\name{synGetSubmissionBundles}
\alias{synGetSubmissionBundles}
\docType{methods}
\title{
synGetSubmissionBundles
}
\description{
Retrieve submission bundles (submission and submissions status) for an evaluation queue, optionally
filtered by submission status and/or owner.
}
\usage{
synGetSubmissionBundles(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
}
\arguments{
\item{evaluation}{ Evaluation to get submissions from.\cr
}
\item{status}{     Optionally filter submissions for a specific status.\cr
                   One of {OPEN, CLOSED, SCORED, INVALID}\cr
}
\item{myOwn}{      Determines if only your Submissions should be fetched.\cr
                   Defaults to FALSE (all Submissions)\cr
}
\item{limit}{      Limits the number of submissions coming back from the\cr
                   service in a single response.\cr
}
\item{offset}{     Start iterating at a submission offset from the first\cr
                   submission.}
}
\value{
 A generator over tuples containing a Submission and a SubmissionStatus.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
bundles<-synGetSubmissionBundles(evaluation)
}
}




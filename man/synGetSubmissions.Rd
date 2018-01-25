\name{synGetSubmissions}
\alias{synGetSubmissions}
\docType{methods}
\title{
synGetSubmissions
}
\description{

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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A generator over Submission objects for an Evaluation.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
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




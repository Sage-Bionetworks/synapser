\name{as.list}
\alias{as.list}
\docType{methods}
\title{
as.list
}
\description{
Gets all the values from an iterator
}
\usage{
as.list(iterator)
}
\arguments{
\item{iterator}{The iterator whose next value is to be retrieved.}
}
\details{
Certain functions return iterators rather than returning a list of all values.  This is because the list may be large and/or expensive
 to generate in its entirety.  The \code{\link{as.list}} function generates all the values from the iterator and returns them as a list.
 It is the responsibility of the caller to determine that the list is not too big to fit in memory or too expensive to generate in its entirety.
  The related function \code{\link{nextElem}} retrieves just one element of the iterator at a time and therefore is safer.
}
\value{
A list of values returned by the iterator.
}
\seealso{
\code{\link{synGetChildren}}
\code{\link{synChunkedQuery}}
\code{\link{synGetEvaluationByContentSource}}
\code{\link{synGetTeamMembers}}
\code{\link{synGetSubmissions}}
\code{\link{synGetSubmissionBundles}}
\code{\link{synGetColumns}}
\code{\link{synGetTableColumns}}
\code{\link{nextElem}}
}
\examples{
\dontrun{
iterator<-synGetTeamMembers(3324324)
members<-as.list(iterator)
}
}


\name{nextElem}
\alias{nextElem}
\docType{methods}
\title{
nextElem
}
\description{
Gets the next value from an iterator.
}
\usage{
nextElem(iterator)
}
\arguments{
\item{iterator}{The iterator whose next value is to be retrieved.}
}
\details{
Certain functions return iterators rather than returning a list of all values.  This is because the list may be large and/or expensive
 to generate in its entirety, while generating just the next value is not expensive.  The \code{\link{nextElem}} function returns just the next value
 or raises an exception if there are no more values to return.  The related function \code{\link{as.list}} will retrieve all the values
 from the iterator and return them as a list.
}
\value{
The next value from the iterator or an exception if there are no more values.
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
\code{\link{as.list}}
}
\examples{
\dontrun{
iterator<-synGetTeamMembers(3324324)
more<-TRUE
while (more) {
  tryCatch(
    {
  		member<-nextElem(iterator)
    		print(member)
    },
    	error=function(e) {
    		print("No more members.")
    		more<<-FALSE
    }
  )
}
}
}




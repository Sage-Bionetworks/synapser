\name{synGetEvaluationByContentSource}
\alias{synGetEvaluationByContentSource}
\docType{methods}
\title{
synGetEvaluationByContentSource
}
\description{
Returns a generator over evaluations that derive their content from the given entity
}
\usage{
synGetEvaluationByContentSource(entity)
}
\arguments{
\item{entity}{  The Project whose Evaluations are to be fetched.}
}
\value{
 a Generator over the Evaluation objects for the given Project.  Use \code{\link{nextElem}} or \code{\link{as.list}} to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
evaluationQueues<-synGetEvaluationByContentSource("syn1234567")
}
}




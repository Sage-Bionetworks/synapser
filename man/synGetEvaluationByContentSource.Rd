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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a Generator over the Evaluation objects for the given Project.  Use \code{\link{nextElem}} or \code{\link{as.list}} to access the values.
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
evaluationQueues<-synGetEvaluationByContentSource("syn1234567")
}
}




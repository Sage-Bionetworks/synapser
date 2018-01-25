\name{synSetAnnotations}
\alias{synSetAnnotations}
\docType{methods}
\title{
synSetAnnotations
}
\description{
Store annotations for an Entity in the Synapse Repository.
}
\usage{
synSetAnnotations(entity, annotations=list(), ...)
}
\arguments{
\item{entity}{      The Entity or Synapse Entity ID whose annotations are to be updated\cr
}
\item{annotations}{ A named list of annotation names and values\cr
}
\item{...}{optional annotation name / value pairs}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 the updated annotations for the entity
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
%
% Verified that the following works on 2018Jan24.
%
\examples{
\dontrun{
synSetAnnotations("syn1234567", annotations=list(foo="bar", baz=1))
}
}




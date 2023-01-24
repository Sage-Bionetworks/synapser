\name{synSetAnnotations}
\alias{synSetAnnotations}
\docType{methods}
\title{
synSetAnnotations
}
\description{
Update annotations for an Entity in the Synapse Repository. This function will replace all the existing annotations with the given annotations.
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
\value{
 the updated annotations for the entity
}
%
% Verified that the following works on 2018Jan24.
%
\examples{
\dontrun{
synSetAnnotations("syn1234567", annotations=list(foo="bar", baz=1))
}
}




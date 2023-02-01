\name{synGetAnnotations}
\alias{synGetAnnotations}
\docType{methods}
\title{
synGetAnnotations
}
\description{
Retrieve annotations for an Entity from the Synapse Repository as a named list.

Note that collapsing annotations from the native Synapse format to a named list
may involve some loss of information. See _getRawAnnotations to get
annotations in the native format.
}
\usage{
synGetAnnotations(entity, version=NULL)
}
\arguments{
\item{entity}{  An Entity or Synapse ID to lookup\cr
}
\item{version}{ The version of the Entity to retrieve.}
}
\value{
 a named list whose names are annotation names and whose values are annotation values
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
file<-synGet("syn11705401")
synSetAnnotations(file, list(a="A", b="B", c=101))
synGetAnnotations(file)
}
}




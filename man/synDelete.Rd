\name{synDelete}
\alias{synDelete}
\docType{methods}
\title{
synDelete
}
\description{
Removes an object from Synapse.
}
\usage{
synDelete(obj, version=NULL)
}
\arguments{
\item{obj}{ An existing object stored on Synapse\cr
            such as Evaluation, File, Project, or Wiki}
\item{version}{ For entities, specify a particular version to delete.}
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
file<-synGet("syn12345")
synDelete(file)
}
}




\name{synDeleteProvenance}
\alias{synDeleteProvenance}
\docType{methods}
\title{
synDeleteProvenance
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use [synapseclient.models.Activity.delete][] instead.

Removes provenance information from an Entity
and deletes the associated Activity.
}
\usage{
synDeleteProvenance(entity)
}
\arguments{
\item{entity}{ An Entity or Synapse ID to modify}
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
synDeleteProvenance("syn11678572")
}
}




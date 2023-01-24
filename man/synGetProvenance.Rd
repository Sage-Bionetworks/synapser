\name{synGetProvenance}
\alias{synGetProvenance}
\docType{methods}
\title{
synGetProvenance
}
\description{
Retrieve provenance information for a Synapse Entity.
}
\usage{
synGetProvenance(entity, version=NULL)
}
\arguments{
\item{entity}{  An Entity or Synapse ID to lookup\cr
}
\item{version}{ The version of the Entity to retrieve.\cr
                Gets the most recent version if omitted}
}
\value{
 An Activity object or
          raises exception if no provenance record exists
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
activity<-synGetProvenance("syn11678572")
}
}




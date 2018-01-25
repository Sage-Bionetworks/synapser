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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 An Activity object or
          raises exception if no provenance record exists
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
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
activity<-synGetProvenance("syn11678572")
}
}




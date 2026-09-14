%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromId}
\alias{synFromId}
\docType{methods}
\title{
Team :  from_id
}
\description{
Gets Team object using its integer id.
}
\usage{
synFromId(cls, id, synapse_client=NULL)
}
\arguments{
\item{cls}{}
\item{id}{(int) The id of the team.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\keyword{Team}

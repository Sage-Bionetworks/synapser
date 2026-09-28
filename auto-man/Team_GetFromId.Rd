%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetFromId}
\alias{Team_synGetFromId}
\docType{methods}
\title{
Team :  from_id
}
\description{
Gets Team object using its integer id.
}
\usage{
synGetFromId(cls, id, synapse_client=NULL)
}
\arguments{
\item{cls}{(Team) The Team class (or an existing Team instance) to dispatch this call to.}
\item{id}{(int) The id of the team.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\keyword{Team}

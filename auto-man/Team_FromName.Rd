%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromName}
\alias{synFromName}
\docType{methods}
\title{
Team :  from_name
}
\description{
Gets Team object using its string name.

*** You will be unable to retrieve a team by name immediately after its
creation because the fragment service is eventually consistent. If you need to
retrieve a team immediately following creation you should use the
[from_id][synapseclient.models.Team.from_id] method. ***
}
\usage{
synFromName(cls, name, synapse_client=NULL)
}
\arguments{
\item{cls}{}
\item{name}{(str) The name of the team.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\keyword{Team}

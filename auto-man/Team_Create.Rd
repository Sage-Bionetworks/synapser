%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreate}
\alias{Team_synCreate}
\docType{methods}
\title{
Team :  create
}
\description{
Creates a new team on Synapse.
}
\usage{
synCreate(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\keyword{Team}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromUsername}
\alias{synFromUsername}
\docType{methods}
\title{
UserProfile :  from_username
}
\description{
Gets UserProfile object using its string name. Wrapper for the
[get][synapseclient.models.UserProfile.get] method.
}
\usage{
synFromUsername(cls, username, synapse_client=NULL)
}
\arguments{
\item{cls}{}
\item{username}{(str) A name chosen by the user that uniquely identifies them.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The UserProfile object.
}
\keyword{UserProfile}

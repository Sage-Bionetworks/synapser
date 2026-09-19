%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromId}
\alias{UserProfile_synFromId}
\docType{methods}
\title{
UserProfile :  from_id
}
\description{
Gets UserProfile object using its integer id. Wrapper for the
[get][synapseclient.models.UserProfile.get] method.
}
\usage{
synFromId(cls, user_id, synapse_client=NULL)
}
\arguments{
\item{cls}{(UserProfile) The UserProfile class (or an existing UserProfile instance) to dispatch this call to.}
\item{user_id}{(int) The id of the user.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The UserProfile object.
}
\keyword{UserProfile}

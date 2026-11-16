%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{UserProfile_synGet}
\docType{methods}
\title{
UserProfile :  get
}
\description{
Gets a UserProfile object using its id or username in that order. If an id
and username is not specified this will retrieve the current user's profile.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(UserProfile) The UserProfile instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The UserProfile object.
}
\keyword{UserProfile}

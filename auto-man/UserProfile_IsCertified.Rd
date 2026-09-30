%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synIsCertified}
\alias{UserProfile_synIsCertified}
\docType{methods}
\title{
UserProfile :  is_certified
}
\description{
Determine whether a user is certified.
}
\usage{
synIsCertified(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(UserProfile) The UserProfile instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
True if the user is certified, False otherwise.
}
\section{Errors}{
ValueError: If id nor username is specified.
}
\keyword{UserProfile}

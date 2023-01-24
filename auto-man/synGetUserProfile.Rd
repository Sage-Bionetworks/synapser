%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetUserProfile}
\alias{synGetUserProfile}
\docType{methods}
\title{
synGetUserProfile
}
\description{
Get the details about a Synapse user.
Retrieves information on the current user if 'id' is omitted.
}
\usage{
synGetUserProfile(id=NULL, sessionToken=NULL, refresh=FALSE)
}
\arguments{
\item{id}{           The 'userId' (aka 'ownerId') of a user or the userName\cr
}
\item{sessionToken}{ The session token to use to find the user profile\cr
}
\item{refresh}{      If set to True will always fetch the data from Synape otherwise will use cached information}
}
\value{
 The user profile for the user of interest.
}



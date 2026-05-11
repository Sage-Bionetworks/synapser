%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetUserProfileById}
\alias{synGetUserProfileById}
\docType{methods}
\title{
synGetUserProfileById
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use [synapseclient.models.UserProfile.from_id][] instead.

Get the details about a Synapse user.
Retrieves information on the current user if 'id' is omitted.

Arguments:
    id:           The ownerId of a user
    sessionToken: The session token to use to find the user profile

Returns:
    The user profile for the user of interest.
}
\usage{
synGetUserProfileById(id=NULL, sessionToken=NULL)
}
\arguments{
\item{id}{}
\item{sessionToken}{}
}
\value{

}



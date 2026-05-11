
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

}
\usage{
synGetUserProfileById(id=NULL, sessionToken=NULL)
}
\arguments{
\item{id}{The ownerId of a user}
\item{sessionToken}{The session token to use to find the user profile}
}
\value{
The user profile for the user of interest.
}



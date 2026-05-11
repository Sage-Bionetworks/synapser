\name{synGetUserProfileByUsername}
\alias{synGetUserProfileByUsername}
\docType{methods}
\title{
synGetUserProfileByUsername
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the [from_username][synapseclient.models.UserProfile.from_username] method on the `from synapseclient.models import UserProfile` class.

Get the details about a Synapse user.
Retrieves information on the current user if 'id' is omitted or is empty string.

}
\usage{
synGetUserProfileByUsername(username=NULL, sessionToken=NULL)
}
\arguments{
\item{username}{The userName of a user}
\item{sessionToken}{The session token to use to find the user profile}
}
\value{
The user profile for the user of interest.  
}



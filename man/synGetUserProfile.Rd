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
synGetUserProfile(id=NULL, sessionToken=NULL, refresh=NULL)
}
\arguments{
\item{id}{optional named parameter:            The 'userId' (aka 'ownerId') of a user or the userName\cr
}
\item{sessionToken}{optional named parameter:  The session token to use to find the user profile\cr
}
\item{refresh}{optional named parameter:   If set to TRUE will always fetch the data from Synape otherwise\cr
                 will use cached information}
}
\value{
 The user profile for the user of interest.
}
\examples{
\dontrun{
my_profile <- synGetUserProfile()
freds_profile <- synGetUserProfile('fredcommo')
}
}




\name{synGetFromUsername}
\alias{UserProfile_synGetFromUsername}
\docType{methods}
\title{
UserProfile :  from_username
}
\description{
Gets UserProfile object using its string name.
}
\usage{
synGetFromUsername(cls, username, synapse_client=NULL)
}
\arguments{
\item{cls}{(UserProfile) The UserProfile class (or an existing UserProfile instance) to dispatch this call to.}
\item{username}{(str) A name chosen by the user that uniquely identifies them.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The UserProfile object.
}
\examples{
\dontrun{
## Using this function
    # Assuming you know the username of a Synapse user:
    user_profile = UserProfile |> synGetFromUsername(username = "myUsername")
}
}
\keyword{UserProfile}

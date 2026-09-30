\name{synGetFromId}
\alias{UserProfile_synGetFromId}
\docType{methods}
\title{
UserProfile :  from_id
}
\description{
Gets UserProfile object using its integer id. 
}
\usage{
synGetFromId(cls, user_id, synapse_client=NULL)
}
\arguments{
\item{cls}{(UserProfile) The UserProfile class (or an existing UserProfile instance) to dispatch this call to.}
\item{user_id}{(int) The id of the user.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The UserProfile object.
}
\examples{
\dontrun{
## Using this function
    # Assuming you know the integer ID of a Synapse user:
    user_profile = UserProfile |> synGetFromId(user_id = 273948L)
}
}
\keyword{UserProfile}

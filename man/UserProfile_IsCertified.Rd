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
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
TRUE if the user is certified, FALSE otherwise.
}
\section{Errors}{
An error is raised if neither id nor username is specified.
}
\examples{
\dontrun{
## Using this function
    # Check whether a user is certified
    is_certified = UserProfile(username = "myUsername") |> synIsCertified()
}
}
\keyword{UserProfile}

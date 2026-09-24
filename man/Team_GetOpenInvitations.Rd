\name{synGetOpenInvitations}
\alias{Team_synGetOpenInvitations}
\docType{methods}
\title{
Team :  open_invitations
}
\description{
Gets all open invitations for a team given the ID field on the Team instance.
}
\usage{
synGetOpenInvitations(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
List[dict]: A list of invitations.
}
\examples{
\dontrun{
## List the open invitations for a team
    library(synapser)
    synLogin()

    team = Team() |> synFromId(id = 123456L)
    open_invitations = team |> synGetOpenInvitations()
}
}
\keyword{Team}

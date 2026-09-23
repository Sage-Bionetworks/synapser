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
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of named lists, each representing a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/MembershipInvitation.html}{MembershipInvitation}.
}
\examples{
\dontrun{
## List the open invitations for a team
    library(synapser)
    synLogin()

    team = Team |> synFromId(id = 123456L)
    open_invitations = team |> synGetOpenInvitations()
}
}
\keyword{Team}

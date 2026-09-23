\name{synDeleteInvitation}
\alias{Team_synDeleteInvitation}
\docType{methods}
\title{
Team :  delete_invitation
}
\description{
Deletes an open invitation to a team.
}
\usage{
synDeleteInvitation(invitation_id, synapse_client=NULL)
}
\arguments{
\item{invitation_id}{(str) The ID of the invitation to delete. This can be found on the invitations returned by \code{\link[=Team_synGetOpenInvitations]{synGetOpenInvitations}()}.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\note{
The client must be an administrator of the Team referenced by the invitation, or the invitee, to make this request.
}
\examples{
\dontrun{
## Delete an open invitation to a team
    library(synapser)
    synLogin()

    team = Team |> synFromId(id = 123456L)
    open_invitations = team |> synGetOpenInvitations()

    # Delete the first open invitation
    synDeleteInvitation(invitation_id = open_invitations[[1]]$id)
}
}
\keyword{Team}

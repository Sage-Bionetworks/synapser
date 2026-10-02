\name{synDeleteInvitation}
\alias{Team_synDeleteInvitation}
\docType{methods}
\title{
Team :  delete_invitation
}
\description{
Deletes an open invitation to a team. Note: The client must be an
administrator of the Team referenced by the invitation, or the invitee,
to make this request.
}
\usage{
synDeleteInvitation(invitation_id, synapse_client=NULL)
}
\arguments{
\item{invitation_id}{(character) The ID of the invitation to delete. This can be found on the invitations returned by \code{\link[=Team_synGetOpenInvitations]{synGetOpenInvitations}()}.}
\item{synapse_client}{(Optional[Synapse]) If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Delete an open invitation to a team
    # Cancel a pending invitation to a team.
    library(synapser)
    synLogin()

    team = Team() |> synGetFromId(id = 123456L)
    open_invitations = team |> synGetOpenInvitations()
    if (length(open_invitations) == 0) {
        print("No open invitations to delete.")
    } else {
        # Delete the first open invitation
        synDeleteInvitation(invitation_id = open_invitations[[1]][["id"]])
    }
}
}
\keyword{Team}

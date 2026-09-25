%
%  NOT auto-generated: delete_invitation / delete_invitation_async do not exist yet in the
%  pinned synapseclient version (PYTHON_CLIENT_VERSION = '4.12' in R/shared.R). Hand-drafted
%  from the delete_invitation_async docstring in Sage-Bionetworks/synapsePythonClient PR #1457
%  (open, unmerged as of 2026-09-24): https://github.com/Sage-Bionetworks/synapsePythonClient/pull/1457
%  Once that PR merges and PYTHON_CLIENT_VERSION is bumped past its release, regenerate for
%  real via tools/createRdFiles.R (R CMD INSTALL .) and reconcile this draft -- and
%  man/Team_DeleteInvitation.Rd -- against the actual generator output.
%
\name{synDeleteInvitation}
\alias{Team_synDeleteInvitation}
\docType{methods}
\title{
Team :  delete_invitation
}
\description{
Deletes an open invitation to a team. Note: The client must be an administrator of the Team referenced by the invitation, or the invitee, to make this request.
}
\usage{
synDeleteInvitation(invitation_id, synapse_client=NULL)
}
\arguments{
\item{invitation_id}{(str) The ID of the invitation to delete. This can be found on the invitations returned by [open_invitations][synapseclient.models.Team.open_invitations].}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None
}
\examples{
\dontrun{
## Delete an open invitation to a team
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def delete_open_invitation():
        team = await Team.from_id_async(id=123456)
        open_invitations = await team.open_invitations_async()

        # Delete the first open invitation
        await Team.delete_invitation_async(
            invitation_id=open_invitations[0]["id"]
        )

    asyncio.run(delete_open_invitation())
}
}
\keyword{Team}

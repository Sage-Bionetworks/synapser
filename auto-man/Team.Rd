%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Team}
\alias{Team}
\docType{class}
\title{
Team
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Team.html}{Synapse Team}.
User definable fields are:
}
\usage{
Team(id=NULL, name=NULL, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL)
}
\arguments{
\item{id}{(Optional[int]) The ID of the team}
\item{name}{(Optional[str]) The name of the team}
\item{description}{(Optional[str]) A short description of the team}
\item{icon}{(Optional[str]) A file handle ID for the icon image of the team}
\item{can_public_join}{(Optional[bool]) True if members can join without an invitation or approval}
\item{can_request_membership}{(Optional[bool]) True if users can create a membership request to join}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this team was created}
\item{modified_on}{(Optional[str]) The date this team was last modified}
\item{created_by}{(Optional[str]) The ID of the user that created this team}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this team}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a new team
    # Create a new team on Synapse by storing a Team object with a name.
    from synapseclient.models import Team
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    team = Team(
        name="My Uniquely Named Team",
        description="A team for my project collaborators",
    )
    created_team = team.create()

## Example 2: Get a team by ID or name
    # Retrieve an existing team using either its ID or its name.
    from synapseclient.models import Team
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    team_by_id = Team.from_id(id=123456)
    team_by_name = Team.from_name(name="My Uniquely Named Team")

## Example 3: List the members of a team and invite a new one
    # List current team members and send an invitation to a new user.
    from synapseclient.models import Team
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    team = Team.from_id(id=123456)
    for member in team.members():
        print(member.member.user_name)

    team.invite(user="my_username", message="Please join my team!")

## Example 4: Delete a team
    # Delete a team you no longer need.
    from synapseclient.models import Team
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    team = Team.from_id(id=123456)
    team.delete()
}
}
\section{Methods}{
\itemize{
\item \code{Team(id=NULL, name=NULL, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL)}: Constructor for \code{\link{Team}}
\item \code{synCreate(instance, synapse_client=NULL)}: Creates a new team on Synapse.
\item \code{synDeleteInvitation(invitation_id, synapse_client=NULL)}: Deletes an open invitation to a team. Note: The client must be an\cr
administrator of the Team referenced by the invitation, or the invitee,\cr
to make this request.
\item \code{synGetFromId(cls, id, synapse_client=NULL)}: Gets Team object using its integer id.
\item \code{synGetFromName(cls, name, synapse_client=NULL)}: Gets Team object using its string name.\cr
\cr
*** You will be unable to retrieve a team by name immediately after its\cr
creation because the fragment service is eventually consistent. If you need to\cr
retrieve a team immediately following creation you should use the\cr
[from_id][synapseclient.models.Team.from_id] method. ***
\item \code{synGetUserMembershipStatus(instance, user_id, synapse_client=NULL)}: Retrieve a user's Team Membership Status bundle for this team.
\item \code{synInviteToTeam(instance, user, message, force=TRUE, synapse_client=NULL)}: Invites a user to a team given the ID field on the Team instance.
\item \code{synGetTeamMembers(instance, synapse_client=NULL)}: Gets the TeamMembers associated with a team given the ID field on the\cr
Team instance.
\item \code{synGetOpenInvitations(instance, synapse_client=NULL)}: Gets all open invitations for a team given the ID field on the Team instance.
}
}


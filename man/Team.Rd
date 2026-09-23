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
\item{can_public_join}{(Optional[bool]) TRUE if members can join without an invitation or approval}
\item{can_request_membership}{(Optional[bool]) TRUE if users can create a membership request to join}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
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
    library(synapser)
    synLogin()

    team = Team(
        name = "My Uniquely Named Team",
        description = "A team for my project collaborators"
    )
    created_team = team |> synCreate()

## Example 2: Get a team by ID or name
    library(synapser)
    synLogin()

    team_by_id = Team |> synFromId(id = 123456L)
    team_by_name = Team |> synFromName(name = "My Uniquely Named Team")

## Example 3: List the members of a team and invite a new one
    library(synapser)
    synLogin()

    team = Team |> synFromId(id = 123456L)
    members = team |> synGetTeamMembers()
    for (member in members) {
        print(member$member$user_name)
    }

    team |> synInviteToTeam(user = "my_username", message = "Please join my team!")

## Example 4: Delete a team
    library(synapser)
    synLogin()

    team = Team |> synFromId(id = 123456L)
    team |> synDelete()
}
}
\section{Methods}{
\itemize{
\item \code{Team(id=NULL, name=NULL, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL)}: Constructor for \code{\link{Team}}
\item \code{\link[=Team_synCreate]{synCreate}(instance, synapse_client=NULL)}: Creates a new team on Synapse.
\item \code{\link[=Team_synDeleteInvitation]{synDeleteInvitation}(invitation_id, synapse_client=NULL)}: Deletes an open invitation to a team.
\item \code{\link[=Team_synFromId]{synFromId}(cls, id, synapse_client=NULL)}: Gets a Team object using its integer id.
\item \code{\link[=Team_synFromName]{synFromName}(cls, name, synapse_client=NULL)}: Gets a Team object using its string name.

\strong{You will be unable to retrieve a team by name immediately after its creation because the fragment service is eventually consistent.} If you need to retrieve a team immediately following creation you should use the \code{\link[=Team_synFromId]{synFromId}()} function instead.
\item \code{\link[=Team_synGetUserMembershipStatus]{synGetUserMembershipStatus}(instance, user_id, synapse_client=NULL)}: Retrieve a user's Team Membership Status bundle for this team.
\item \code{\link[=Team_synInviteToTeam]{synInviteToTeam}(instance, user, message, force=TRUE, synapse_client=NULL)}: Invites a user to a team given the ID field on the Team instance.
\item \code{\link[=Team_synGetTeamMembers]{synGetTeamMembers}(instance, synapse_client=NULL)}: Gets the TeamMembers associated with a team given the ID field on the Team instance.
\item \code{\link[=Team_synGetOpenInvitations]{synGetOpenInvitations}(instance, synapse_client=NULL)}: Gets all open invitations for a team given the ID field on the Team instance.
}
}

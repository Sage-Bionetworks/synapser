%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetTeamMembers}
\alias{Team_synGetTeamMembers}
\docType{methods}
\title{
Team :  members
}
\description{
Gets the TeamMembers associated with a team given the ID field on the
Team instance.
}
\usage{
synGetTeamMembers(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
List[TeamMember]: A List of TeamMember objects.
}
\examples{
\dontrun{
## List the members of a team
    # List the current members of a team.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def list_team_members():
        team = await Team.from_id_async(id=123456)
        members = await team.members_async()
        for member in members:
            print(f"{member.member.user_name} (admin: {member.is_admin})")
        return members

    team_members = asyncio.run(list_team_members())
}
}
\keyword{Team}

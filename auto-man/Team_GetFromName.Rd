%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetFromName}
\alias{Team_synGetFromName}
\docType{methods}
\title{
Team :  from_name
}
\description{
Gets Team object using its string name.

*** You will be unable to retrieve a team by name immediately after its
creation because the fragment service is eventually consistent. If you need to
retrieve a team immediately following creation you should use the
[from_id][synapseclient.models.Team.from_id] method. ***
}
\usage{
synGetFromName(cls, name, synapse_client=NULL)
}
\arguments{
\item{cls}{(Team) The Team class (or an existing Team instance) to dispatch this call to.}
\item{name}{(str) The name of the team.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\examples{
\dontrun{
## Get a team by its name
    # Retrieve an existing team using its name.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def get_team_by_name():
        team = await Team.from_name_async(name="My Uniquely Named Team")
        return team

    my_team = asyncio.run(get_team_by_name())
}
}
\keyword{Team}

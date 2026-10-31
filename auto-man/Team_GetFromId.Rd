%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetFromId}
\alias{Team_synGetFromId}
\docType{methods}
\title{
Team :  from_id
}
\description{
Gets Team object using its integer id.
}
\usage{
synGetFromId(cls, id, synapse_client=NULL)
}
\arguments{
\item{cls}{(Team) The Team class (or an existing Team instance) to dispatch this call to.}
\item{id}{(int) The id of the team.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\examples{
\dontrun{
## Get a team by its ID
    # Retrieve an existing team using its ID.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def get_team_by_id():
        team = await Team.from_id_async(id=123456)
        return team

    my_team = asyncio.run(get_team_by_id())
}
}
\keyword{Team}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Team_synGet}
\docType{methods}
\title{
Team :  get
}
\description{
Gets a Team from Synapse by ID or Name. If both are added to the Team instance
it will use the ID.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Team: The Team object.
}
\section{Errors}{
ValueError: If the Team object has neither an id nor a name.
}
\examples{
\dontrun{
## Example 1: Get a team by ID
    # Retrieve an existing team using its ID.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def get_team():
        team = await Team(id=123456).get_async()
        return team

    my_team = asyncio.run(get_team())

## Example 2: Get a team by name
    # Retrieve an existing team using its name.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Team

    syn = Synapse()
    syn.login()

    async def get_team():
        team = await Team(name="My Uniquely Named Team").get_async()
        return team

    my_team = asyncio.run(get_team())
}
}
\keyword{Team}

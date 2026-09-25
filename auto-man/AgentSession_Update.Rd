%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpdate}
\alias{AgentSession_synUpdate}
\docType{methods}
\title{
AgentSession :  update
}
\description{
Updates an agent session.
Only updates to the access level are currently supported.
}
\usage{
synUpdate(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The updated AgentSession object.
}
\examples{
\dontrun{
## Update the access level of an existing session.
    Retrieve an existing session by providing the session ID and calling \code{get()}.
    Then, update the access level of the session and call \code{update()}.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession, AgentSessionAccessLevel

        syn = Synapse()
        syn.login()

        async def main():
            my_session = await AgentSession(id="foo").get_async()
            my_session.access_level = AgentSessionAccessLevel.READ_YOUR_PRIVATE_DATA
            await my_session.update_async()

        asyncio.run(main())
}
}
\keyword{AgentSession}

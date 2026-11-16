%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{AgentSession_synGet}
\docType{methods}
\title{
AgentSession :  get
}
\description{
Gets an agent session.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The retrieved AgentSession object.
}
\examples{
\dontrun{
## Get an existing session and send a prompt.
    Retrieve an existing session by providing the session ID and calling \code{get()}.
    Then, send a prompt to the agent.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession

        syn = Synapse()
        syn.login()

        async def main():
            my_session = await AgentSession(id="foo").get_async()
            await my_session.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{AgentSession}

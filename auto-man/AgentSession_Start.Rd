%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStart}
\alias{AgentSession_synStart}
\docType{methods}
\title{
AgentSession :  start
}
\description{
Starts an agent session.
}
\usage{
synStart(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The new AgentSession object.
}
\examples{
\dontrun{
## Start a session and send a prompt.
    Start a session with a custom agent by providing the agent's registration ID and calling \code{start()}.
    Then, send a prompt to the agent.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession

        syn = Synapse()
        syn.login()

        async def main():
            my_session = await AgentSession(agent_registration_id="foo").start_async()
            await my_session.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{AgentSession}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSession}
\alias{synGetSession}
\docType{methods}
\title{
Agent :  get_session
}
\description{
Gets an existing agent session.
Adds the session to the Agent's sessions dictionary and
sets it as the current session.
}
\usage{
synGetSession(instance, session_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{session_id}{(str) The ID of the session to get.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The existing AgentSession object.
}
\examples{
\dontrun{
## Get an existing session and send a prompt.
    Retrieve an existing session by providing the session ID and calling \code{get()}.
    Then, send a prompt to the agent.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_session = await Agent().get_session_async(session_id="foo")
            await my_session.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{Agent}

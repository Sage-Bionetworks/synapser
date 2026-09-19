%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStartSession}
\alias{Agent_synStartSession}
\docType{methods}
\title{
Agent :  start_session
}
\description{
Starts an agent session.
Adds the session to the Agent's sessions dictionary and sets it as the current session.
}
\usage{
synStartSession(instance, access_level="PUBLICLY_ACCESSIBLE", synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{access_level}{(Optional[AgentSessionAccessLevel]) The access level of the agent session. Must be one of PUBLICLY_ACCESSIBLE, READ_YOUR_PRIVATE_DATA, or WRITE_YOUR_PRIVATE_DATA. Defaults to PUBLICLY_ACCESSIBLE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The new AgentSession object.
}
\examples{
\dontrun{
## Example 1: Start a session and send a prompt with the baseline Synapse Agent.
    The baseline Synapse Agent is the default agent used when a registration ID is not provided.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent()
            await my_agent.start_session_async()
            await my_agent.prompt_async(
                prompt="Can you tell me about the AD Knowledge Portal dataset?",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())

## Example 2: Start a session and send a prompt with a custom agent.
    The baseline Synapse Agent is the default agent used when a registration ID is not provided.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent(cloud_agent_id="foo")
            await my_agent.start_session_async()
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{Agent}

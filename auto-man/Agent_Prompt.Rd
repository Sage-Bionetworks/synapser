%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synPrompt}
\alias{synPrompt}
\docType{methods}
\title{
Agent :  prompt
}
\description{
Sends a prompt to the agent for the current session.
    If no session is currently active, a new session will be started.
}
\usage{
synPrompt(instance, prompt, enable_trace=FALSE, print_response=FALSE, session=NULL, newer_than=NULL, timeout=120L, synapse_client=NULL, session_id=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{prompt}{(str) The prompt to send to the agent.}
\item{enable_trace}{(bool) Whether to enable trace for the prompt.}
\item{print_response}{(bool) Whether to print the response to the console.}
\item{session}{}
\item{newer_than}{(Optional[int]) The timestamp to get trace results newer than. Defaults to None (all results).}
\item{timeout}{(int) The number of seconds to wait for the job to complete or progress before raising a SynapseTimeoutError. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
\item{session_id}{optional named parameter: The ID of the session to send the prompt to. If None, the current session will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Prompt the baseline Synapse Agent.
    The baseline Synapse Agent is equivilent to the Agent available in the Synapse UI.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent()
            await my_agent.prompt_async(
                prompt="Can you tell me about the AD Knowledge Portal dataset?",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())

## Example 2: Prompt a custom agent.
    If you have already registered a custom agent, you can prompt it by providing the agent's registration ID.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent(registration_id="foo")
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())

Advanced Example: Start and prompt multiple sessions
    Here, we connect to a custom agent and start one session with the prompt "Hello".
    In the background, this first session is being set as the current session
    and future prompts will be sent to this session by default. If we want to send a
    prompt to a different session, we can do so by starting it and calling prompt again,
    but with our new session as an argument. We now have two sessions, both stored in the
    \code{my_agent.sessions} dictionary. After the second prompt, \code{my_second_session} is now
    the current session.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent(registration_id="foo").get()
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

            my_second_session = await my_agent.start_session_async()
            await my_agent.prompt_async(
                prompt="Hello again",
                enable_trace=True,
                print_response=True,
                session=my_second_session,
            )

        asyncio.run(main())
}
}
\keyword{Agent}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synPrompt}
\alias{synPrompt}
\docType{methods}
\title{
AgentSession :  prompt
}
\description{
Sends a prompt to the agent and adds the response to the AgentSession's
chat history. A session must be started before sending a prompt.
}
\usage{
synPrompt(instance, prompt, enable_trace=FALSE, print_response=FALSE, newer_than=NULL, timeout=120L, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{prompt}{(str) The prompt to send to the agent.}
\item{enable_trace}{(bool) Whether to enable trace for the prompt.}
\item{print_response}{(bool) Whether to print the response to the console.}
\item{newer_than}{(Optional[int]) The timestamp to get trace results newer than. Defaults to None (all results).}
\item{timeout}{(int) The number of seconds to wait for the job to complete or progress before raising a SynapseTimeoutError. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\examples{
\dontrun{
## Send a prompt within an existing session.
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

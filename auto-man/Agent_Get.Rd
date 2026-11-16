%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Agent_synGet}
\docType{methods}
\title{
Agent :  get
}
\description{
Gets an existing custom agent. There is no need to use this method
if you are trying to use the baseline agent.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The existing Agent object.
}
\examples{
\dontrun{
## Get and chat with an existing agent
    Retrieve an existing custom agent by providing the agent's registration ID and calling \code{get_async()}.
    Then, send a prompt to the agent.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Agent, AgentSessionAccessLevel

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = await Agent(registration_id="foo").get_async()
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{Agent}

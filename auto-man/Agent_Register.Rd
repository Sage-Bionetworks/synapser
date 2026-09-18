%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRegister}
\alias{synRegister}
\docType{methods}
\title{
Agent :  register
}
\description{
Registers an agent with the Synapse API.
If agent already exists, it will be retrieved.
}
\usage{
synRegister(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The registered or existing Agent object.
}
\examples{
\dontrun{
## Register and chat with a custom agent
    **Only available for internal users (Sage Bionetworks employees)**

    Alternatively, you can register a custom agent and chat with it provided
    you have already created it.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent(cloud_agent_id="foo")
            await my_agent.register_async()
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )

        asyncio.run(main())
}
}
\keyword{Agent}

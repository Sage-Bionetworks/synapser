%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetChatHistory}
\alias{synGetChatHistory}
\docType{methods}
\title{
Agent :  get_chat_history
}
\description{
Gets the chat history for the current session.
}
\usage{
synGetChatHistory(instance)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
}
\value{
NULL
}
\examples{
\dontrun{
## Get the chat history for the current session.
    First, send a prompt to the agent.
    Then, retrieve the chat history for the current session by calling \code{get_chat_history()}.

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        async def main():
            my_agent = Agent()
            await my_agent.prompt_async(
                prompt="Hello",
                enable_trace=True,
                print_response=True,
            )
            print(my_agent.get_chat_history())

        asyncio.run(main())
}
}
\keyword{Agent}

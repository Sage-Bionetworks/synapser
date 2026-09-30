\name{synGetChatHistory}
\alias{Agent_synGetChatHistory}
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
    # First, send a prompt to the agent.
    # Then, retrieve the chat history for the current session by calling synGetChatHistory().
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
    print(my_agent |> synGetChatHistory())
}
}
\keyword{Agent}

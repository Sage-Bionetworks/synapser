\name{AgentPrompt}
\alias{AgentPrompt}
\docType{class}
\title{
AgentPrompt
}
\format{An S3-style class object.}
\description{
Represents a prompt, response, and metadata within an AgentSession.
}
\usage{
AgentPrompt(concrete_type="org.sagebionetworks.repo.model.agent.AgentChatRequest", id=NULL, session_id=NULL, prompt=NULL, response=NULL, enable_trace=FALSE, trace=NULL)
}
\arguments{
\item{concrete_type}{(str) Indicates the type of request this represents to the Synapse REST API. Should not typically need to be changed from its default value.}
\item{id}{(Optional[str]) The unique ID of the agent prompt.}
\item{session_id}{(Optional[str]) The ID of the session that the prompt is associated with.}
\item{prompt}{(Optional[str]) The prompt to send to the agent.}
\item{response}{(Optional[str]) The response from the agent.}
\item{enable_trace}{(Optional[bool]) Whether tracing is enabled for the prompt.}
\item{trace}{(Optional[str]) The trace of the agent session.}
}
\value{
NULL
}
\examples{
\dontrun{
## Inspecting the prompts in a session
    # AgentPrompt objects are created for you when you prompt an agent. They make up
    # the chat history of an AgentSession.
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synPrompt(prompt = "Hello", print_response = FALSE)

    for (agent_prompt in my_agent |> synGetChatHistory()) {
        print(agent_prompt$prompt)
        print(agent_prompt$response)
    }
}
}
\section{Methods}{
\itemize{
\item \code{AgentPrompt(concrete_type="org.sagebionetworks.repo.model.agent.AgentChatRequest", id=NULL, session_id=NULL, prompt=NULL, response=NULL, enable_trace=FALSE, trace=NULL)}: Constructor for \code{\link{AgentPrompt}}
}
}

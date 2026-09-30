\name{synPrompt}
\alias{AgentSession_synPrompt}
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
\item{newer_than}{(Optional[int]) The timestamp to get trace results newer than. Defaults to NULL (all results).}
\item{timeout}{(int) The number of seconds to wait for the job to complete or progress before raising a SynapseTimeoutError. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Send a prompt within an existing session.
    # If you already have an existing session, you can send it a prompt by
    # constructing an AgentSession with its session ID.
    library(synapser)
    synLogin()

    my_session = AgentSession(id = "foo")
    my_session |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
}
}
\keyword{AgentSession}

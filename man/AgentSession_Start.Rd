\name{synStart}
\alias{AgentSession_synStart}
\docType{methods}
\title{
AgentSession :  start
}
\description{
Starts an agent session.
}
\usage{
synStart(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The new AgentSession object.
}
\examples{
\dontrun{
## Start a session and send a prompt.
    # Start a session with a custom agent by providing the agent's registration ID
    # and calling synStart(). Then, send a prompt to the agent.
    library(synapser)
    synLogin()

    my_session = AgentSession(agent_registration_id = "foo") |> synStart()
    my_session |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
}
}
\keyword{AgentSession}

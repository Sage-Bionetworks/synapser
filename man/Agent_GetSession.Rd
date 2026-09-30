\name{synGetSession}
\alias{Agent_synGetSession}
\docType{methods}
\title{
Agent :  get_session
}
\description{
Gets an existing agent session.
Adds the session to the Agent's sessions named list and
sets it as the current session.
}
\usage{
synGetSession(instance, session_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{session_id}{(str) The ID of the session to get.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The existing AgentSession object.
}
\examples{
\dontrun{
## Get an existing session and send a prompt.
    # Retrieve an existing session by providing the session ID and calling synGetSession().
    # Then, send a prompt to the agent.
    library(synapser)
    synLogin()

    my_session = Agent() |> synGetSession(session_id = "foo")
    my_session |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
}
}
\keyword{Agent}

\name{synStartSession}
\alias{Agent_synStartSession}
\docType{methods}
\title{
Agent :  start_session
}
\description{
Starts an agent session.
Adds the session to the Agent's sessions named list and sets it as the current session.
}
\usage{
synStartSession(instance, access_level="PUBLICLY_ACCESSIBLE", synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{access_level}{(Optional[AgentSessionAccessLevel]) The access level of the agent session. Must be one of PUBLICLY_ACCESSIBLE, READ_YOUR_PRIVATE_DATA, or WRITE_YOUR_PRIVATE_DATA. Defaults to PUBLICLY_ACCESSIBLE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The new AgentSession object.
}
\examples{
\dontrun{
## Example 1: Start a session and send a prompt with the baseline Synapse Agent.
    # The baseline Synapse Agent is the default agent used when a registration ID is not provided.
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synStartSession()
    my_agent |> synPrompt(
        prompt = "Can you tell me about the AD Knowledge Portal dataset?",
        enable_trace = TRUE,
        print_response = TRUE
    )

## Example 2: Start a session and send a prompt with a custom agent.
    # If you have already registered a custom agent, you can start a session
    # with it by providing its cloud agent ID.
    library(synapser)
    synLogin()

    my_agent = Agent(cloud_agent_id = "foo")
    my_agent |> synStartSession()
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
}
}
\keyword{Agent}

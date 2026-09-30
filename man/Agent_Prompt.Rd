\name{synPrompt}
\alias{Agent_synPrompt}
\docType{methods}
\title{
Agent :  prompt
}
\description{
Sends a prompt to the agent for the current session.
    If no session is currently active, a new session will be started.
}
\usage{
synPrompt(instance, prompt, enable_trace=FALSE, print_response=FALSE, session=NULL, newer_than=NULL, timeout=120L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{prompt}{(str) The prompt to send to the agent.}
\item{enable_trace}{(bool) Whether to enable trace for the prompt.}
\item{print_response}{(bool) Whether to print the response to the console.}
\item{session}{(Optional[AgentSession]) The session to send the prompt to. If not provided, the current session will be used.}
\item{newer_than}{(Optional[int]) The timestamp to get trace results newer than. Defaults to NULL (all results).}
\item{timeout}{(int) The number of seconds to wait for the job to complete or progress before raising a SynapseTimeoutError. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Prompt the baseline Synapse Agent.
    # The baseline Synapse Agent is equivalent to the Agent available in the Synapse UI.
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synPrompt(
        prompt = "Can you tell me about the AD Knowledge Portal dataset?",
        enable_trace = TRUE,
        print_response = TRUE
    )

## Example 2: Prompt a custom agent.
    # If you have already registered a custom agent, you can prompt it by
    # providing the agent's registration ID.
    library(synapser)
    synLogin()

    my_agent = Agent(registration_id = "foo")
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )

## Advanced Example: Start and prompt multiple sessions
    # Here, we connect to a custom agent and start one session with the prompt "Hello".
    # In the background, this first session is being set as the current session
    # and future prompts will be sent to this session by default. If we want to send a
    # prompt to a different session, we can do so by starting it and calling synPrompt again,
    # but with our new session as an argument. We now have two sessions, both stored in the
    # my_agent$sessions named list. After the second prompt, my_second_session is now
    # the current session.
    library(synapser)
    synLogin()

    my_agent = Agent(registration_id = "foo")

    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )

    my_second_session = my_agent |> synStartSession()
    my_agent |> synPrompt(
        prompt = "Hello again",
        enable_trace = TRUE,
        print_response = TRUE,
        session = my_second_session
    )
}
}
\keyword{Agent}

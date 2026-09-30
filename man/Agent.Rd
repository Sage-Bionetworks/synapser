\name{Agent}
\alias{Agent}
\docType{class}
\title{
Agent
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/agent/AgentRegistration.html}{Synapse Agent Registration}
}
\usage{
Agent(cloud_agent_id=NULL, cloud_alias_id=NULL, registration_id=NULL, registered_on=NULL, type=NULL, sessions=list(), current_session=NULL)
}
\arguments{
\item{cloud_agent_id}{(Optional[str]) The unique ID of the agent in the cloud provider.}
\item{cloud_alias_id}{(Optional[str]) The alias ID of the agent in the cloud provider. Defaults to 'TSTALIASID' in the Synapse API.}
\item{registration_id}{(Optional[int]) The ID number of the agent assigned by Synapse.}
\item{registered_on}{(Optional[datetime]) The date the agent was registered.}
\item{type}{(Optional[AgentType]) The type of agent. One of either BASELINE or CUSTOM.}
\item{sessions}{(dict[str, AgentSession]) A named list of AgentSession objects, keyed by session ID.}
\item{current_session}{(Optional[AgentSession]) The current session. Prompts will be sent to this session by default.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Chat with the baseline Synapse Agent
    # You can chat with the same agent which is available in the Synapse UI
    # at https://www.synapse.org/Chat:default. By default, this "baseline" agent
    # is used when a registration ID is not provided. In the background,
    # the Agent class will start a session and set that new session as the
    # current session if one is not already set.
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synPrompt(
        prompt = "Can you tell me about the AD Knowledge Portal dataset?",
        enable_trace = TRUE,
        print_response = TRUE
    )

## Example 2: Register and chat with a custom agent
    # Only available for internal users (Sage Bionetworks employees).
    #
    # Alternatively, you can register a custom agent and chat with it provided
    # you have already created it.
    library(synapser)
    synLogin()

    my_agent = Agent(cloud_agent_id = "foo") |> synRegister()
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )

## Example 3: Prompt an existing custom agent
    # If you have already registered a custom agent, you can chat with it by
    # constructing an Agent with its registration ID and sending it a prompt.
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
\section{Methods}{
\itemize{
\item \code{Agent(cloud_agent_id=NULL, cloud_alias_id=NULL, registration_id=NULL, registered_on=NULL, type=NULL, sessions=list(), current_session=NULL)}: Constructor for \code{\link{Agent}}
\item \code{\link[=Agent_synGetChatHistory]{synGetChatHistory}(instance)}: Gets the chat history for the current session.
\item \code{\link[=Agent_synGetSession]{synGetSession}(instance, session_id, synapse_client=NULL)}: Gets an existing agent session. Adds the session to the Agent's sessions named list and sets it as the current session.
\item \code{\link[=Agent_synPrompt]{synPrompt}(instance, prompt, enable_trace=FALSE, print_response=FALSE, session=NULL, newer_than=NULL, timeout=120L, synapse_client=NULL)}: Sends a prompt to the agent for the current session. If no session is currently active, a new session will be started.
\item \code{\link[=Agent_synRegister]{synRegister}(instance, synapse_client=NULL)}: Registers an agent with the Synapse API. If agent already exists, it will be retrieved.
\item \code{\link[=Agent_synStartSession]{synStartSession}(instance, access_level="PUBLICLY_ACCESSIBLE", synapse_client=NULL)}: Starts an agent session. Adds the session to the Agent's sessions named list and sets it as the current session.
}
}

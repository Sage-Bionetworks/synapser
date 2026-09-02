%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{type}{(Optional[AgentType]) The type of agent.}
\item{sessions}{(dict[str, AgentSession]) A dictionary of AgentSession objects, keyed by session ID.}
\item{current_session}{(Optional[AgentSession]) The current session. Prompts will be sent to this session by default.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Chat with the baseline Synapse Agent
    You can chat with the same agent which is available in the Synapse UI
    at https://www.synapse.org/Chat:default. By default, this "baseline" agent
    is used when a registration ID is not provided. In the background,
    the Agent class will start a session and set that new session as the
    current session if one is not already set.

        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        my_agent = Agent()
        my_agent.prompt(
            prompt="Can you tell me about the AD Knowledge Portal dataset?",
            enable_trace=True,
            print_response=True,
        )

## Example 2: Register and chat with a custom agent
    **Only available for internal users (Sage Bionetworks employees)**

    Alternatively, you can register a custom agent and chat with it provided
    you have already created it.

        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        my_agent = Agent(cloud_agent_id="foo")
        my_agent.register()
        my_agent.prompt(
            prompt="Hello",
            enable_trace=True,
            print_response=True,
        )

## Example 3: Get and chat with an existing agent
    Retrieve an existing agent by providing the agent's registration ID and calling \code{get()}.
    Then, send a prompt to the agent.

        from synapseclient import Synapse
        from synapseclient.models.agent import Agent

        syn = Synapse()
        syn.login()

        my_agent = Agent(registration_id="foo").get()
        my_agent.prompt(
            prompt="Hello",
            enable_trace=True,
            print_response=True,
        )

Advanced Example: Start and prompt multiple sessions
    Here, we connect to a custom agent and start one session with the prompt "Hello".
    In the background, this first session is being set as the current session
    and future prompts will be sent to this session by default. If we want to send a
    prompt to a different session, we can do so by starting it and calling prompt again,
    but with our new session as an argument. We now have two sessions, both stored in the
    \code{my_agent.sessions} dictionary. After the second prompt, \code{my_second_session} is now
    the current session.

        syn = Synapse()
        syn.login()

        my_agent = Agent(registration_id="foo").get()

        my_agent.prompt(
            prompt="Hello",
            enable_trace=True,
            print_response=True,
        )

        my_second_session = my_agent.start_session()
        my_agent.prompt(
            prompt="Hello again",
            enable_trace=True,
            print_response=True,
            session=my_second_session,
        )
}
}
\section{Methods}{
\itemize{
\item \code{Agent(cloud_agent_id=NULL, cloud_alias_id=NULL, registration_id=NULL, registered_on=NULL, type=NULL, sessions=list(), current_session=NULL)}: Constructor for \code{\link{Agent}}
\item \code{get_chat_history()}: Gets the chat history for the current session.
\item \code{get_session(session_id, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{prompt(prompt, enable_trace=FALSE, print_response=FALSE, session=NULL, newer_than=NULL, timeout=120L, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{register(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{start_session(access_level="PUBLICLY_ACCESSIBLE", synapse_client=NULL)}: Wrapper for the function to be traced.
}
}


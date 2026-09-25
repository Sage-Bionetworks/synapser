\name{AgentSession}
\alias{AgentSession}
\docType{class}
\title{
AgentSession
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/agent/AgentSession.html}{Synapse Agent Session}
}
\usage{
AgentSession(id=NULL, access_level="PUBLICLY_ACCESSIBLE", started_on=NULL, started_by=NULL, modified_on=NULL, agent_registration_id=NULL, etag=NULL, chat_history=list())
}
\arguments{
\item{id}{(Optional[str]) The unique ID of the agent session. Can only be used by the user that created it.}
\item{access_level}{(Optional[AgentSessionAccessLevel]) The access level of the agent session. One of PUBLICLY_ACCESSIBLE, READ_YOUR_PRIVATE_DATA, or WRITE_YOUR_PRIVATE_DATA.}
\item{started_on}{(Optional[datetime]) The date the agent session was started.}
\item{started_by}{(Optional[int]) The ID of the user who started the agent session.}
\item{modified_on}{(Optional[datetime]) The date the agent session was last modified.}
\item{agent_registration_id}{(Optional[int]) The registration ID of the agent that will be used for this session.}
\item{etag}{(Optional[str]) The etag of the agent session.}
\item{chat_history}{(List[AgentPrompt]) A list of AgentPrompt objects.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Start a session and send a prompt.
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

## Example 2: Prompt an existing session.
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

## Example 3: Update the access level of an existing session.
    # Construct an AgentSession with its session ID, set the access level you
    # want, and call synUpdate().
    library(synapser)
    synLogin()

    my_session = AgentSession(id = "foo")
    my_session$access_level = "READ_YOUR_PRIVATE_DATA"
    my_session = my_session |> synUpdate()
}
}
\section{Methods}{
\itemize{
\item \code{AgentSession(id=NULL, access_level="PUBLICLY_ACCESSIBLE", started_on=NULL, started_by=NULL, modified_on=NULL, agent_registration_id=NULL, etag=NULL, chat_history=list())}: Constructor for \code{\link{AgentSession}}
\item \code{\link[=AgentSession_synPrompt]{synPrompt}(instance, prompt, enable_trace=FALSE, print_response=FALSE, newer_than=NULL, timeout=120L, synapse_client=NULL)}: Sends a prompt to the agent and adds the response to the AgentSession's chat history. A session must be started before sending a prompt.
\item \code{\link[=AgentSession_synStart]{synStart}(instance, synapse_client=NULL)}: Starts an agent session.
\item \code{\link[=AgentSession_synUpdate]{synUpdate}(instance, synapse_client=NULL)}: Updates an agent session. Only updates to the access level are currently supported.
}
}
\note{
It is recommended to use the \code{\link{Agent}} class to conduct chat sessions,
but you are free to use AgentSession directly if you wish.
}

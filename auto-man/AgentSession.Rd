%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{chat_history}{}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Start a session and send a prompt.
    Start a session with a custom agent by providing the agent's registration ID and calling \code{start()}.
    Then, send a prompt to the agent.

        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession

        syn = Synapse()
        syn.login()

        my_session = AgentSession(agent_registration_id="foo").start()
        my_session.prompt(
            prompt="Hello",
            enable_trace=True,
            print_response=True,
        )

## Example 2: Get an existing session and send a prompt.
    Retrieve an existing session by providing the session ID and calling \code{get()}.
    Then, send a prompt to the agent.

        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession

        syn = Synapse()
        syn.login()

        my_session = AgentSession(id="foo").get()
        my_session.prompt(
            prompt="Hello",
            enable_trace=True,
            print_response=True,
        )

## Example 3: Update the access level of an existing session.
    Retrieve an existing session by providing the session ID and calling \code{get()}.
    Then, update the access level of the session and call \code{update()}.

        from synapseclient import Synapse
        from synapseclient.models.agent import AgentSession, AgentSessionAccessLevel

        syn = Synapse()
        syn.login()

        my_session = AgentSession(id="foo").get()
        my_session.access_level = AgentSessionAccessLevel.READ_YOUR_PRIVATE_DATA
        my_session.update()
}
}
\section{Methods}{
\itemize{
\item \code{AgentSession(id=NULL, access_level="PUBLICLY_ACCESSIBLE", started_on=NULL, started_by=NULL, modified_on=NULL, agent_registration_id=NULL, etag=NULL, chat_history=list())}: Constructor for \code{\link{AgentSession}}
\item \code{prompt(prompt, enable_trace=FALSE, print_response=FALSE, newer_than=NULL, timeout=120L, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{start(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{update(synapse_client=NULL)}: Wrapper for the function to be traced.
}
}
\note{
but you are free to use AgentSession directly if you wish.
}


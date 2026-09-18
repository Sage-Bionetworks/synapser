%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{concrete_type}{}
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
\section{Methods}{
\itemize{
\item \code{AgentPrompt(concrete_type="org.sagebionetworks.repo.model.agent.AgentChatRequest", id=NULL, session_id=NULL, prompt=NULL, response=NULL, enable_trace=FALSE, trace=NULL)}: Constructor for \code{\link{AgentPrompt}}
}
}


%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Team}
\alias{Team}
\docType{class}
\title{
Team
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Team.html}{Synapse Team}.
User definable fields are:
}
\usage{
Team(id=NULL, name=NULL, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL)
}
\arguments{
\item{id}{(Optional[int]) The ID of the team}
\item{name}{(Optional[str]) The name of the team}
\item{description}{(Optional[str]) A short description of the team}
\item{icon}{(Optional[str]) A file handle ID for the icon image of the team}
\item{can_public_join}{(Optional[bool]) True if members can join without an invitation or approval}
\item{can_request_membership}{(Optional[bool]) True if users can create a membership request to join}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this team was created}
\item{modified_on}{(Optional[str]) The date this team was last modified}
\item{created_by}{(Optional[str]) The ID of the user that created this team}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this team}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Team(id=NULL, name=NULL, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL)}: Constructor for \code{\link{Team}}
\item \code{create(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{from_id(cls, id, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{from_name(cls, name, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{get_user_membership_status(user_id, synapse_client=NULL)}: Retrieve a user's Team Membership Status bundle for this team.
\item \code{invite(user, message, force=TRUE, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{members(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{open_invitations(synapse_client=NULL)}: Wrapper for the function to be traced.
}
}


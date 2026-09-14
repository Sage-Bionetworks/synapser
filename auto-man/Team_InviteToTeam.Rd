%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synInviteToTeam}
\alias{synInviteToTeam}
\docType{methods}
\title{
Team :  invite
}
\description{
Invites a user to a team given the ID field on the Team instance.
}
\usage{
synInviteToTeam(instance, user, message, force=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{user}{(Union[str, int]) The username or ID of the user to invite.}
\item{message}{(str) The message to send.}
\item{force}{(bool) If True, will send the invite even if the user is already a member or has an open invitation. If False, will not send the invite if the user is already a member or has an open invitation. Defaults to True.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The invite response or None if an invite was not sent.
}
\keyword{Team}

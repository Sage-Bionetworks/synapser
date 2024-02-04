%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synInviteToTeam}
\alias{synInviteToTeam}
\docType{methods}
\title{
synInviteToTeam
}
\description{
Invite user to a Synapse team via Synapse username or email
(choose one or the other)

Arguments:
    syn: Synapse object
    team: A [synapseclient.team.Team][] object or a team's ID.
    user: Synapse username or profile id of user
    inviteeEmail: Email of user
    message: Additional message for the user getting invited to the team.
    force: If an open invitation exists for the invitee, the old invite will be cancelled.

Returns:
    MembershipInvitation or None if user is already a member
}
\usage{
synInviteToTeam(team, user=NULL, inviteeEmail=NULL, message=NULL, force=FALSE)
}
\arguments{
\item{team}{}
\item{user}{}
\item{inviteeEmail}{}
\item{message}{}
\item{force}{}
}
\value{

}



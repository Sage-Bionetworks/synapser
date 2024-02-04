%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSendMembershipInvitation}
\alias{synSendMembershipInvitation}
\docType{methods}
\title{
synSendMembershipInvitation
}
\description{
Create a membership invitation and send an email notification
to the invitee.

Arguments:
    teamId: Synapse teamId
    inviteeId: Synapse username or profile id of user
    inviteeEmail: Email of user
    message: Additional message for the user getting invited to the
             team.

Returns:
    MembershipInvitation
}
\usage{
synSendMembershipInvitation(teamId, inviteeId=NULL, inviteeEmail=NULL, message=NULL)
}
\arguments{
\item{teamId}{}
\item{inviteeId}{}
\item{inviteeEmail}{}
\item{message}{}
}
\value{

}



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
}
\usage{
synSendMembershipInvitation(teamId, inviteeId=NULL, inviteeEmail=NULL, message=NULL)
}
\arguments{
\item{teamId}{ Synapse teamId\cr
}
\item{inviteeId}{ Synapse username or profile id of user\cr
}
\item{inviteeEmail}{ Email of user\cr
}
\item{message}{ Additional message for the user getting invited to the\cr
                team. Default to None.}
}
\value{
 MembershipInvitation
}



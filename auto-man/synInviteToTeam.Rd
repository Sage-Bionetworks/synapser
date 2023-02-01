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
}
\usage{
synInviteToTeam(team, user=NULL, inviteeEmail=NULL, message=NULL, force=FALSE, syn=NULL)
}
\arguments{
\item{team}{ A Team object or a\cr
             team's ID.\cr
}
\item{user}{ Synapse username or profile id of user\cr
}
\item{inviteeEmail}{ Email of user\cr
}
\item{message}{ Additional message for the user getting invited to the\cr
                team. Default to None.\cr
}
\item{force}{ If an open invitation exists for the invitee,\cr
              the old invite will be cancelled. Default to False.}
\item{syn}{optional named parameter:  Synapse object\cr
}
}
\value{
 MembershipInvitation or None if user is already a member
}



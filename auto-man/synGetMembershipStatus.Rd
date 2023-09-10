%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetMembershipStatus}
\alias{synGetMembershipStatus}
\docType{methods}
\title{
synGetMembershipStatus
}
\description{
Retrieve a user's Team Membership Status bundle.
https://rest-docs.synapse.org/rest/GET/team/id/member/principalId/membershipStatus.html
}
\usage{
synGetMembershipStatus(userid, team, user=NULL)
}
\arguments{
\item{userid}{}
\item{team}{ A Team object or a\cr
             team's ID.}
\item{user}{optional named parameter:  Synapse user ID\cr
}
}
\value{
 dict of TeamMembershipStatus
}



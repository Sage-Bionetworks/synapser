\name{synGetTeamOpenInvitations}
\alias{synGetTeamOpenInvitations}
\docType{methods}
\title{
synGetTeamOpenInvitations
}
\description{
Retrieve the open requests submitted to a Team
https://docs.synapse.org/rest/GET/team/id/openInvitation.html
}
\usage{
synGetTeamOpenInvitations(team)
}
\arguments{
\item{team}{ A Team object or a\cr
             team's ID.}
}
\value{
 generator of MembershipRequest
}



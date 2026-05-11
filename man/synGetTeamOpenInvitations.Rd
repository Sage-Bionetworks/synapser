\name{synGetTeamOpenInvitations}
\alias{synGetTeamOpenInvitations}
\docType{methods}
\title{
synGetTeamOpenInvitations
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use [synapseclient.models.Team.open_invitations][] instead.

Retrieve the open requests submitted to a \href{https://rest-docs.synapse.org/rest/GET/team/id/openInvitation.html}{Team}
}
\usage{
synGetTeamOpenInvitations(team)
}
\arguments{
\item{team}{A Team object or a team's ID.}
}
\value{
Generator of MembershipRequest dictionaries
}



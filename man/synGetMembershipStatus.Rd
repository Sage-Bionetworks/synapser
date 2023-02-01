\name{synGetMembershipStatus}
\alias{synGetMembershipStatus}
\docType{methods}
\title{
synGetMembershipStatus
}
\description{
Retrieve a user's Team Membership Status bundle.
https://docs.synapse.org/rest/GET/team/id/member/principalId/membershipStatus.html
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
\examples{
\dontrun{
synGetMembershipStatus(user_id, team_id)$isMember

}
}




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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 dict of TeamMembershipStatus
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{
\dontrun{
synGetMembershipStatus(user_id, team_id)$isMember

}
}




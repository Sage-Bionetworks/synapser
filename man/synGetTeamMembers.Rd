\name{synGetTeamMembers}
\alias{synGetTeamMembers}
\docType{methods}
\title{
synGetTeamMembers
}
\description{
Lists the members of the given team.
}
\usage{
synGetTeamMembers(team)
}
\arguments{
\item{team}{ A Team object or a team's ID.}
}
\value{
 a generator over TeamMember objects.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
	teamMembers<-synGetTeamMembers(3324324)
}
}




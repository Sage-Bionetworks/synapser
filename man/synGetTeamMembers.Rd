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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a generator over TeamMember objects.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
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




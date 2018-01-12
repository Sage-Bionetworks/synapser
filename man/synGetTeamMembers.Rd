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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\dontrun{
	teamMembers<-synGetTeamMembers(3324324)
}
}




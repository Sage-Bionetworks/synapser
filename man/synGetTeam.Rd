\name{synGetTeam}
\alias{synGetTeam}
\docType{methods}
\title{
synGetTeam
}
\description{
Finds a team with a given ID or name.
}
\usage{
synGetTeam(id)
}
\arguments{
\item{id}{  The ID or name of the team or a Team object to retrieve}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
  An object of type Team
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
# By ID
synGetTeam(teamId)

# By Name
synGetTeam("my_team_name")
}
}




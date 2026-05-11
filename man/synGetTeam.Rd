\name{synGetTeam}
\alias{synGetTeam}
\docType{methods}
\title{
synGetTeam
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use [synapseclient.models.Team.from_id][] or [synapseclient.models.Team.from_name][] instead.

Finds a team with a given ID or name.
}
\usage{
synGetTeam(id)
}
\arguments{
\item{id}{  The ID or name of the team or a Team object to retrieve}
}
\value{
  An object of type Team
}

\examples{
\dontrun{
# By ID
synGetTeam(teamId)

# By Name
synGetTeam("my_team_name")
}
}




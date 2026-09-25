\name{synFromId}
\alias{Team_synFromId}
\docType{methods}
\title{
Team :  from_id
}
\description{
Gets Team object using its integer id.
}
\usage{
synFromId(cls, id, synapse_client=NULL)
}
\arguments{
\item{cls}{(Team) The Team class (or an existing Team instance) to dispatch this call to.}
\item{id}{(integer) The id of the team.}
\item{synapse_client}{(Optional[Synapse]) If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
Team: The Team object.
}
\examples{
\dontrun{
## Get a team by its ID
    library(synapser)
    synLogin()

    team = Team() |> synFromId(id = 123456L)
}
}
\keyword{Team}

\name{synFromName}
\alias{Team_synFromName}
\docType{methods}
\title{
Team :  from_name
}
\description{
Gets Team object using its string name.

\strong{Note:} You will be unable to retrieve a team by name immediately after its creation because the fragment service is eventually consistent. If you need to retrieve a team immediately following creation you should use the \code{\link[=Team_synFromId]{synFromId}()} function instead.
}
\usage{
synFromName(cls, name, synapse_client=NULL)
}
\arguments{
\item{cls}{(Team) The Team class (or an existing Team instance) to dispatch this call to.}
\item{name}{(str) The name of the team.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
Team: The Team object.
}
\examples{
\dontrun{
## Get a team by its name
    library(synapser)
    synLogin()

    team = Team() |> synFromName(name = "My Uniquely Named Team")
}
}
\keyword{Team}

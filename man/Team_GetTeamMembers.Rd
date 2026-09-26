\name{synGetTeamMembers}
\alias{Team_synGetTeamMembers}
\docType{methods}
\title{
Team :  members
}
\description{
Gets the TeamMembers associated with a team given the ID field on the Team instance.
}
\usage{
synGetTeamMembers(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of TeamMember objects.
}
\examples{
\dontrun{
## List the members of a team
    library(synapser)
    synLogin()

    team = Team() |> synFromId(id = 123456L)
    members = team |> synGetTeamMembers()
    for (member in members) {
        cat(sprintf("\%s (admin: \%s)\n", member$member$user_name, member$is_admin))
    }
}
}
\keyword{Team}

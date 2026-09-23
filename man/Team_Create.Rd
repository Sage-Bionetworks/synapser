\name{synCreate}
\alias{Team_synCreate}
\docType{methods}
\title{
Team :  create
}
\description{
Creates a new team on Synapse.
}
\usage{
synCreate(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{\link{Team}} object.
}
\examples{
\dontrun{
## Create a new team
    library(synapser)
    synLogin()

    team = Team(
        name = "My Uniquely Named Team",
        description = "A team for my project collaborators",
        can_public_join = FALSE
    ) |> synCreate()
}
}
\keyword{Team}

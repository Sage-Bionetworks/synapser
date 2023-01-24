\name{synMove}
\alias{synMove}
\docType{methods}
\title{
synMove
}
\description{
Move a Synapse entity to a new container.
}
\usage{
synMove(entity, new_parent)
}
\arguments{
\item{entity}{           A Synapse ID, a Synapse Entity object, or a local file that is stored in Synapse\cr
}
\item{new_parent}{       The new parent container (Folder or Project) to which the entity should be moved.}
}
\value{
 The Synapse Entity object that has been moved.
}
\examples{
\dontrun{
    entity <- synMove('syn456', 'syn123')
}
}




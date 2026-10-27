\name{UsedEntity}
\alias{UsedEntity}
\docType{class}
\title{
UsedEntity
}
\format{An S3-style class object.}
\description{
Reference to a Synapse entity that was used or executed by an Activity.
}
\usage{
UsedEntity(target_id=NULL, target_version_number=NULL)
}
\arguments{
\item{target_id}{(Optional[str]) The ID of the entity to which this reference refers.}
\item{target_version_number}{(Optional[int]) The version number of the entity to which this reference refers.}
}
\value{
NULL
}
\examples{
\dontrun{
## Recording an entity used to produce a file
    library(synapser)
    synLogin()

    activity = Activity(
        name = "Analysis",
        used = list(UsedEntity(target_id = "syn456", target_version_number = 1L))
    )
    activity = activity |> synStore(parent = "syn123")
}
}
\section{Methods}{
\itemize{
\item \code{UsedEntity(target_id=NULL, target_version_number=NULL)}: Constructor for \code{\link{UsedEntity}}
}
}


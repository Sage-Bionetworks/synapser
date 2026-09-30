\name{LinkOptions}
\alias{LinkOptions}
\docType{class}
\title{
LinkOptions
}
\format{An S3-style class object.}
\description{
Configuration options specific to Link entities when using the factory methods.

This dataclass controls how Link entities are handled during retrieval,
particularly whether the link should be followed to return the target entity
or if the Link entity itself should be returned.
}
\usage{
LinkOptions(follow_link=TRUE)
}
\arguments{
\item{follow_link}{(bool) Whether to follow the link and return the target entity instead of the Link entity itself. If TRUE, the factory method will return the entity that the Link points to (e.g., if a Link points to a File, a File object will be returned). If FALSE, the Link entity itself will be returned, allowing you to inspect the link's properties such as target_id, target_version, etc. Default is TRUE.}
}
\value{
NULL
}
\examples{
\dontrun{
    # Configure link following behavior:
    library(synapser)

    # Follow the link and return the target entity
    follow_target = LinkOptions(follow_link = TRUE)

    # Return the Link entity itself
    return_link = LinkOptions(follow_link = FALSE)
}
}
\section{Methods}{
\itemize{
\item \code{LinkOptions(follow_link=TRUE)}: Constructor for \code{\link{LinkOptions}}
}
}
\note{
- When follow_link=TRUE, the returned entity type depends on what the Link points to (could be File, Project, Folder, etc.)\cr
- When follow_link=FALSE, a Link entity is always returned
}


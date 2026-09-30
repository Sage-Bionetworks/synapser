\name{EntityRef}
\alias{EntityRef}
\docType{class}
\title{
EntityRef
}
\format{An S3-style class object.}
\description{
Represents a reference to the id and version of an entity to be used in \code{Dataset} and
\code{DatasetCollection} objects.
}
\usage{
EntityRef(id, version)
}
\arguments{
\item{id}{(character) The Synapse ID of the entity.}
\item{version}{(integer) Indicates a specific version of the entity.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{EntityRef(id, version)}: Constructor for \code{\link{EntityRef}}
}
}

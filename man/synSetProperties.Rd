\name{synSetProperties}
\alias{synSetProperties}
\title{synSetProperties}
\description{
A pipe-friendly helper to set one or more named properties on a Synapse entity
object before storing it. Returns the modified entity so it can be chained with
\code{\link{synStore}} via the pipe operator.
All provided properties must be named arguments and must correspond to valid attributes of the entity. 
If any property is unnamed or is not a valid attribute, an error will be raised.
If duplicate properties are provided, the first one will be used.
}
\usage{
synSetProperties(entity, ...)
}
\arguments{
\item{entity}{A Synapse entity object (e.g. File, Folder, Project, Table).}
\item{...}{Named property-value pairs to set on the entity. Common properties
  include \code{annotations} (a named list), \code{name} (string), and \code{description} (string), etc.}
}
\value{
The entity with the specified properties updated.
\code{\link{synStore}}.
Throws an error if any property is unnamed or is not a valid attribute.
}
\examples{
\dontrun{
# Set annotations before storing
synGet("syn123") |>
  synSetProperties(annotations = list(foo="bar", baz=1)) |>
  synStore()

# Set multiple properties at once
synGet("syn123") |>
  synSetProperties(
    name        = "updated name",
    description = "updated description",
    annotations = list(foo = "bar")
  ) |>
  synStore()
}
}

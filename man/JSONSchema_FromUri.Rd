\name{synFromUri}
\alias{JSONSchema_synFromUri}
\alias{synFromUri}
\docType{methods}
\title{
JSONSchema :  from_uri
}
\description{
Creates a JSONSchema from a URI. The URI can either be a semantic version or not:\cr
- non-semantic: ORGANIZATION.NAME-SCHEMA.NAME\cr
- semantic: ORGANIZATION.NAME-SCHEMA.NAME-MAJOR.MINOR.PATCH
}
\usage{
synFromUri(cls, uri)
}
\arguments{
\item{cls}{(JSONSchema) The JSONSchema class (or an existing JSONSchema instance) to dispatch this call to.}
\item{uri}{(character) The URI to the JSON Schema in Synapse}
}
\value{
A JSONSchema object
}
\section{Errors}{
An error is raised if the URI isn't in the correct form.
}
\examples{
\dontrun{
## Create a JSONSchema from a URI
    library(synapser)

    # Non-semantic URI
    js1 = JSONSchema |> synFromUri(uri = "my.org-my.schema")

    # Semantic URI
    js2 = JSONSchema |> synFromUri(uri = "my.org-my.schema-0.0.1")
}
}
\keyword{JSONSchema}

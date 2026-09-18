%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromUri}
\alias{synFromUri}
\docType{methods}
\title{
JSONSchema :  from_uri
}
\description{
Creates a JSONSchema from a URI.
The URI can either be a semantic version or not
- non-semantic: ORGANIZATION.NAME-SCHEMA.NAME
- semantic: ORGANIZATION.NAME-SCHEMA.NAME-MAJOR.MINOR.PATCH
}
\usage{
synFromUri(cls, uri)
}
\arguments{
\item{cls}{(JSONSchema) The JSONSchema class (or an existing JSONSchema instance) to dispatch this call to.}
\item{uri}{(str) The URI to the JSON Schema in Synapse}
}
\value{
A JSONSchema object
}
\section{Errors}{
ValueError:  If the URI isn't in the correct form.
}
\examples{
\dontrun{
## Create a JSONSchema from a URI

    from synapseclient.models import JSONSchema

    # Non-semantic URI
    js1 = JSONSchema.from_uri("my.org-my.schema")

    # Semantic URI
    js2 = JSONSchema.from_uri("my.org-my.schema-0.0.1")
}
}
\keyword{JSONSchema}

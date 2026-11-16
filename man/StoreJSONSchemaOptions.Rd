\name{StoreJSONSchemaOptions}
\alias{StoreJSONSchemaOptions}
\docType{class}
\title{
StoreJSONSchemaOptions
}
\format{An S3-style class object.}
\description{
Options for storing JSONSchema entities.
}
\usage{
StoreJSONSchemaOptions(schema_body, version=NULL, dry_run=FALSE)
}
\arguments{
\item{schema_body}{(dict) The body of the JSONSchema to store, provided as a named list.}
\item{version}{(Optional[str]) The version of the JSONSchema body to store.}
\item{dry_run}{(bool) Whether or not to do a dry-run.}
}
\value{
NULL
}
\examples{
\dontrun{
## Using this class
    library(synapser)
    synLogin()

    schema_definition = list(
        "$id" = "mySchema",
        type = "object",
        properties = list(foo = list(type = "string")),
        required = list("foo")
    )
    schema = JSONSchema(name = "my.schema", organization_name = "myUniqueOrgName") |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_definition, version = "0.0.1")
    )
}
}
\section{Methods}{
\itemize{
\item \code{StoreJSONSchemaOptions(schema_body, version=NULL, dry_run=FALSE)}: Constructor for \code{\link{StoreJSONSchemaOptions}}
}
}


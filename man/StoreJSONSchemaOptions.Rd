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
\section{Methods}{
\itemize{
\item \code{StoreJSONSchemaOptions(schema_body, version=NULL, dry_run=FALSE)}: Constructor for \code{\link{StoreJSONSchemaOptions}}
}
}


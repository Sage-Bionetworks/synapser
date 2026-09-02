%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{JSONSchema}
\alias{JSONSchema}
\docType{class}
\title{
JSONSchema
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/JsonSchemaInfo.html}{JSON Schema}
}
\usage{
JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL, uri=NULL)
}
\arguments{
\item{name}{(Optional[str]) The name of the schema}
\item{organization_name}{(Optional[str]) The name of the organization the schema belongs to}
\item{organization_id}{(Optional[int]) the id of the organization the schema belongs to}
\item{id}{(Optional[str]) The ID of the schema}
\item{created_on}{(Optional[str]) The date this schema was created}
\item{created_by}{(Optional[str]) The ID of the user that created this schema}
\item{uri}{optional named parameter: The schema identifier in format: <organization_name>-<schema_name>}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL, uri=NULL)}: Constructor for \code{\link{JSONSchema}}
\item \code{get_body(version=NULL, synapse_client=NULL)}: Gets the body of this JSONSchema
\item \code{get_versions(synapse_client=NULL)}: Gets all versions of this JSONSchema
}
}


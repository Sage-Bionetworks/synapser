\name{JSONSchema}
\alias{JSONSchema}
\docType{class}
\title{
JSONSchema
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/JsonSchemaInfo.html}{JSON Schema}.
}
\usage{
JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL)
}
\arguments{
\item{name}{(Optional[character]) The name of the schema}
\item{organization_name}{(Optional[character]) The name of the organization the schema belongs to}
\item{organization_id}{(Optional[integer]) The ID of the organization the schema belongs to}
\item{id}{(Optional[character]) The ID of the schema}
\item{created_on}{(Optional[character]) The date this schema was created}
\item{created_by}{(Optional[character]) The ID of the user that created this schema}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Store a JSON schema
    # This example expects that the organization "my.org" already exists.
    library(synapser)
    synLogin()

    schema_body = list(
        properties = list(
            Component = list(
                description = "TBD",
                not = list(type = "null"),
                title = "Component"
            )
        )
    )
    schema = JSONSchema(organization_name = "my.org", name = "test.schema") |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_body, version = "0.0.1")
    )

## Example 2: Get an existing JSON schema
    schema = JSONSchema(organization_name = "my.org", name = "test.schema") |> synGet()
    print(schema$uri)

## Example 3: Create a JSON schema from a URI
    schema = JSONSchema |> synFromUri(uri = "my.org-test.schema")

## Example 4: Get the body of a JSON schema
    # Get the latest version
    latest = schema |> synGetBody()
    print(latest)

    # Get a specific version
    first = schema |> synGetBody(version = "0.0.1")
    print(first)

## Example 5: Get all versions of a JSON schema
    for (item in as.list(schema |> synGetVersions())) {
        print(item)
    }

## Example 6: Delete a JSON schema
    # Delete a specific version
    schema |> synDelete(version = "0.0.1")

    # Or delete the whole schema
    schema |> synDelete()
}
}
\section{Methods}{
\itemize{
\item \code{JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL)}: Constructor for \code{\link{JSONSchema}}
\item \code{\link[=JSONSchema_synFromUri]{synFromUri}(cls, uri)}: Creates a JSONSchema from a URI. The URI can either be a semantic version or not:\cr
- non-semantic: ORGANIZATION.NAME-SCHEMA.NAME\cr
- semantic: ORGANIZATION.NAME-SCHEMA.NAME-MAJOR.MINOR.PATCH
\item \code{\link[=JSONSchema_synGetBody]{synGetBody}(instance, version=NULL, synapse_client=NULL)}: Gets the body of this JSONSchema
\item \code{\link[=JSONSchema_synGetVersions]{synGetVersions}(instance, synapse_client=NULL)}: Gets all versions of this JSONSchema
}
}

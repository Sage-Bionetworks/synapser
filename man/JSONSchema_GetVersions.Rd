\name{synGetVersions}
\alias{JSONSchema_synGetVersions}
\alias{synGetVersions}
\docType{methods}
\title{
JSONSchema :  get_versions
}
\description{
Gets all versions of this JSONSchema
}
\usage{
synGetVersions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(JSONSchema) The JSONSchema instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields a \code{JSONSchemaVersionInfo} for each version of this schema. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one version at a time. Each \code{JSONSchemaVersionInfo} has these fields, read with \code{$}:
\itemize{
\item \code{organization_id}: The ID of the organization.
\item \code{organization_name}: The name of the organization.
\item \code{schema_id}: The ID of the schema.
\item \code{id}: The URI of this schema version.
\item \code{schema_name}: The name of the schema.
\item \code{version_id}: The ID of this schema version.
\item \code{semantic_version}: The semantic version, e.g. \code{"0.0.1"}.
\item \code{json_sha256_hex}: The SHA-256 hash of the schema body.
\item \code{created_on}: When this version was created.
\item \code{created_by}: The ID of the user that created this version.
}
}
\examples{
\dontrun{
## Get all versions of the JSONSchema
    library(synapser)
    synLogin()

    schema = JSONSchema(organization_name = "dpetest", name = "test.schematic.Biospecimen")
    version_generator = schema |> synGetVersions()
    for (item in as.list(version_generator)) {
        print(item$semantic_version)
    }
}
}
\keyword{JSONSchema}

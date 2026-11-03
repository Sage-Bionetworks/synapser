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
A \code{GeneratorWrapper} object that yields the \code{JSONSchemaVersionInfo} for each version of this schema. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one version at a time.
}
\examples{
\dontrun{
## Get all versions of the JSONSchema
    library(synapser)
    synLogin()

    schema = JSONSchema(organization_name = "dpetest", name = "test.schematic.Biospecimen")
    version_generator = schema |> synGetVersions()
    for (item in as.list(version_generator)) {
        print(item)
    }
}
}
\keyword{JSONSchema}

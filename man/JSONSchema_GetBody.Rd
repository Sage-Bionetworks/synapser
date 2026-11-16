\name{synGetBody}
\alias{JSONSchema_synGetBody}
\alias{synGetBody}
\docType{methods}
\title{
JSONSchema :  get_body
}
\description{
Gets the body of this JSONSchema
}
\usage{
synGetBody(instance, version=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(JSONSchema) The JSONSchema instance to operate on.}
\item{version}{(Optional[character]) Defaults to NULL.\cr
- If a version is supplied, that version's body will be returned.\cr
- If no version is supplied the most recent version will be returned.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The JSON Schema body, as a named list
}
\examples{
\dontrun{
## Get the body of the JSONSchema
    library(synapser)
    synLogin()

    schema = JSONSchema(organization_name = "dpetest", name = "test.schematic.Biospecimen")

    # Get latest version
    latest = schema |> synGetBody()
    print(latest)

    # Get specific version
    first = schema |> synGetBody(version = "0.0.1")
    print(first)
}
}
\keyword{JSONSchema}

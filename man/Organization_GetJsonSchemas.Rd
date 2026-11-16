\name{synGetJsonSchemas}
\alias{Organization_synGetJsonSchemas}
\docType{methods}
\title{
Organization :  get_json_schemas
}
\description{
Gets the JSON Schemas that are part of this organization
}
\usage{
synGetJsonSchemas(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Organization) The Organization instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields the \code{JSONSchema} objects that belong to this organization. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{JSONSchema} at a time.
}
\examples{
\dontrun{
## Get the JSONSchemas that are part of this Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    js_generator = org |> synGetJsonSchemas()
    for (item in as.list(js_generator)) {
        print(item)
    }
}
}
\keyword{Organization}

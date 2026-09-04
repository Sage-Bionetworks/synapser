%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetVersions}
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
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
A Generator containing the JSONSchemaVersionInfo for each version of this schema
}
\examples{
\dontrun{
## Get all versions of the JSONSchema

    from synapseclient.models import JSONSchema
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    schema = JSONSchema(organization_name="dpetest", name="test.schematic.Biospecimen")
    version_generator = schema.get_versions()
    for item in version_generator:
        print(item)
}
}
\keyword{JSONSchema}

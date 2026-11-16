%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{JSONSchema_synGet}
\docType{methods}
\title{
JSONSchema :  get
}
\description{
Gets the metadata for this JSONSchema from Synapse
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(JSONSchema) The JSONSchema instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
Itself
}
\section{Errors}{
ValueError: This JSONSchema doesn't have a name
    ValueError: This JSONSchema doesn't have an organization name
    ValueError: This JSONSchema doesn't exist in its organization
}
\examples{
\dontrun{
## Get an existing JSONSchema

    from synapseclient.models import JSONSchema
    from synapseclient import Synapse
    import asyncio

    async def get_schema():

        syn = Synapse()
        syn.login()

        schema = JSONSchema(organization_name="dpetest", name="test.schematic.Biospecimen")
        await schema.get_async()
        return schema

    schema = asyncio.run(get_schema())
    print(schema.uri)
}
}
\keyword{JSONSchema}

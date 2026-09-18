%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetBody}
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
\item{version}{(Optional[str]) Defaults to None. - If a version is supplied, that versions body will be returned. - If no version is supplied the most recent version will be returned.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
The JSON Schema body
}
\examples{
\dontrun{
## Get the body of the JSONSchema

    # Get latest version

    from synapseclient.models import JSONSchema
    from synapseclient import Synapse
    import asyncio

    async def get_body():

        syn = Synapse()
        syn.login()

        schema = JSONSchema(organization_name="dpetest", name="test.schematic.Biospecimen")
        body = await schema.get_body_async()
        return body

    body = asyncio.run(get_body())
    print(body)

    Get specific version

    from synapseclient.models import JSONSchema
    from synapseclient import Synapse
    import asyncio

    async def get_body():

        syn = Synapse()
        syn.login()

        schema = JSONSchema(organization_name="dpetest", name="test.schematic.Biospecimen")
        body = await schema.get_body_async(version="0.0.1")
        return body

    body = asyncio.run(get_body())
    print(body)
}
}
\keyword{JSONSchema}

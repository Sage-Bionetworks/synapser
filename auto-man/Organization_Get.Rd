%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Organization_synGet}
\docType{methods}
\title{
Organization :  get
}
\description{
Gets the metadata from Synapse for this organization
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Organization) The Organization instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
Itself
}
\section{Errors}{
ValueError: If the name has not been set
}
\examples{
\dontrun{
## Get an existing Organization


    from synapseclient.models import Organization
    from synapseclient import Synapse
    import asyncio

    async def get_org():

        syn = Synapse()
        syn.login()

        org = Organization("dpetest")
        await org.get_async()
        return org

    org = asyncio.run(get_org())
    print(org.name)
    print(org.id)
}
}
\keyword{Organization}

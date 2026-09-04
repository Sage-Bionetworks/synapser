%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetPermissions}
\alias{synGetPermissions}
\docType{methods}
\title{
EntityView :  get_permissions
}
\description{
Get the [permissions][synapseclient.core.models.permission.Permissions]
that the caller has on an Entity.
}
\usage{
synGetPermissions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A Permissions object
}
\examples{
\dontrun{
## Using this function:
    # Getting permissions for a Synapse Entity

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File

    syn = Synapse()
    syn.login()

    async def main():
        permissions = await File(id="syn123").get_permissions_async()

    asyncio.run(main())

    Getting access types list from the Permissions object

    permissions.access_types
}
}
\keyword{EntityView}

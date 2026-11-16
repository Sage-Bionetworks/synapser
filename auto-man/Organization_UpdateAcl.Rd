%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpdateAcl}
\alias{Organization_synUpdateAcl}
\docType{methods}
\title{
Organization :  update_acl
}
\description{
Updates the ACL for a principal for this organization
}
\usage{
synUpdateAcl(instance, principal_id, access_type, synapse_client=NULL)
}
\arguments{
\item{instance}{(Organization) The Organization instance to operate on.}
\item{principal_id}{(int) the id of the principal whose permissions are to be updated}
\item{access_type}{(list[str]) List of permission types (e.g., ["READ", "CREATE", "DELETE"]) see: [ACCESS_TYPE]https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
NULL
}
\examples{
\dontrun{
## Update the ACL for a Organization

    from synapseclient.models import Organization
    from synapseclient import Synapse
    import asyncio

    async def update_acl() -> None:

        syn = Synapse()
        syn.login()

        org = Organization("dpetest")
        await org.update_acl_async(
            principal_id=1,
            access_type=["READ"]
        )

    asyncio.run(update_acl())
}
}
\keyword{Organization}

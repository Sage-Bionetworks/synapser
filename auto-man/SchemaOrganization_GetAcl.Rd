%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAcl}
\alias{synGetAcl}
\docType{methods}
\title{
SchemaOrganization :  get_acl
}
\description{
Gets the ACL for this organization
}
\usage{
synGetAcl(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(SchemaOrganization) The SchemaOrganization instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
A dictionary in the form of this response:
      [AccessControlList]https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html
}
\examples{
\dontrun{
## Get the ACL for a SchemaOrganization

    from synapseclient.models import SchemaOrganization
    from synapseclient import Synapse
    import asyncio

    async def get_acl():

        syn = Synapse()
        syn.login()

        org = SchemaOrganization("dpetest")
        acl = await org.get_acl_async()
        return acl

    acl = asyncio.run(get_acl())
    etag = acl["etag"]
    print(etag)
    resource_access = acl["resourceAccess"]
    for item in resource_access:
        principal_id = item["principalId"]
        print((principal_id))
        access_types = item["accessType"]
        print(access_types)
}
}
\keyword{SchemaOrganization}

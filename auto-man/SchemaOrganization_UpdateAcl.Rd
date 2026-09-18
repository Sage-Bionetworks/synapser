%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpdateAcl}
\alias{synUpdateAcl}
\docType{methods}
\title{
SchemaOrganization :  update_acl
}
\description{
Updates the ACL for a principal for this organization
}
\usage{
synUpdateAcl(instance, principal_id, access_type, synapse_client=NULL, Example=NULL)
}
\arguments{
\item{instance}{(SchemaOrganization) The SchemaOrganization instance to operate on.}
\item{principal_id}{(int) the id of the principal whose permissions are to be updated}
\item{access_type}{(list[str]) List of permission types (e.g., ["READ", "CREATE", "DELETE"]) see: [ACCESS_TYPE]https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
\item{Example}{optional named parameter: Update the ACL for a SchemaOrganization\cr
\cr
from synapseclient.models import SchemaOrganization from synapseclient import Synapse import asyncio\cr
\cr
async def update_acl() -> None:\cr
\cr
syn = Synapse() syn.login()\cr
\cr
org = SchemaOrganization("dpetest") await org.update_acl_async( principal_id=1, access_type=["READ"] )\cr
\cr
asyncio.run(update_acl())}
}
\value{
NULL
}
\keyword{SchemaOrganization}

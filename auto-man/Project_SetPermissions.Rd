%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSetPermissions}
\alias{synSetPermissions}
\docType{methods}
\title{
Project :  set_permissions
}
\description{
Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
}
\usage{
synSetPermissions(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{principal_id}{(int) Identifier of a user or group. \code{273948} is for all registered Synapse users and \code{273949} is for public access. None implies public access.}
\item{access_type}{(list[str]) Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE, DELETE, CHANGE_PERMISSIONS.\cr
\cr
**Defaults to ['READ', 'DOWNLOAD']**}
\item{modify_benefactor}{(bool) Set as True when modifying a benefactor's ACL. The term 'benefactor' is used to indicate which Entity an Entity inherits its ACL from. For example, a newly created Project will be its own benefactor, while a new FileEntity's benefactor will start off as its containing Project. If the entity already has local sharing settings the benefactor would be itself. It may also be the immediate parent, somewhere in the parent tree, or the project itself.}
\item{warn_if_inherits}{(bool) When \code{modify_benefactor} is True, this does not have any effect. When \code{modify_benefactor} is False, and \code{warn_if_inherits} is True, a warning log message is produced if the benefactor for the entity you passed into the function is not itself, i.e., it's the parent folder, or another entity in the parent tree.}
\item{overwrite}{(bool) By default this function overwrites existing permissions for the specified user. Set this flag to False to add new permissions non-destructively.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
An Access Control List object matching <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html>.
}
\examples{
\dontrun{
## Setting permissions
    # Grant all registered users download access

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File

    syn = Synapse()
    syn.login()

    async def main():
        await File(id="syn123").set_permissions_async(principal_id=273948, access_type=['READ','DOWNLOAD'])

    asyncio.run(main())

    Grant the public view access

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File

    syn = Synapse()
    syn.login()

    async def main():
        await File(id="syn123").set_permissions_async(principal_id=273949, access_type=['READ'])

    asyncio.run(main())
}
}
\keyword{Project}

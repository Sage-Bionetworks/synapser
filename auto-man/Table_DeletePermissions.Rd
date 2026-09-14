%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeletePermissions}
\alias{synDeletePermissions}
\docType{methods}
\title{
Table :  delete_permissions
}
\description{
Delete the entire Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.

In order to remove permissions for a specific user or group, you
should use the \code{set_permissions_async} method with the \code{access_type} set to
an empty list.

By default, Entities such as FileEntity and Folder inherit their permission from
their containing Project. For such Entities the Project is the Entity's 'benefactor'.
This permission inheritance can be overridden by creating an ACL for the Entity.
When this occurs the Entity becomes its own benefactor and all permission are
determined by its own ACL.

If the ACL of an Entity is deleted, then its benefactor will automatically be set
to its parent's benefactor.

**Special notice for Projects:** The ACL for a Project cannot be deleted, you
must individually update or revoke the permissions for each user or group.
}
\usage{
synDeletePermissions(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL, _benefactor_tracker=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{include_self}{(bool) If True (default), delete the ACL of the current entity. If False, skip deleting the ACL of the current entity.}
\item{include_container_content}{(bool) If True, delete ACLs from contents directly within containers (files and folders inside self). This must be set to True for recursive to have any effect. Defaults to False.}
\item{recursive}{(bool) If True and the entity is a container (e.g., Project or Folder), recursively process child containers. Note that this must be used with include_container_content=True to have any effect. Setting recursive=True with include_container_content=False will raise a ValueError. Only works on classes that support the \code{sync_from_synapse_async} method.}
\item{target_entity_types}{(Optional[list[str]]) Specify which entity types to process when deleting ACLs. Allowed values are "folder", "file", "project", "table", "entityview", "materializedview", "virtualtable", "dataset", "datasetcollection", "submissionview" (case-insensitive). If None, defaults to ["folder", "file"]. This does not affect the entity type of the current entity, which is always processed if \code{include_self=True}.}
\item{dry_run}{(bool) If True, log the changes that would be made instead of actually performing the deletions. When enabled, all ACL deletion operations are simulated and logged at info level. Defaults to False.}
\item{show_acl_details}{(bool) When dry_run=True, controls whether current ACL details are displayed for entities that will have their permissions changed. If True (default), shows detailed ACL information. If False, hides ACL details for cleaner output. Has no effect when dry_run=False.}
\item{show_files_in_containers}{(bool) When dry_run=True, controls whether files within containers are displayed in the preview. If True (default), shows all files. If False, hides files when their only change is benefactor inheritance (but still shows files with local ACLs being deleted). Has no effect when dry_run=False.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
\item{_benefactor_tracker}{(Optional[BenefactorTracker]) Internal use tracker for managing benefactor relationships. Used for recursive functionality to track which entities will be affected}
}
\value{
None
}
\section{Errors}{
ValueError: If the entity does not have an ID or if an invalid entity type is provided.
    SynapseHTTPError: If there are permission issues or if the entity already inherits permissions.
    Exception: For any other errors that may occur during the process.
}
\note{
The caller must be granted ACCESS_TYPE.CHANGE_PERMISSIONS on the Entity to
call this method.
}
\examples{
\dontrun{
## Example 1: Delete permissions for a single entity
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File

    syn = Synapse()
    syn.login()

    async def main():
        await File(id="syn123").delete_permissions_async()

    asyncio.run(main())

## Example 2: Delete permissions recursively for a folder and all its children
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Folder

    syn = Synapse()
    syn.login()

    async def main():
        # Delete permissions for this folder only (does not affect children)
        await Folder(id="syn123").delete_permissions_async()

        # Delete permissions for all files and folders directly within this folder,
        # but not the folder itself
        await Folder(id="syn123").delete_permissions_async(
            include_self=False,
            include_container_content=True
        )

        # Delete permissions for all items in the entire hierarchy (folders and their files)
        # Both recursive and include_container_content must be True
        await Folder(id="syn123").delete_permissions_async(
            recursive=True,
            include_container_content=True
        )

        # Delete permissions only for folder entities within this folder recursively
        # and their contents
        await Folder(id="syn123").delete_permissions_async(
            recursive=True,
            include_container_content=True,
            target_entity_types=["folder"]
        )

        # Delete permissions only for files within this folder and all subfolders
        await Folder(id="syn123").delete_permissions_async(
            include_self=False,
            recursive=True,
            include_container_content=True,
            target_entity_types=["file"]
        )

        # Delete permissions for specific entity types (e.g., tables and views)
        await Folder(id="syn123").delete_permissions_async(
            recursive=True,
            include_container_content=True,
            target_entity_types=["table", "entityview", "materializedview"]
        )

        # Dry run example: Log what would be deleted without making changes
        await Folder(id="syn123").delete_permissions_async(
            recursive=True,
            include_container_content=True,
            dry_run=True
        )
    asyncio.run(main())
}
}
\keyword{Table}

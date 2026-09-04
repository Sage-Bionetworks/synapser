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
Delete the entire **local** Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.

In order to remove permissions for a specific user or group, you
should use the \code{synSetPermissions()} function with the \code{access_type} set to
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
\item{include_self}{(bool) If TRUE (default), delete the ACL of the current entity. If FALSE, skip deleting the ACL of the current entity.}
\item{include_container_content}{(bool) If TRUE, delete ACLs from contents directly within containers (files and folders inside self). This must be set to TRUE for recursive to have any effect. Defaults to FALSE.}
\item{recursive}{(bool) If TRUE and the entity is a container (e.g., Project or Folder), recursively process child containers. Note that this must be used with include_container_content=TRUE to have any effect. Setting recursive=TRUE with include_container_content=FALSE will raise an error. Only works on classes that support the \code{synSyncFromSynapse()} function.}
\item{target_entity_types}{(Optional[list[str]]) Specify which entity types to process when deleting ACLs. Allowed values are "folder", "file", "project", "table", "entityview", "materializedview", "virtualtable", "dataset", "datasetcollection", "submissionview" (case-insensitive). If NULL, defaults to list("folder", "file"). This does not affect the entity type of the current entity, which is always processed if \code{include_self=TRUE}.}
\item{dry_run}{(bool) If TRUE, log the changes that would be made instead of actually performing the deletions. When enabled, all ACL deletion operations are simulated and logged at info level. Defaults to FALSE.}
\item{show_acl_details}{(bool) When dry_run=TRUE, controls whether current ACL details are displayed for entities that will have their permissions changed. If TRUE (default), shows detailed ACL information. If FALSE, hides ACL details for cleaner output. Has no effect when dry_run=FALSE.}
\item{show_files_in_containers}{(bool) When dry_run=TRUE, controls whether files within containers are displayed in the preview. If TRUE (default), shows all files. If FALSE, hides files when their only change is benefactor inheritance (but still shows files with local ACLs being deleted). Has no effect when dry_run=FALSE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
\item{_benefactor_tracker}{(Optional[BenefactorTracker]) Internal use tracker for managing benefactor relationships. Used for recursive functionality to track which entities will be affected}
}
\value{
NULL
}
\section{Errors}{
An error is raised if the entity does not have an ID or if an invalid entity type is provided.
An error is also raised if there are permission issues or if the entity already inherits permissions.
An error may also be raised for any other issues that occur during the process.
}
\note{
The caller must be granted CHANGE_PERMISSIONS access on the Entity to
call this method.
}
\examples{
\dontrun{
## Example 1: Delete permissions for a single entity
    library(synapser)
    synLogin()

    File(id = "syn123") |> synDeletePermissions()

## Example 2: Delete permissions recursively for a folder and all its children
    library(synapser)
    synLogin()

    # Delete permissions for this folder only (does not affect children)
    Folder(id = "syn123") |> synDeletePermissions()

    # Delete permissions for all files and folders directly within this folder,
    # but not the folder itself and not files within its subfolder
    Folder(id = "syn123") |> synDeletePermissions(
        include_self = FALSE,
        include_container_content = TRUE
    )

    # Delete permissions for all items in the entire hierarchy (folders and their files)
    # Both recursive and include_container_content must be TRUE
    Folder(id = "syn123") |> synDeletePermissions(
        recursive = TRUE,
        include_container_content = TRUE
    )

    # Delete permissions only for folder entities within this folder recursively
    # and their contents
    Folder(id = "syn123") |> synDeletePermissions(
        recursive = TRUE,
        include_container_content = TRUE,
        target_entity_types = list("folder")
    )

    # Delete permissions only for files within this folder and all subfolders
    Folder(id = "syn123") |> synDeletePermissions(
        include_self = FALSE,
        recursive = TRUE,
        include_container_content = TRUE,
        target_entity_types = list("file")
    )

    # Delete permissions for specific entity types (e.g., tables and views)
    Folder(id = "syn123") |> synDeletePermissions(
        recursive = TRUE,
        include_container_content = TRUE,
        target_entity_types = list("table", "entityview", "materializedview")
    )

    # Dry run example: Log what would be deleted without making changes
    Folder(id = "syn123") |> synDeletePermissions(
        recursive = TRUE,
        include_container_content = TRUE,
        dry_run = TRUE
    )
}
}
\keyword{Table}

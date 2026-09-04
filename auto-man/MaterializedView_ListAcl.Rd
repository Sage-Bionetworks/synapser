%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synListAcl}
\alias{synListAcl}
\docType{methods}
\title{
MaterializedView :  list_acl
}
\description{
List the Access Control Lists (ACLs) for this entity and optionally its children.

This function returns the local sharing settings for the entity and optionally
its children. It provides a mapping of all ACLs for the given container/entity.

**Important Note:** This function returns the LOCAL sharing settings only, not
the effective permissions that each Synapse User ID/Team has on the entities.
More permissive permissions could be granted via a Team that the user has access
to that has permissions on the entity, or through inheritance from parent entities.
}
\usage{
synListAcl(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL, _progress_bar=NULL)
}
\arguments{
\item{instance}{(MaterializedView) The MaterializedView instance to operate on.}
\item{recursive}{(bool) If True and the entity is a container (e.g., Project or Folder), recursively process child containers. Note that this must be used with include_container_content=True to have any effect. Setting recursive=True with include_container_content=False will raise a ValueError. Only works on classes that support the \code{sync_from_synapse_async} method.}
\item{include_container_content}{(bool) If True, include ACLs from contents directly within containers (files and folders inside self). This must be set to True for recursive to have any effect. Defaults to False.}
\item{target_entity_types}{(Optional[list[str]]) Specify which entity types to process when listing ACLs. Allowed values are "folder", "file", "project", "table", "entityview", "materializedview", "virtualtable", "dataset", "datasetcollection", "submissionview" (case-insensitive). If None, defaults to ["folder", "file"].}
\item{log_tree}{(bool) If True, logs the ACL results to console in ASCII tree format showing entity hierarchies and their ACL permissions in a tree-like structure. Defaults to False.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
\item{_progress_bar}{(Optional[tqdm]) Internal parameter. Progress bar instance to use for updates when called recursively. Should not be used by external callers.}
}
\value{
An AclListResult object containing a structured representation of ACLs where:
    - entity_acls: A list of EntityAcl objects, each representing one entity's ACL
    - Each EntityAcl contains acl_entries (a list of AclEntry objects)
    - Each AclEntry contains the principal_id and their list of permissions
}
\section{Errors}{
ValueError: If the entity does not have an ID or if an invalid entity type is provided.
    SynapseHTTPError: If there are permission issues accessing ACLs.
    Exception: For any other errors that may occur during the process.
}
\examples{
\dontrun{
## Example 1: List ACLs for a single entity
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File

    syn = Synapse()
    syn.login()

    async def main():
        acl_result = await File(id="syn123").list_acl_async()
        print(acl_result)

        # Access entity ACLs (entity_acls is a list, not a dict)
        for entity_acl in acl_result.all_entity_acls:
            if entity_acl.entity_id == "syn123":
                # Access individual ACL entries
                for acl_entry in entity_acl.acl_entries:
                    if acl_entry.principal_id == "273948":
                        print(f"Principal 273948 has permissions: {acl_entry.permissions}")

        # I can also access the ACL for the file itself
        print(acl_result.entity_acl)

        print(acl_result)

    asyncio.run(main())

## Example 2: List ACLs recursively for a folder and all its children
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Folder

    syn = Synapse()
    syn.login()

    async def main():
        acl_result = await Folder(id="syn123").list_acl_async(
            recursive=True,
            include_container_content=True
        )

        # Access each entity's ACL (entity_acls is a list)
        for entity_acl in acl_result.all_entity_acls:
            print(f"Entity {entity_acl.entity_id} has ACL with {len(entity_acl.acl_entries)} principals")

        # I can also access the ACL for the folder itself
        print(acl_result.entity_acl)

        # List ACLs for only folder entities
        folder_acl_result = await Folder(id="syn123").list_acl_async(
            recursive=True,
            include_container_content=True,
            target_entity_types=["folder"]
        )

        # List ACLs for specific entity types (e.g., tables and views)
        table_view_acl_result = await Folder(id="syn123").list_acl_async(
            recursive=True,
            include_container_content=True,
            target_entity_types=["table", "entityview", "materializedview"]
        )

    asyncio.run(main())

## Example 3: List ACLs with ASCII tree visualization
    # When \code{log_tree=True}, the ACLs will be logged in a tree format. Additionally,
    # the \code{ascii_tree} attribute of the AclListResult will contain the ASCII tree
    # representation of the ACLs.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Folder

    syn = Synapse()
    syn.login()

    async def main():
        acl_result = await Folder(id="syn123").list_acl_async(
            recursive=True,
            include_container_content=True,
            log_tree=True, # Enable ASCII tree logging
        )

        # The ASCII tree representation of the ACLs will also be available
        # in acl_result.ascii_tree
        print(acl_result.ascii_tree)

    asyncio.run(main())
}
}
\keyword{MaterializedView}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synListAcl}
\alias{Project_synListAcl}
\docType{methods}
\title{
Project :  list_acl
}
\description{
List the Access Control Lists (ACLs) for this entity and optionally its children.

This function returns the local sharing settings for the entity and optionally
its children. It provides a mapping of all ACLs for the given container/entity.

\strong{Important Note:} This function returns the LOCAL sharing settings only, not
the effective permissions that each Synapse User ID/Team has on the entities.
More permissive permissions could be granted via a Team that the user has access
to that has permissions on the entity, or through inheritance from parent entities.
}
\usage{
synListAcl(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{recursive}{(bool) If TRUE and the entity is a container (e.g., Project or Folder), recursively process child containers. Note that this must be used with include_container_content=TRUE to have any effect. Setting recursive=TRUE with include_container_content=FALSE will raise an error. Only works on classes that support the \code{\link[=synSyncFromSynapse]{synSyncFromSynapse}()} function.}
\item{include_container_content}{(bool) If TRUE, include ACLs from contents directly within containers (files and folders inside self). This must be set to TRUE for recursive to have any effect. Defaults to FALSE.}
\item{target_entity_types}{(Optional[list[str]]) Specify which entity types to process when listing ACLs. Allowed values are "folder", "file", "project", "table", "entityview", "materializedview", "virtualtable", "dataset", "datasetcollection", "submissionview" (case-insensitive). If NULL, defaults to list("folder", "file").}
\item{log_tree}{(bool) If TRUE, logs the ACL results to console in ASCII tree format showing entity hierarchies and their ACL permissions in a tree-like structure. Defaults to FALSE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
An AclListResult object containing a structured representation of ACLs where:
    - entity_acls: A list of EntityAcl objects, each representing one entity's ACL\cr
    - Each EntityAcl contains acl_entries (a list of AclEntry objects)\cr
    - Each AclEntry contains the principal_id and their list of permissions
}
\section{Errors}{
- An error is raised if the entity does not have an ID or if an invalid entity type is provided.\cr
- An error is also raised if there are permission issues accessing ACLs.\cr
- An error may also be raised for any other issues that occur during the process.
}
\examples{
\dontrun{
## Example 1: List ACLs for a single entity
    library(synapser)
    synLogin()

    acl_result = Project(id = "syn123") |> synListAcl()
    acl_result

    # Access entity ACLs (entity_acls is a list, not a named list)
    for (entity_acl in acl_result$all_entity_acls) {
        if (entity_acl$entity_id == "syn123") {
            # Access individual ACL entries
            for (acl_entry in entity_acl$acl_entries) {
                if (acl_entry$principal_id == "273948") {
                    cat(sprintf("Principal 273948 has permissions: \%s\n", acl_entry$permissions))
                }
            }
        }
    }

    # I can also access the ACL for the file itself
    acl_result$entity_acl

    acl_result

## Example 2: List ACLs recursively for a folder and all its children
    library(synapser)
    synLogin()

    acl_result = Folder(id = "syn123") |> synListAcl(
        recursive = TRUE,
        include_container_content = TRUE
    )

    # Access each entity's ACL (entity_acls is a list)
    for (entity_acl in acl_result$all_entity_acls) {
        cat(sprintf("Entity \%s has ACL with \%d principals\n", entity_acl$entity_id, length(entity_acl$acl_entries)))
    }

    # I can also access the ACL for the folder itself
    acl_result$entity_acl

    # List ACLs for only folder entities
    folder_acl_result = Folder(id = "syn123") |> synListAcl(
        recursive = TRUE,
        include_container_content = TRUE,
        target_entity_types = list("folder")
    )

    # List ACLs for specific entity types (e.g., tables and views)
    table_view_acl_result = Folder(id = "syn123") |> synListAcl(
        recursive = TRUE,
        include_container_content = TRUE,
        target_entity_types = list("table", "entityview", "materializedview")
    )

## Example 3: List ACLs with ASCII tree visualization
    # When log_tree = TRUE, the ACLs will be logged in a tree format. Additionally,
    # the ascii_tree attribute of the AclListResult will contain the ASCII tree
    # representation of the ACLs.
    library(synapser)
    synLogin()

    acl_result = Folder(id = "syn123") |> synListAcl(
        recursive = TRUE,
        include_container_content = TRUE,
        log_tree = TRUE # Enable ASCII tree logging
    )

    # The ASCII tree representation of the ACLs will also be available
    # in acl_result$ascii_tree
    acl_result$ascii_tree
}
}
\keyword{Project}

# DatasetCollection : list_acl

List the Access Control Lists (ACLs) for this entity and optionally its
children.

This function returns the local sharing settings for the entity and
optionally its children. It provides a mapping of all ACLs for the given
container/entity.

**Important Note:** This function returns the LOCAL sharing settings
only, not the effective permissions that each Synapse User ID/Team has
on the entities. More permissive permissions could be granted via a Team
that the user has access to that has permissions on the entity, or
through inheritance from parent entities.

## Usage

``` r
synListAcl(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)
```

## Arguments

- instance:

  (DatasetCollection) The DatasetCollection instance to operate on.

- recursive:

  (logical) If TRUE and the entity is a container (e.g., Project or
  Folder), recursively process child containers. Note that this must be
  used with include_container_content=TRUE to have any effect. Setting
  recursive=TRUE with include_container_content=FALSE will raise an
  error. Only works on classes that support the `synSyncFromSynapse()`
  function.

- include_container_content:

  (logical) If TRUE, include ACLs from contents directly within
  containers (files and folders inside self). This must be set to TRUE
  for recursive to have any effect. Defaults to FALSE.

- target_entity_types:

  (Optional\[list\[character\]\]) Specify which entity types to process
  when listing ACLs. Allowed values are "folder", "file", "project",
  "table", "entityview", "materializedview", "virtualtable", "dataset",
  "datasetcollection", "submissionview" (case-insensitive). If NULL,
  defaults to list("folder", "file").

- log_tree:

  (logical) If TRUE, logs the ACL results to console in ASCII tree
  format showing entity hierarchies and their ACL permissions in a
  tree-like structure. Defaults to FALSE.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

An AclListResult object containing a structured representation of ACLs
where:  
- all_entity_acls: A list of EntityAcl objects, each representing one
entity's ACL  
- Each EntityAcl contains acl_entries (a list of AclEntry objects)  
- Each AclEntry contains the principal_id and their list of permissions

## Errors

\- An error is raised if the entity does not have an ID or if an invalid
entity type is provided.  
- An error is also raised if there are permission issues accessing
ACLs.  
- An error may also be raised for any other issues that occur during the
process.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: List ACLs for a single entity
    library(synapser)
    synLogin()

    acl_result = DatasetCollection(id = "syn123") |> synListAcl()
    print(acl_result)

    # Access entity ACLs (all_entity_acls is a list, not a named list)
    for (entity_acl in acl_result$all_entity_acls) {
        if (entity_acl$entity_id == "syn123") {
            # Access individual ACL entries
            for (acl_entry in entity_acl$acl_entries) {
                if (acl_entry$principal_id == "273948") {
                    print(sprintf("Principal 273948 has permissions: %s", paste(unlist(acl_entry$permissions), collapse = ", ")))
                }
            }
        }
    }

    # I can also access the ACL for the dataset collection itself
    print(acl_result$entity_acl)

    print(acl_result)

## Example 2: List ACLs recursively for a folder and all its children
    library(synapser)
    synLogin()

    acl_result = Folder(id = "syn123") |> synListAcl(
        recursive = TRUE,
        include_container_content = TRUE
    )

    # Access each entity's ACL (all_entity_acls is a list)
    for (entity_acl in acl_result$all_entity_acls) {
        print(sprintf("Entity %s has ACL with %d principals", entity_acl$entity_id, length(entity_acl$acl_entries)))
    }

    # I can also access the ACL for the folder itself
    print(acl_result$entity_acl)

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
    print(acl_result$ascii_tree)
} # }
```

# Project

A Project is a top-level container for organizing data in Synapse.

## Usage

``` r
Project(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, alias=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), searchindexes=list(), annotations=list(), create_or_update=TRUE, parent_id=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique immutable ID for this project. A new ID
  will be generated for new Projects. Once issued, this ID is guaranteed
  to never change or be re-issued

- name:

  (Optional\[str\]) The name of this project. Must be 256 characters or
  less. Names may only contain: letters, numbers, spaces, underscores,
  hyphens, periods, plus signs, apostrophes, and parentheses

- description:

  (Optional\[str\]) The description of this entity. Must be 1000
  characters or less.

- etag:

  (Optional\[str\]) Synapse employs an Optimistic Concurrency Control
  (OCC) scheme to handle concurrent updates. Since the E-Tag changes
  every time an entity is updated it is used to detect when a client's
  current representation of an entity is out-of-date.

- created_on:

  (Optional\[str\]) The date this entity was created.

- modified_on:

  (Optional\[str\]) The date this entity was last modified.

- created_by:

  (Optional\[str\]) The ID of the user that created this entity.

- modified_by:

  (Optional\[str\]) The ID of the user that last modified this entity.

- alias:

  (Optional\[str\]) The project alias for use in friendly project urls.

- files:

  (list\[File\]) Any files that are at the root directory of the
  project.

- folders:

  (list\[Folder\]) Any folders that are at the root directory of the
  project.

- tables:

  (list\[Table\]) Any tables that are at the root directory of the
  project.

- entityviews:

  (list\[EntityView\]) Any entity views that are at the root directory
  of the project.

- submissionviews:

  (list\[SubmissionView\]) Any submission views that are at the root
  directory of the project.

- datasets:

  (list\[Dataset\]) Any datasets that are at the root directory of the
  project.

- datasetcollections:

  (list\[DatasetCollection\]) Any dataset collections that are at the
  root directory of the project.

- materializedviews:

  (list\[MaterializedView\]) Any materialized views that are at the root
  directory of the project.

- virtualtables:

  (list\[VirtualTable\]) Any virtual tables that are at the root
  directory of the project.

- searchindexes:

  (list\[SearchIndex\]) Any search indexes that are at the root
  directory of the project.

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Additional metadata
  associated with the project. The key is the name of your desired
  annotations. The value is an object containing a list of values (use
  empty list to represent no values for key) and the value type
  associated with all values in the list. To remove all annotations set
  this to an empty named list
  [`list()`](https://rdrr.io/r/base/list.html) or NULL and store the
  entity.

- create_or_update:

  (bool) (Store only) Indicates whether the method should automatically
  perform an update if the resource conflicts with an existing Synapse
  object. When TRUE this means that any changes to the resource will be
  non-destructive.  
    
  This boolean is ignored if you've already stored or retrieved the
  resource from Synapse for this instance at least once. Any changes to
  the resource will be destructive in this case. For example if you want
  to delete the content for a field you will need to call
  [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md)
  and then modify the field.

- parent_id:

  (Optional\[str\]) The parent ID of the project. In practice projects
  do not have a parent, but this is required for the inner workings of
  Synapse.

## Value

NULL

## Methods

- `Project(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, alias=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), searchindexes=list(), annotations=list(), create_or_update=TRUE, parent_id=NULL)`:
  Constructor for `Project`

- [`synBindSchema`](https://r-docs.synapse.org/latest/reference/Project_BindSchema.md)`(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)`:
  Bind a JSON schema to the entity.

- [`synCopy`](https://r-docs.synapse.org/latest/reference/Project_Copy.md)`(instance, destination_id, copy_annotations=TRUE, copy_wiki=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)`:
  You must have already created the Project you will be copying to. It
  will have its own Synapse ID and unique name that you will use as the
  destination_id.  
    
  Copy the project to another Synapse project. This will recursively
  copy all Tables, Links, Files, and Folders within the project.

- [`synDeletePermissions`](https://r-docs.synapse.org/latest/reference/Project_DeletePermissions.md)`(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)`:
  Delete the entire **local** Access Control List (ACL) for a given
  Entity. This is not scoped to a specific user or group, but rather
  removes all permissions associated with the Entity. After this
  operation, the Entity will inherit permissions from its benefactor,
  which is typically its parent entity or the Project it belongs to.  
    
  In order to remove permissions for a specific user or group, you
  should use the
  [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/Project_SetPermissions.md)
  function with the `access_type` set to an empty list.  
    
  By default, Entities such as FileEntity and Folder inherit their
  permission from their containing Project. For such Entities the
  Project is the Entity's 'benefactor'. This permission inheritance can
  be overridden by creating an ACL for the Entity. When this occurs the
  Entity becomes its own benefactor and all permission are determined by
  its own ACL.  
    
  If the ACL of an Entity is deleted, then its benefactor will
  automatically be set to its parent's benefactor.  
    
  **Special notice for Projects:** The ACL for a Project cannot be
  deleted, you must individually update or revoke the permissions for
  each user or group.

- [`synDeleteProjectSetting`](https://r-docs.synapse.org/latest/reference/Project_DeleteProjectSetting.md)`(instance, setting_id, synapse_client=NULL)`:
  Delete a project setting by its setting ID.

- [`synFlattenFileList`](https://r-docs.synapse.org/latest/reference/Project_FlattenFileList.md)`(instance)`:
  Recursively loop over all of the already retrieved files and folders
  and return a list of all files in the container.

- [`synGenerateSyncManifest`](https://r-docs.synapse.org/latest/reference/Project_GenerateSyncManifest.md)`(instance, directory_path, manifest_path, synapse_client=NULL)`:
  Walk a local directory, mirror its folder hierarchy under this
  container in Synapse, and write a CSV manifest ready for
  [`synSyncToSynapse()`](https://r-docs.synapse.org/latest/reference/Project_SyncToSynapse.md).  
    
  The manifest has two columns: path (absolute, symlink-resolved) and
  parentId (the Synapse ID of the file's containing folder). Existing
  Synapse folders with matching names and parents are reused. Directory
  symlinks inside directory_path are not followed; file symlinks record
  the symlink path and upload the target's contents. Zero-byte files are
  skipped with a warning — Synapse rejects empty files. I/O errors
  during walk are logged and skipped; an empty source directory produces
  a warning and a header-only manifest.

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/Project_GetAcl.md)`(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`:
  Get the
  [ACL](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)
  that a user or group has on an Entity.

- [`synGetInvalidValidation`](https://r-docs.synapse.org/latest/reference/Project_GetInvalidValidation.md)`(instance, synapse_client=NULL)`:
  Get invalid JSON schema validation results for the child entities of a
  container entity.

- [`synGetPermissions`](https://r-docs.synapse.org/latest/reference/Project_GetPermissions.md)`(instance, synapse_client=NULL)`:
  Get the
  [permissions](https://python-docs.synapse.org/reference/permissions/)
  that the caller has on an Entity.

- [`synGetProjectSetting`](https://r-docs.synapse.org/latest/reference/Project_GetProjectSetting.md)`(instance, setting_type="upload", synapse_client=NULL)`:
  Get the project setting for this entity.

- [`synGetSchema`](https://r-docs.synapse.org/latest/reference/Project_GetSchema.md)`(instance, synapse_client=NULL)`:
  Get the JSON schema bound to the entity.

- [`synGetSchemaDerivedKeys`](https://r-docs.synapse.org/latest/reference/Project_GetSchemaDerivedKeys.md)`(instance, synapse_client=NULL)`:
  Retrieve derived JSON schema keys for the entity.

- [`synGetSchemaValidationStatistics`](https://r-docs.synapse.org/latest/reference/Project_GetSchemaValidationStatistics.md)`(instance, synapse_client=NULL)`:
  Get validation statistics for a container entity.

- [`synGetStsStorageToken`](https://r-docs.synapse.org/latest/reference/Project_GetStsStorageToken.md)`(instance, permission, output_format="json", min_remaining_life=NULL, synapse_client=NULL)`:
  Get STS (AWS Security Token Service) credentials for direct access to
  the storage location backing this entity. These credentials can be
  used with AWS tools such as the AWS CLI.

- [`synIndexFilesForMigration`](https://r-docs.synapse.org/latest/reference/Project_IndexFilesForMigration.md)`(instance, dest_storage_location_id, db_path=NULL, source_storage_location_ids=NULL, file_version_strategy="new", include_table_files=FALSE, continue_on_error=FALSE, synapse_client=NULL)`:
  Index files in this entity for migration to a new storage location.  
    
  This is the first step in migrating files to a new storage location.
  After indexing, use
  [`synMigrateIndexedFiles()`](https://r-docs.synapse.org/latest/reference/Project_MigrateIndexedFiles.md)
  to perform the actual migration.

- [`synListAcl`](https://r-docs.synapse.org/latest/reference/Project_ListAcl.md)`(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)`:
  List the Access Control Lists (ACLs) for this entity and optionally
  its children.  
    
  This function returns the local sharing settings for the entity and
  optionally its children. It provides a mapping of all ACLs for the
  given container/entity.  
    
  **Important Note:** This function returns the LOCAL sharing settings
  only, not the effective permissions that each Synapse User ID/Team has
  on the entities. More permissive permissions could be granted via a
  Team that the user has access to that has permissions on the entity,
  or through inheritance from parent entities.

- [`synMapDirectoryToAllContainedFiles`](https://r-docs.synapse.org/latest/reference/Project_MapDirectoryToAllContainedFiles.md)`(instance, root_path)`:
  Recursively loop over all of the already retrieved files and folders.
  Then return back a named list where the key is the path to the
  directory at each level. The value is a list of all files in that
  directory AND all files in the child directories.  
    
  This is used during the creation of the manifest TSV file during the
  syncFromSynapse utility function.

- [`synMigrateIndexedFiles`](https://r-docs.synapse.org/latest/reference/Project_MigrateIndexedFiles.md)`(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)`:
  Migrate files that have been indexed with
  [`synIndexFilesForMigration()`](https://r-docs.synapse.org/latest/reference/Project_IndexFilesForMigration.md).  
    
  This is the second step in migrating files to a new storage location.
  Files must first be indexed using
  [`synIndexFilesForMigration()`](https://r-docs.synapse.org/latest/reference/Project_IndexFilesForMigration.md).  
    
  **Interactive confirmation:** When called from an interactive shell
  and `force=FALSE` (the default), this function will print the number
  of items queued for migration and prompt for confirmation before
  proceeding. If standard output is not connected to an interactive
  terminal (e.g. a script or CI environment), migration is aborted
  unless `force=TRUE` is set.

- [`synSetPermissions`](https://r-docs.synapse.org/latest/reference/Project_SetPermissions.md)`(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)`:
  Sets permission that a user or group has on an Entity. An Entity may
  have its own ACL or inherit its ACL from a benefactor.

- [`synSetStorageLocation`](https://r-docs.synapse.org/latest/reference/Project_SetStorageLocation.md)`(instance, storage_location_id=1L, synapse_client=NULL)`:
  Set the upload storage location for this entity. This configures where
  files uploaded to this entity will be stored.  
    
  **This is a destructive update.** The provided `storage_location_id`
  value(s) will **replace** any storage locations previously configured
  on this entity. To add a storage location without removing existing
  ones, first retrieve the current setting with
  [`synGetProjectSetting()`](https://r-docs.synapse.org/latest/reference/Project_GetProjectSetting.md),
  then pass its existing `locations` together with the new ID as
  `storage_location_id`. The first ID in the list is the default upload
  destination.

- [`synSyncFromSynapse`](https://r-docs.synapse.org/latest/reference/Project_SyncFromSynapse.md)`(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy="LOG_EXCEPTION", include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, manifest="all", synapse_client=NULL)`:
  Sync this container and all possible sub-folders from Synapse. By
  default this will download the files that are found and it will
  populate the `files` and `folders` attributes with the found files and
  folders, along with all other entity types (tables, entityviews, etc.)
  present in the container. If you only want to retrieve the full tree
  of metadata about your container specify `download_file` as FALSE.  
    
  This works similarly to the legacy
  [synapseutils.syncFromSynapse](https://python-docs.synapse.org/reference/synapse_utils/)
  utility function, and generates a `manifest.csv` file in each synced
  directory. The manifest uses CSV format with `parentId` and `ID`
  columns, interoperable with the Synapse UI download cart and
  [`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md)
  output.  
    
  Supports syncing Files, Folders, Tables, EntityViews, SubmissionViews,
  Datasets, DatasetCollections, MaterializedViews, and VirtualTables
  from Synapse. The metadata for these entity types will be populated in
  their respective attributes (`files`, `folders`, `tables`,
  `entityviews`, `submissionviews`, `datasets`, `datasetcollections`,
  `materializedviews`, `virtualtables`) if they are found within the
  container.

- [`synSyncToSynapse`](https://r-docs.synapse.org/latest/reference/Project_SyncToSynapse.md)`(instance, manifest_path, dry_run=FALSE, send_messages=TRUE, retries=4L, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_client=NULL)`:
  Upload files to Synapse using a manifest CSV file.  
    
  Accepts manifests produced by
  [`synSyncFromSynapse()`](https://r-docs.synapse.org/latest/reference/Project_SyncFromSynapse.md),
  [`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md),
  or the Synapse UI download cart. The manifest must have at minimum a
  path and parentId column. All other columns that are not part of the
  standard manifest column set are treated as file annotations.  
    
  Standard manifest columns: ID, name, parentId, contentType, path,
  synapseStore, activityName, activityDescription, forceVersion, used,
  executed

- [`synUnbindSchema`](https://r-docs.synapse.org/latest/reference/Project_UnbindSchema.md)`(instance, synapse_client=NULL)`:
  Unbind the JSON schema bound to the entity.

- [`synValidateSchema`](https://r-docs.synapse.org/latest/reference/Project_ValidateSchema.md)`(instance, synapse_client=NULL)`:
  Validate the entity against the bound JSON schema.

- [`synWalk`](https://r-docs.synapse.org/latest/reference/Project_Walk.md)`(instance, follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL)`:
  Traverse through the hierarchy of entities stored under this
  container. Mimics os.walk() behavior but yields EntityHeader objects,
  with optional ASCII tree display that continues printing as the walk
  progresses.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Creating a project
    # This example shows how to create a project
    library(synapser)
    synLogin()

    my_annotations = list(
        my_single_key_string = "a",
        my_key_string = list("b", "a", "c")
    )
    project = Project(
        name = "My unique project name",
        annotations = my_annotations,
        description = "This is a project with random data."
    )

    project = project |> synStore()

    project

## Example 2: Storing several files to a project
    # This example shows how to store several files to a project
    file_1 = File(
        path = path_to_file_1,
        name = name_of_file_1
    )
    file_2 = File(
        path = path_to_file_2,
        name = name_of_file_2
    )
    project$files = list(file_1, file_2)
    project = project |> synStore()
} # }
```

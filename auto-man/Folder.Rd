%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Folder}
\alias{Folder}
\docType{class}
\title{
Folder
}
\format{An S3-style class object.}
\description{
Folder is a hierarchical container for organizing data in Synapse.
}
\usage{
Folder(id=NULL, name=NULL, parent_id=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), searchindexes=list(), annotations=list(), is_restricted=FALSE, create_or_update=TRUE)
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this folder. A new ID will be generated for new Folders. Once issued, this ID is guaranteed to never change or be re-issued.}
\item{name}{(Optional[str]) The name of this folder. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses.}
\item{parent_id}{(Optional[str]) The ID of the Project or Folder that is the parent of this Folder.}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{etag}{(Optional[str]) (Read Only) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) (Read Only) The date this entity was created.}
\item{modified_on}{(Optional[str]) (Read Only) The date this entity was last modified.}
\item{created_by}{(Optional[str]) (Read Only) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) (Read Only) The ID of the user that last modified this entity.}
\item{files}{(list[ForwardRef('File')]) Files that exist within this folder.}
\item{folders}{(list[ForwardRef('Folder')]) Folders that exist within this folder.}
\item{tables}{(list[ForwardRef('Table')]) Tables that exist within this folder.}
\item{entityviews}{(list[ForwardRef('EntityView')]) Entity views that exist within this folder.}
\item{submissionviews}{(list[ForwardRef('SubmissionView')]) Submission views that exist within this folder.}
\item{datasets}{(list[ForwardRef('Dataset')]) Datasets that exist within this folder.}
\item{datasetcollections}{(list[ForwardRef('DatasetCollection')]) Dataset collections that exist within this folder.}
\item{materializedviews}{(list[ForwardRef('MaterializedView')]) Materialized views that exist within this folder.}
\item{virtualtables}{(list[ForwardRef('VirtualTable')]) Virtual tables that exist within this folder.}
\item{searchindexes}{(list[ForwardRef('SearchIndex')]) Search indexes that exist within this folder.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the folder. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
\item{is_restricted}{}
\item{create_or_update}{(bool) (Store only) Indicates whether the method should automatically perform an update if the resource conflicts with an existing Synapse object. When True this means that any changes to the resource will be non-destructive.\cr
\cr
This boolean is ignored if you've already stored or retrieved the resource from Synapse for this instance at least once. Any changes to the resource will be destructive in this case. For example if you want to delete the content for a field you will need to call \code{.get()} and then modify the field.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Folder(id=NULL, name=NULL, parent_id=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), searchindexes=list(), annotations=list(), is_restricted=FALSE, create_or_update=TRUE)}: Constructor for \code{\link{Folder}}
\item \code{synBindSchema(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{synCopy(instance, parent_id, copy_annotations=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)}: Copy the folder to another Synapse location. This will recursively copy all\cr
Tables, Links, Files, and Folders within the folder.
\item \code{synDeletePermissions(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire Access Control List (ACL) for a given Entity. This is not\cr
scoped to a specific user or group, but rather removes all permissions\cr
associated with the Entity. After this operation, the Entity will inherit\cr
permissions from its benefactor, which is typically its parent entity or\cr
the Project it belongs to.\cr
\cr
In order to remove permissions for a specific user or group, you\cr
should use the \code{set_permissions_async} method with the \code{access_type} set to\cr
an empty list.\cr
\cr
By default, Entities such as FileEntity and Folder inherit their permission from\cr
their containing Project. For such Entities the Project is the Entity's 'benefactor'.\cr
This permission inheritance can be overridden by creating an ACL for the Entity.\cr
When this occurs the Entity becomes its own benefactor and all permission are\cr
determined by its own ACL.\cr
\cr
If the ACL of an Entity is deleted, then its benefactor will automatically be set\cr
to its parent's benefactor.\cr
\cr
**Special notice for Projects:** The ACL for a Project cannot be deleted, you\cr
must individually update or revoke the permissions for each user or group.
\item \code{synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)}: Delete a project setting by its setting ID.
\item \code{synFlattenFileList(instance)}: Recursively loop over all of the already retrieved files and folders and return\cr
a list of all files in the container.
\item \code{synGenerateSyncManifest(instance, directory_path, manifest_path, synapse_client=NULL)}: Walk a local directory, mirror its folder hierarchy under this\cr
container in Synapse, and write a CSV manifest ready for\cr
[sync_to_synapse_async][synapseclient.models.mixins.StorableContainer.sync_to_synapse_async].\cr
\cr
The manifest has two columns: path (absolute, symlink-resolved) and\cr
parentId (the Synapse ID of the file's containing folder). Existing\cr
Synapse folders with matching names and parents are reused. Directory\cr
symlinks inside directory_path are not followed; file symlinks record\cr
the symlink path and upload the target's contents. Zero-byte files are\cr
skipped with a warning — Synapse rejects empty files. I/O errors during\cr
walk are logged and skipped; an empty source directory produces a\cr
warning and a header-only manifest.
\item \code{synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{synGetInvalidValidation(instance, synapse_client=NULL)}: Get invalid JSON schema validation results for a container entity.
\item \code{synGetPermissions(instance, synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{synGetProjectSetting(instance, setting_type="upload", synapse_client=NULL)}: Get the project setting for this entity.
\item \code{synGetSchema(instance, synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{synGetSchemaDerivedKeys(instance, synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{synGetSchemaValidationStatistics(instance, synapse_client=NULL)}: Get validation statistics for a container entity.
\item \code{synGetStsStorageToken(instance, permission, output_format="json", min_remaining_life=NULL, synapse_client=NULL)}: Get STS (AWS Security Token Service) credentials for direct access to\cr
the storage location backing this entity. These credentials can be used\cr
with AWS tools like awscli and boto3.
\item \code{synIndexFilesForMigration(instance, dest_storage_location_id, db_path=NULL, source_storage_location_ids=NULL, file_version_strategy="new", include_table_files=FALSE, continue_on_error=FALSE, synapse_client=NULL)}: Index files in this entity for migration to a new storage location.\cr
\cr
This is the first step in migrating files to a new storage location.\cr
After indexing, use \code{migrate_indexed_files} to perform the actual migration.
\item \code{synListAcl(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{synMapDirectoryToAllContainedFiles(instance, root_path)}: Recursively loop over all of the already retrieved files and folders. Then\cr
return back a dictionary where the key is the path to the directory at each\cr
level. The value is a list of all files in that directory AND all files in\cr
the child directories.\cr
\cr
This is used during the creation of the manifest TSV file during the\cr
syncFromSynapse utility function.
\item \code{synMigrateIndexedFiles(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)}: Migrate files that have been indexed with \code{index_files_for_migration}.\cr
\cr
This is the second step in migrating files to a new storage location.\cr
Files must first be indexed using \code{index_files_for_migration}.\cr
\cr
**Interactive confirmation:** When called from an interactive shell and\cr
`\code{force=False}\code{ (the default), this method will print the number of items\cr
queued for migration and prompt for confirmation before proceeding. If\cr
standard output is not connected to an interactive terminal (e.g. a script\cr
or CI environment), migration is aborted unless }\code{force=True}` is set.
\item \code{synSetPermissions(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{synSetStorageLocation(instance, storage_location_id=1L, synapse_client=NULL)}: Set the upload storage location for this entity. This configures where\cr
files uploaded to this entity will be stored.\cr
\cr
**This is a destructive update.** The provided \code{storage_location_id} value(s)\cr
will **replace** any storage locations previously configured on this entity.\cr
To add a storage location without removing existing ones, first retrieve the\cr
current setting via \code{get_project_setting_async}, append to its \code{locations}\cr
list, and call \code{store_async} on the returned \code{ProjectSetting} directly.\cr
The first ID in the list is the default upload destination.\cr
To obtain a storage location ID, create a\cr
[StorageLocation][synapseclient.models.StorageLocation] and use its\cr
\code{storage_location_id}. See\cr
[StorageLocationType][synapseclient.models.StorageLocationType] for the\cr
available storage backend types.
\item \code{synSyncFromSynapse(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy=FailureStrategy.LOG_EXCEPTION, include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, manifest="all", synapse_client=NULL)}: Sync this container and all possible sub-folders from Synapse. By default this\cr
will download the files that are found and it will populate the\cr
\code{files} and \code{folders} attributes with the found files and folders, along with\cr
all other entity types (tables, entityviews, etc.) present in the container.\cr
If you only want to retrieve the full tree of metadata about your\cr
container specify \code{download_file} as False.\cr
\cr
This works similar to \code{\link[=synSyncFromSynapse]{synSyncFromSynapse}}, and generates a\cr
\code{manifest.csv} file in each synced directory. The manifest uses CSV format\cr
with \code{parentId} and \code{ID} columns, interoperable with the Synapse UI download\cr
cart and \code{synapse get-download-list} CLI output.\cr
\cr
Supports syncing Files, Folders, Tables, EntityViews, SubmissionViews, Datasets,\cr
DatasetCollections, MaterializedViews, and VirtualTables from Synapse. The\cr
metadata for these entity types will be populated in their respective\cr
attributes (\code{files}, \code{folders}, \code{tables}, \code{entityviews}, \code{submissionviews},\cr
\code{datasets}, \code{datasetcollections}, \code{materializedviews}, \code{virtualtables}) if\cr
they are found within the container.
\item \code{synSyncToSynapse(instance, manifest_path, dry_run=FALSE, send_messages=TRUE, retries=4L, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_client=NULL)}: Upload files to Synapse using a manifest CSV file.\cr
\cr
Accepts manifests produced by sync_from_synapse, the\cr
synapse get-download-list CLI, or the Synapse UI download cart.\cr
The manifest must have at minimum a path and parentId column.\cr
All other columns that are not part of the standard manifest column set\cr
are treated as file annotations.\cr
\cr
Standard manifest columns:\cr
[ID, name, parentId, contentType, path, synapseStore, activityName,\cr
activityDescription, forceVersion, used, executed]
\item \code{synUnbindSchema(instance, synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{synValidateSchema(instance, synapse_client=NULL)}: Validate the entity against the bound JSON schema.
\item \code{synWalk(instance, follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL)}: Traverse through the hierarchy of entities stored under this container.\cr
Mimics os.walk() behavior but yields EntityHeader objects, with optional\cr
ASCII tree display that continues printing as the walk progresses.
}
}


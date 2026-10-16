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
\item{files}{(list[File]) Files that exist within this folder.}
\item{folders}{(list[Folder]) Folders that exist within this folder.}
\item{tables}{(list[Table]) Tables that exist within this folder.}
\item{entityviews}{(list[EntityView]) Entity views that exist within this folder.}
\item{submissionviews}{(list[SubmissionView]) Submission views that exist within this folder.}
\item{datasets}{(list[Dataset]) Datasets that exist within this folder.}
\item{datasetcollections}{(list[DatasetCollection]) Dataset collections that exist within this folder.}
\item{materializedviews}{(list[MaterializedView]) Materialized views that exist within this folder.}
\item{virtualtables}{(list[VirtualTable]) Virtual tables that exist within this folder.}
\item{searchindexes}{(list[SearchIndex]) Search indexes that exist within this folder.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the folder. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty named list \code{list()} or NULL and store the entity.}
\item{is_restricted}{(bool) (Store only) If set to TRUE, an email will be sent to the Synapse access control team to start the process of adding terms-of-use or review board approval for this entity. You will be contacted with regards to the specific data being restricted and the requirements of access.}
\item{create_or_update}{(bool) (Store only) Indicates whether the method should automatically perform an update if the resource conflicts with an existing Synapse object. When TRUE this means that any changes to the resource will be non-destructive.

This boolean is ignored if you've already stored or retrieved the resource from Synapse for this instance at least once. Any changes to the resource will be destructive in this case. For example if you want to delete the content for a field you will need to call \code{.get()} and then modify the field.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Folder(id=NULL, name=NULL, parent_id=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), searchindexes=list(), annotations=list(), is_restricted=FALSE, create_or_update=TRUE)}: Constructor for \code{\link{Folder}}
\item \code{\link[=Folder_synBindSchema]{synBindSchema}(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{\link[=Folder_synCopy]{synCopy}(instance, parent_id, copy_annotations=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)}: Copy the folder to another Synapse location. This will recursively copy all Tables, Links, Files, and Folders within the folder.
\item \code{\link[=Folder_synDeletePermissions]{synDeletePermissions}(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire \strong{local} Access Control List (ACL) for a given Entity. This is not scoped to a specific user or group, but rather removes all permissions associated with the Entity. After this operation, the Entity will inherit permissions from its benefactor, which is typically its parent entity or the Project it belongs to.

In order to remove permissions for a specific user or group, you should use the \code{\link[=Folder_synSetPermissions]{synSetPermissions}()} function with the \code{access_type} set to an empty list.

By default, Entities such as FileEntity and Folder inherit their permission from their containing Project. For such Entities the Project is the Entity's 'benefactor'. This permission inheritance can be overridden by creating an ACL for the Entity. When this occurs the Entity becomes its own benefactor and all permission are determined by its own ACL.

If the ACL of an Entity is deleted, then its benefactor will automatically be set to its parent's benefactor.

\strong{Special notice for Projects:} The ACL for a Project cannot be deleted, you must individually update or revoke the permissions for each user or group.
\item \code{\link[=Folder_synDeleteProjectSetting]{synDeleteProjectSetting}(instance, setting_id, synapse_client=NULL)}: Delete a project setting by its setting ID.
\item \code{\link[=Folder_synFlattenFileList]{synFlattenFileList}(instance)}: Recursively loop over all of the already retrieved files and folders and return a list of all files in the container.
\item \code{\link[=Folder_synGenerateSyncManifest]{synGenerateSyncManifest}(instance, directory_path, manifest_path, synapse_client=NULL)}: Walk a local directory, mirror its folder hierarchy under this container in Synapse, and write a CSV manifest ready for \code{\link[=Folder_synSyncToSynapse]{synSyncToSynapse}()}.

The manifest has two columns: path (absolute, symlink-resolved) and parentId (the Synapse ID of the file's containing folder). Existing Synapse folders with matching names and parents are reused. Directory symlinks inside directory_path are not followed; file symlinks record the symlink path and upload the target's contents. Zero-byte files are skipped with a warning — Synapse rejects empty files. I/O errors during walk are logged and skipped; an empty source directory produces a warning and a header-only manifest.
\item \code{\link[=Folder_synGetAcl]{synGetAcl}(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL} that a user or group has on an Entity.
\item \code{\link[=Folder_synGetInvalidValidation]{synGetInvalidValidation}(instance, synapse_client=NULL)}: Get invalid JSON schema validation results for a container entity.
\item \code{\link[=Folder_synGetPermissions]{synGetPermissions}(instance, synapse_client=NULL)}: Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions} that the caller has on an Entity.
\item \code{\link[=Folder_synGetProjectSetting]{synGetProjectSetting}(instance, setting_type="upload", synapse_client=NULL)}: Get the project setting for this entity.
\item \code{\link[=Folder_synGetSchema]{synGetSchema}(instance, synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{\link[=Folder_synGetSchemaDerivedKeys]{synGetSchemaDerivedKeys}(instance, synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{\link[=Folder_synGetSchemaValidationStatistics]{synGetSchemaValidationStatistics}(instance, synapse_client=NULL)}: Get validation statistics for a container entity.
\item \code{\link[=Folder_synGetStsStorageToken]{synGetStsStorageToken}(instance, permission, output_format="json", min_remaining_life=NULL, synapse_client=NULL)}: Get STS (AWS Security Token Service) credentials for direct access to the storage location backing this entity. These credentials can be used with AWS tools such as the AWS CLI.
\item \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}(instance, dest_storage_location_id, db_path=NULL, source_storage_location_ids=NULL, file_version_strategy="new", include_table_files=FALSE, continue_on_error=FALSE, synapse_client=NULL)}: Index files in this entity for migration to a new storage location.

This is the first step in migrating files to a new storage location. After indexing, use \code{\link[=Folder_synMigrateIndexedFiles]{synMigrateIndexedFiles}()} to perform the actual migration.
\item \code{\link[=Folder_synListAcl]{synListAcl}(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.

This function returns the local sharing settings for the entity and optionally its children. It provides a mapping of all ACLs for the given container/entity.

\strong{Important Note:} This function returns the LOCAL sharing settings only, not the effective permissions that each Synapse User ID/Team has on the entities. More permissive permissions could be granted via a Team that the user has access to that has permissions on the entity, or through inheritance from parent entities.
\item \code{\link[=Folder_synMapDirectoryToAllContainedFiles]{synMapDirectoryToAllContainedFiles}(instance, root_path)}: Recursively loop over all of the already retrieved files and folders. Then return back a named list where the key is the path to the directory at each level. The value is a list of all files in that directory AND all files in the child directories.

This is used during the creation of the manifest TSV file during the syncFromSynapse utility function.
\item \code{\link[=Folder_synMigrateIndexedFiles]{synMigrateIndexedFiles}(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)}: Migrate files that have been indexed with \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}()}.

This is the second step in migrating files to a new storage location. Files must first be indexed using \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}()}.

\strong{Interactive confirmation:} When called from an interactive shell and \code{force=FALSE} (the default), this function will print the number of items queued for migration and prompt for confirmation before proceeding. If standard output is not connected to an interactive terminal (e.g. a script or CI environment), migration is aborted unless \code{force=TRUE} is set.
\item \code{\link[=Folder_synSetPermissions]{synSetPermissions}(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity. An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{\link[=Folder_synSetStorageLocation]{synSetStorageLocation}(instance, storage_location_id=1L, synapse_client=NULL)}: Set the upload storage location for this entity. This configures where files uploaded to this entity will be stored.

\strong{This is a destructive update.} The provided \code{storage_location_id} value(s) will \strong{replace} any storage locations previously configured on this entity. To add a storage location without removing existing ones, first retrieve the current setting with \code{\link[=Folder_synGetProjectSetting]{synGetProjectSetting}()}, then pass its existing \code{locations} together with the new ID as \code{storage_location_id}. The first ID in the list is the default upload destination.
\item \code{\link[=Folder_synSyncFromSynapse]{synSyncFromSynapse}(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy="LOG_EXCEPTION", include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, manifest="all", synapse_client=NULL)}: Sync this container and all possible sub-folders from Synapse. By default this will download the files that are found and it will populate the \code{files} and \code{folders} attributes with the found files and folders, along with all other entity types (tables, entityviews, etc.) present in the container. If you only want to retrieve the full tree of metadata about your container specify \code{download_file} as FALSE.

This works similar to the Python \code{synapseutils.syncFromSynapse} utility function, and generates a \code{manifest.csv} file in each synced directory. The manifest uses CSV format with \code{parentId} and \code{ID} columns, interoperable with the Synapse UI download cart and \code{\link[=synDownloadListFiles]{synDownloadListFiles}()} output.

Supports syncing Files, Folders, Tables, EntityViews, SubmissionViews, Datasets, DatasetCollections, MaterializedViews, and VirtualTables from Synapse. The metadata for these entity types will be populated in their respective attributes (\code{files}, \code{folders}, \code{tables}, \code{entityviews}, \code{submissionviews}, \code{datasets}, \code{datasetcollections}, \code{materializedviews}, \code{virtualtables}) if they are found within the container.
\item \code{\link[=Folder_synSyncToSynapse]{synSyncToSynapse}(instance, manifest_path, dry_run=FALSE, send_messages=TRUE, retries=4L, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_client=NULL)}: Upload files to Synapse using a manifest CSV file.

Accepts manifests produced by \code{\link[=Folder_synSyncFromSynapse]{synSyncFromSynapse}()}, \code{\link[=synDownloadListFiles]{synDownloadListFiles}()}, or the Synapse UI download cart. The manifest must have at minimum a path and parentId column. All other columns that are not part of the standard manifest column set are treated as file annotations.

Standard manifest columns: ID, name, parentId, contentType, path, synapseStore, activityName, activityDescription, forceVersion, used, executed
\item \code{\link[=Folder_synUnbindSchema]{synUnbindSchema}(instance, synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{\link[=Folder_synValidateSchema]{synValidateSchema}(instance, synapse_client=NULL)}: Validate the entity against the bound JSON schema.
\item \code{\link[=Folder_synWalk]{synWalk}(instance, follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL)}: Traverse through the hierarchy of entities stored under this container. Mimics \code{os.walk()} behavior but yields EntityHeader objects, with optional ASCII tree display that continues printing as the walk progresses.
}
}


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
Folder(id=NULL, name=NULL, parent_id=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), annotations=list(), is_restricted=FALSE, create_or_update=TRUE, _last_persistent_instance=NULL, _synced_from_synapse=FALSE)
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
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the folder. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
\item{is_restricted}{}
\item{create_or_update}{(bool) (Store only) Indicates whether the method should automatically perform an update if the resource conflicts with an existing Synapse object. When True this means that any changes to the resource will be non-destructive.\cr
\cr
This boolean is ignored if you've already stored or retrieved the resource from Synapse for this instance at least once. Any changes to the resource will be destructive in this case. For example if you want to delete the content for a field you will need to call \code{.get()} and then modify the field.}
\item{_last_persistent_instance}{}
\item{_synced_from_synapse}{}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Folder(id=NULL, name=NULL, parent_id=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), annotations=list(), is_restricted=FALSE, create_or_update=TRUE, _last_persistent_instance=NULL, _synced_from_synapse=FALSE)}: Constructor for \code{\link{Folder}}
\item \code{bind_schema(json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{copy(parent_id, copy_annotations=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{delete_permissions(include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL, _benefactor_tracker=NULL)}: Delete the entire Access Control List (ACL) for a given Entity. This is not\cr
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
\item \code{flatten_file_list()}: Recursively loop over all of the already retrieved files and folders and return\cr
a list of all files in the container.
\item \code{get_acl(principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{get_invalid_validation(synapse_client=NULL)}: Get invalid JSON schema validation results for a container entity.
\item \code{get_permissions(synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{get_schema(synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{get_schema_derived_keys(synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{get_schema_validation_statistics(synapse_client=NULL)}: Get validation statistics for a container entity.
\item \code{list_acl(recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL, _progress_bar=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{map_directory_to_all_contained_files(root_path)}: Recursively loop over all of the already retrieved files and folders. Then\cr
return back a dictionary where the key is the path to the directory at each\cr
level. The value is a list of all files in that directory AND all files in\cr
the child directories.\cr
\cr
This is used during the creation of the manifest TSV file during the\cr
syncFromSynapse utility function.
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{sync_from_synapse(path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy=FailureStrategy.LOG_EXCEPTION, include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{unbind_schema(synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{validate_schema(synapse_client=NULL)}: Validate the entity against the bound JSON schema.
\item \code{walk(follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL, _newpath=NULL, _tree_prefix="", _is_last_in_parent=TRUE, _tree_depth=0L)}: Traverse through the hierarchy of entities stored under this container.\cr
Mimics os.walk() behavior but yields EntityHeader objects, with optional\cr
ASCII tree display that continues printing as the walk progresses.
}
}


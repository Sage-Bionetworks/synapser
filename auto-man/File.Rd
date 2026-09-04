%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{File}
\alias{File}
\docType{class}
\title{
File
}
\format{An S3-style class object.}
\description{
A file within Synapse.
}
\usage{
File(id=NULL, name=NULL, path=NULL, description=NULL, parent_id=NULL, version_label=NULL, version_comment=NULL, data_file_handle_id=NULL, external_url=NULL, activity=NULL, annotations=list(), content_type=NULL, content_size=NULL, content_md5=NULL, create_or_update=TRUE, force_version=TRUE, is_restricted=FALSE, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, _present_manifest_fields=NULL, synapse_store=TRUE, download_file=TRUE, if_collision="keep.both", synapse_container_limit=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_number=NULL, is_latest_version=NULL, file_handle=NULL, _last_persistent_instance=NULL)
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this file. A new ID will be generated for new Files. Once issued, this ID is guaranteed to never change or be re-issued.}
\item{name}{(Optional[str]) The name of this entity. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses. If not specified, the name will be derived from the file name.}
\item{path}{(Optional[str]) The path to the file on disk. Using shorthand \code{~} will be expanded to the user's home directory.\cr
\cr
This is used during a \code{get} operation to specify where to download the file to. It should be pointing to a directory.\cr
\cr
This is also used during a \code{store} operation to specify the file to upload. It should be pointing to a file.}
\item{description}{(Optional[str]) The description of this file. Must be 1000 characters or less.}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this Entity. Setting this to a new value and storing it will move this File under the new parent.}
\item{version_label}{(Optional[str]) The version label for this entity. Updates to the entity will increment the version number.}
\item{version_comment}{(Optional[str]) The version comment for this entity}
\item{data_file_handle_id}{(Optional[str]) ID of the file associated with this entity. You may define an existing data_file_handle_id to use the existing data_file_handle_id. The creator of the file must also be the owner of the data_file_handle_id to have permission to store the file.}
\item{external_url}{(Optional[str]) The external URL of this file. If this is set AND \code{synapse_store} is False, only a reference to this URL and the file metadata will be stored in Synapse. The file itself will not be uploaded. If this attribute is set it will override the \code{path}.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analygous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance. Activity cannot be removed during a store operation by setting it to None. You must use: \code{\link[=synDelete]{synDelete}} or \code{\link[=synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}}.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the folder. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
\item{content_type}{(Optional[str]) (New Upload Only) Used to manually specify Content-type header, for example 'application/png' or 'application/json; charset=UTF-8'. If not specified, the content type will be derived from the file extension.\cr
\cr
\cr
This can be specified only during the initial store of this file or any time there is a new file to upload. In order to change this after the File has been created use \code{\link[=synChangeMetadata]{synChangeMetadata}}.}
\item{content_size}{(Optional[int]) (New Upload Only) The size of the file in bytes. This can be specified only during the initial creation of the File. This is also only applicable to files not uploaded to Synapse. ie: \code{synapse_store} is False.}
\item{content_md5}{(Optional[str]) (Store only) The MD5 of the file is known. If not supplied this will be computed in the client is possible. If supplied for a file entity already stored in Synapse it will be calculated again to check if a new upload needs to occur. This will not be filled in during a read for data. It is only used during a store operation. To retrieve the md5 of the file after read from synapse use the \code{.file_handle.content_md5} attribute.}
\item{create_or_update}{(bool) (Store only) Indicates whether the method should automatically perform an update if the \code{file} conflicts with an existing Synapse object.}
\item{force_version}{(bool) (Store only) Indicates whether the method should increment the version of the object if something within the entity has changed. For example updating the description or name. You may set this to False and an update to the entity will not increment the version.\cr
\cr
Updating the \code{version_label} attribute will also cause a version update regardless  of this flag.\cr
\cr
An update to the MD5 of the file will force a version update regardless of this  flag.}
\item{is_restricted}{(bool) (Store only) If set to true, an email will be sent to the Synapse access control team to start the process of adding terms-of-use or review board approval for this entity. You will be contacted with regards to the specific data being restricted and the requirements of access.\cr
\cr
This may be used only by an administrator of the specified file.}
\item{merge_existing_annotations}{(bool) (Store only) Works in conjunction with \code{create_or_update} in that this is only evaluated if \code{create_or_update} is True. If this entity exists in Synapse that has annotations that are not present in a store operation, these annotations will be added to the entity. If this is False any annotations that are not present within a store operation will be removed from this entity. This allows one to complete a destructive update of annotations on an entity.}
\item{associate_activity_to_new_version}{(bool) (Store only) Works in conjunction with \code{create_or_update} in that this is only evaluated if \code{create_or_update} is True. When true an activity already attached to the current version of this entity will be associated the new version during a store operation if the version was updated. This is useful if you are updating the entity and want to ensure that the activity is persisted onto the new version the entity.}
\item{_present_manifest_fields}{}
\item{synapse_store}{(bool) (Store only) Whether the File should be uploaded or if false: only the path should be stored when \code{\link[=synStore]{synStore}} is called.}
\item{download_file}{(bool) (Get only) If True the file will be downloaded.}
\item{if_collision}{(str) (Get only) Determines how to handle file collisions. Defaults to "keep.both". May be:\cr
\cr
- \code{overwrite.local} - \code{keep.local} - \code{keep.both}}
\item{synapse_container_limit}{(Optional[str]) (Get only) A Synanpse ID used to limit the search in Synapse if file is specified as a local file. That is, if the file is stored in multiple locations in Synapse only the ones in the specified folder/project will be returned.}
\item{etag}{(Optional[str]) (Read Only) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) (Read Only) The date this entity was created.}
\item{modified_on}{(Optional[str]) (Read Only) The date this entity was last modified.}
\item{created_by}{(Optional[str]) (Read Only) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) (Read Only) The ID of the user that last modified this entity.}
\item{version_number}{(Optional[int]) (Read Only) The version number issued to this version on the object.}
\item{is_latest_version}{(Optional[bool]) (Read Only) If this is the latest version of the object.}
\item{file_handle}{(Optional[FileHandle]) (Read Only) The file handle associated with this entity.}
\item{_last_persistent_instance}{}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{File(id=NULL, name=NULL, path=NULL, description=NULL, parent_id=NULL, version_label=NULL, version_comment=NULL, data_file_handle_id=NULL, external_url=NULL, activity=NULL, annotations=list(), content_type=NULL, content_size=NULL, content_md5=NULL, create_or_update=TRUE, force_version=TRUE, is_restricted=FALSE, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, _present_manifest_fields=NULL, synapse_store=TRUE, download_file=TRUE, if_collision="keep.both", synapse_container_limit=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_number=NULL, is_latest_version=NULL, file_handle=NULL, _last_persistent_instance=NULL)}: Constructor for \code{\link{File}}
\item \code{bind_schema(json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{change_metadata(name=NULL, download_as=NULL, content_type=NULL, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{copy(parent_id, update_existing=FALSE, copy_annotations=TRUE, copy_activity="traceback", synapse_client=NULL)}: Wrapper for the function to be traced.
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
\item \code{from_id(synapse_id, synapse_client=NULL)}: Wrapper for \code{\link[=synGet]{synGet}}.
\item \code{from_path(path, synapse_client=NULL)}: Get the file from Synapse. If the path of the file matches multiple files\cr
within Synapse the first one found will be returned. The other matching\cr
files will be printed to the console.\cr
\cr
\cr
Wrapper for \code{\link[=synGet]{synGet}}.
\item \code{get_acl(principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{get_permissions(synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{get_schema(synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{get_schema_derived_keys(synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{list_acl(recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL, _progress_bar=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{unbind_schema(synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{validate_schema(synapse_client=NULL)}: Validate the entity against the bound JSON schema.
}
}


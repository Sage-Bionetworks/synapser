# File

A file within Synapse.

## Usage

``` r
File(id=NULL, name=NULL, path=NULL, description=NULL, parent_id=NULL, version_label=NULL, version_comment=NULL, data_file_handle_id=NULL, external_url=NULL, activity=NULL, annotations=list(), content_type=NULL, content_size=NULL, content_md5=NULL, create_or_update=TRUE, force_version=TRUE, is_restricted=FALSE, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_store=TRUE, download_file=TRUE, if_collision="keep.both", synapse_container_limit=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_number=NULL, is_latest_version=NULL, file_handle=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique immutable ID for this file. A new ID will
  be generated for new Files. Once issued, this ID is guaranteed to
  never change or be re-issued.

- name:

  (Optional\[str\]) The name of this entity. Must be 256 characters or
  less. Names may only contain: letters, numbers, spaces, underscores,
  hyphens, periods, plus signs, apostrophes, and parentheses. If not
  specified, the name will be derived from the file name.

- path:

  (Optional\[str\]) The path to the file on disk. Using shorthand `~`
  will be expanded to the user's home directory.

  This is used during a `get` operation to specify where to download the
  file to. It should be pointing to a directory.

  This is also used during a `store` operation to specify the file to
  upload. It should be pointing to a file.

- description:

  (Optional\[str\]) The description of this file. Must be 1000
  characters or less.

- parent_id:

  (Optional\[str\]) The ID of the Entity that is the parent of this
  Entity. Setting this to a new value and storing it will move this File
  under the new parent.

- version_label:

  (Optional\[str\]) The version label for this entity. Updates to the
  entity will increment the version number.

- version_comment:

  (Optional\[str\]) The version comment for this entity

- data_file_handle_id:

  (Optional\[str\]) ID of the file associated with this entity. You may
  define an existing data_file_handle_id to use the existing
  data_file_handle_id. The creator of the file must also be the owner of
  the data_file_handle_id to have permission to store the file.

- external_url:

  (Optional\[str\]) The external URL of this file. If this is set AND
  `synapse_store` is FALSE, only a reference to this URL and the file
  metadata will be stored in Synapse. The file itself will not be
  uploaded. If this attribute is set it will override the `path`.

- activity:

  (Optional\[Activity\]) The Activity model represents the main record
  of Provenance in Synapse. It is analogous to the Activity defined in
  the [W3C Specification](https://www.w3.org/TR/prov-n/) on Provenance.
  Activity cannot be removed during a store operation by setting it to
  NULL. You must use:
  [`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)
  or
  [`synDisassociateActivityFromEntity`](https://r-docs.synapse.org/latest/reference/Activity_DisassociateActivityFromEntity.md).

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Additional metadata
  associated with the file. The key is the name of your desired
  annotations. The value is an object containing a list of values (use
  empty list to represent no values for key) and the value type
  associated with all values in the list. To remove all annotations set
  this to an empty named list
  [`list()`](https://rdrr.io/r/base/list.html) or NULL and store the
  entity.

- content_type:

  (Optional\[str\]) (New Upload Only) Used to manually specify
  Content-type header, for example 'application/png' or
  'application/json; charset=UTF-8'. If not specified, the content type
  will be derived from the file extension.

  This can be specified only during the initial store of this file or
  any time there is a new file to upload. In order to change this after
  the File has been created use
  [`synChangeMetadata`](https://r-docs.synapse.org/latest/reference/File_ChangeMetadata.md).

- content_size:

  (Optional\[int\]) (New Upload Only) The size of the file in bytes.
  This can be specified only during the initial creation of the File.
  This is also only applicable to files not uploaded to Synapse. ie:
  `synapse_store` is FALSE.

- content_md5:

  (Optional\[str\]) (Store only) The MD5 of the file is known. If not
  supplied this will be computed in the client is possible. If supplied
  for a file entity already stored in Synapse it will be calculated
  again to check if a new upload needs to occur. This will not be filled
  in during a read for data. It is only used during a store operation.
  To retrieve the md5 of the file after read from synapse use the
  `$file_handle$content_md5` attribute.

- create_or_update:

  (bool) (Store only) Indicates whether the method should automatically
  perform an update if the file conflicts with an existing Synapse
  object.

- force_version:

  (bool) (Store only) Indicates whether the method should increment the
  version of the object if something within the entity has changed. For
  example updating the description or name. You may set this to FALSE
  and an update to the entity will not increment the version.

  Updating the `version_label` attribute will also cause a version
  update regardless of this flag.

  An update to the MD5 of the file will force a version update
  regardless of this flag.

- is_restricted:

  (bool) (Store only) If set to TRUE, an email will be sent to the
  Synapse access control team to start the process of adding
  terms-of-use or review board approval for this entity. You will be
  contacted with regards to the specific data being restricted and the
  requirements of access.

  This may be used only by an administrator of the specified file.

- merge_existing_annotations:

  (bool) (Store only) Works in conjunction with `create_or_update` in
  that this is only evaluated if `create_or_update` is TRUE. If this
  entity exists in Synapse that has annotations that are not present in
  a store operation, these annotations will be added to the entity. If
  this is FALSE any annotations that are not present within a store
  operation will be removed from this entity. This allows one to
  complete a destructive update of annotations on an entity.

- associate_activity_to_new_version:

  (bool) (Store only) Works in conjunction with `create_or_update` in
  that this is only evaluated if `create_or_update` is TRUE. When TRUE
  an activity already attached to the current version of this entity
  will be associated the new version during a store operation if the
  version was updated. This is useful if you are updating the entity and
  want to ensure that the activity is persisted onto the new version the
  entity.

- synapse_store:

  (bool) (Store only) Whether the File should be uploaded or if FALSE:
  only the path should be stored when
  [`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)
  is called.

- download_file:

  (bool) (Get only) If TRUE the file will be downloaded.

- if_collision:

  (str) (Get only) Determines how to handle file collisions. Defaults to
  "keep.both". May be:  
  - `overwrite.local`  
  - `keep.local`  
  - `keep.both`

- synapse_container_limit:

  (Optional\[str\]) (Get only) A Synapse ID used to limit the search in
  Synapse if file is specified as a local file. That is, if the file is
  stored in multiple locations in Synapse only the ones in the specified
  folder/project will be returned.

- etag:

  (Optional\[str\]) (Read Only) Synapse employs an Optimistic
  Concurrency Control (OCC) scheme to handle concurrent updates. Since
  the E-Tag changes every time an entity is updated it is used to detect
  when a client's current representation of an entity is out-of-date.

- created_on:

  (Optional\[str\]) (Read Only) The date this entity was created.

- modified_on:

  (Optional\[str\]) (Read Only) The date this entity was last modified.

- created_by:

  (Optional\[str\]) (Read Only) The ID of the user that created this
  entity.

- modified_by:

  (Optional\[str\]) (Read Only) The ID of the user that last modified
  this entity.

- version_number:

  (Optional\[int\]) (Read Only) The version number issued to this
  version on the object.

- is_latest_version:

  (Optional\[bool\]) (Read Only) If this is the latest version of the
  object.

- file_handle:

  (Optional\[FileHandle\]) (Read Only) The file handle associated with
  this entity.

## Value

NULL

## Methods

- `File(id=NULL, name=NULL, path=NULL, description=NULL, parent_id=NULL, version_label=NULL, version_comment=NULL, data_file_handle_id=NULL, external_url=NULL, activity=NULL, annotations=list(), content_type=NULL, content_size=NULL, content_md5=NULL, create_or_update=TRUE, force_version=TRUE, is_restricted=FALSE, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_store=TRUE, download_file=TRUE, if_collision="keep.both", synapse_container_limit=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_number=NULL, is_latest_version=NULL, file_handle=NULL)`:
  Constructor for `File`

- [`synBindSchema`](https://r-docs.synapse.org/latest/reference/File_BindSchema.md)`(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)`:
  Bind a JSON schema to the entity.

- [`synChangeMetadata`](https://r-docs.synapse.org/latest/reference/File_ChangeMetadata.md)`(instance, name=NULL, download_as=NULL, content_type=NULL, synapse_client=NULL)`:
  Change File Entity metadata for properties that are immutable after
  creation through the store method.

- [`synCopy`](https://r-docs.synapse.org/latest/reference/File_Copy.md)`(instance, parent_id, update_existing=FALSE, copy_annotations=TRUE, copy_activity="traceback", synapse_client=NULL)`:
  Copy the file to another Synapse location. Defaults to the latest
  version of the file, or the version_number specified in the instance.

- [`synDeletePermissions`](https://r-docs.synapse.org/latest/reference/File_DeletePermissions.md)`(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)`:
  Delete the entire **local** Access Control List (ACL) for a given
  Entity. This is not scoped to a specific user or group, but rather
  removes all permissions associated with the Entity. After this
  operation, the Entity will inherit permissions from its benefactor,
  which is typically its parent entity or the Project it belongs to.

  In order to remove permissions for a specific user or group, you
  should use the
  [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/File_SetPermissions.md)
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

- [`synGetFromId`](https://r-docs.synapse.org/latest/reference/File_GetFromId.md)`(cls, synapse_id, synapse_client=NULL)`:
  Wrapper for
  [`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md).

- [`synGetFromPath`](https://r-docs.synapse.org/latest/reference/File_GetFromPath.md)`(cls, path, synapse_client=NULL)`:
  Get the file from Synapse. If the path of the file matches multiple
  files within Synapse the first one found will be returned. The other
  matching files will be printed to the console.

  Wrapper for
  [`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md).

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/File_GetAcl.md)`(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`:
  Get the
  [ACL](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)
  that a user or group has on an Entity.

- [`synGetPermissions`](https://r-docs.synapse.org/latest/reference/File_GetPermissions.md)`(instance, synapse_client=NULL)`:
  Get the
  [permissions](https://python-docs.synapse.org/reference/permissions/)
  that the caller has on an Entity.

- [`synGetSchema`](https://r-docs.synapse.org/latest/reference/File_GetSchema.md)`(instance, synapse_client=NULL)`:
  Get the JSON schema bound to the entity.

- [`synGetSchemaDerivedKeys`](https://r-docs.synapse.org/latest/reference/File_GetSchemaDerivedKeys.md)`(instance, synapse_client=NULL)`:
  Retrieve derived JSON schema keys for the entity.

- [`synListAcl`](https://r-docs.synapse.org/latest/reference/File_ListAcl.md)`(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)`:
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

- [`synSetPermissions`](https://r-docs.synapse.org/latest/reference/File_SetPermissions.md)`(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)`:
  Sets permission that a user or group has on an Entity. An Entity may
  have its own ACL or inherit its ACL from a benefactor.

- [`synUnbindSchema`](https://r-docs.synapse.org/latest/reference/File_UnbindSchema.md)`(instance, synapse_client=NULL)`:
  Unbind the JSON schema bound to the entity.

- [`synValidateSchema`](https://r-docs.synapse.org/latest/reference/File_ValidateSchema.md)`(instance, synapse_client=NULL)`:
  Validate the entity against the bound JSON schema.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Uploading a file
    library(synapser)
    synLogin()

    file = File(
        path = "/path/to/file.txt",
        parent_id = "syn123",
        description = "My data file",
        annotations = list(species = "Homo sapiens")
    ) |> synStore()
    print(file$id)

## Example 2: Getting a file's metadata without downloading it
    library(synapser)
    synLogin()

    file = File(id = "syn456") |> synGet(file_options = FileOptions(download_file = FALSE))
    print(file$name)
} # }
```

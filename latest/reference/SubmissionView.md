# Constructor for objects of type SubmissionView

A `SubmissionView` object represents the metadata of a Synapse
Submission View.
\<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/SubmissionView.html\>

## Usage

``` r
SubmissionView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="submissionview", view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), annotations=list(), is_search_enabled=NULL, scope_ids=list())
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique immutable ID for this entity. A new ID
  will be generated for new Entities. Once issued, this ID is guaranteed
  to never change or be re-issued.

- name:

  (Optional\[str\]) The name of this entity. Must be 256 characters or
  less. Names may only contain: letters, numbers, spaces, underscores,
  hyphens, periods, plus signs, apostrophes, and parentheses.

- parent_id:

  (Optional\[str\]) The ID of the Entity that is the parent of this
  Entity.

- activity:

  (Optional\[Activity\]) The Activity model represents the main record
  of Provenance in Synapse. It is analogous to the Activity defined in
  the [W3C Specification](https://www.w3.org/TR/prov-n/) on Provenance.

- version_number:

  (Optional\[int\]) The version number issued to this version on the
  object.

- view_entity_type:

  (str) The API model string for the type of view. This is used to
  determine the default columns that are added to the table. Defaults to
  `"submissionview"`.

- view_type_mask:

  (Optional\[int\]) Bit mask representing the types to include in the
  view. This is used to determine the default columns that are added to
  the table. See
  \<https://rest-docs.synapse.org/rest/GET/column/tableview/defaults.html\>
  for the bit mask values.

- include_default_columns:

  (Optional\[bool\]) When creating a submission view, specifies if
  default columns should be included. Default columns are columns that
  are automatically added to the view. These columns are managed by
  Synapse and cannot be modified. If you attempt to create a column with
  the same name as a default column, you will receive a warning when you
  store the view.  
    
  **`include_default_columns` is only used if this is the first time
  that the view is being stored.** If you are updating an existing view
  this attribute will be ignored.  
    
  The column you are overriding will not behave the same as a default
  column. For example, suppose you create a column called `id` on a
  view. When using a default column, the `id` stores the Synapse ID of
  each of the entities included in the scope of the view. If you
  override the `id` column with a new column, the `id` column will no
  longer store the Synapse ID of the entities in the view. Instead, it
  will store the values you provide when you store the view. It will be
  stored as an annotation on the entity for the row you are modifying.

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

- version_label:

  (Optional\[str\]) The version label for this entity.

- version_comment:

  (Optional\[str\]) The version comment for this entity.

- is_latest_version:

  (Optional\[bool\]) If this is the latest version of the object.

- columns:

  (Optional\[Union\[list\[Column\], OrderedDict\[str, Column\],
  dict\[str, Column\]\]\]) The columns of this submission view. This is
  an ordered named list where the key is the name of the column and the
  value is the Column object. When creating a new instance of a
  SubmissionView object you may pass any of the following types as the
  `columns` argument:  
    
  - A list of Column objects  
  - A named list where the key is the name of the column and the value
  is the Column object  
    
  The order of the columns will be the order they are stored in Synapse.
  If you need to reorder the columns the recommended approach is to use
  the
  [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_ReorderColumn.md)
  function. Additionally, you may add, and delete columns using the
  [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_AddColumn.md),
  and
  [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_DeleteColumn.md)
  functions on your view class instance.  
    
  You may modify the attributes of the Column object to change the
  column type, name, or other attributes. For example, suppose you'd
  like to change a column from a INTEGER to a DOUBLE. You can do so by
  changing the column type attribute of the Column object. The next time
  you store the view the column will be updated in Synapse with the new
  type.  
    


      library(synapser)
      synLogin()

      view = SubmissionView(id = "syn1234") |> synGet()
      view$columns[["my_column"]]$column_type = "DOUBLE"
      view = view |> synStore()

  Note that the keys in this named list should match the column names as
  they are in Synapse. However, know that the name attribute of the
  Column object is used for all interactions with the Synapse API. The
  named list key is purely for the usage of this interface. For example,
  if you wish to rename a column you may do so by changing the name
  attribute of the Column object. The key in the named list does not
  need to be changed. The next time you store the view the column will
  be updated in Synapse with the new name and the key in the named list
  will be updated.

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Additional metadata
  associated with the submission view. The key is the name of your
  desired annotations. The value is an object containing a list of
  values (use empty list to represent no values for key) and the value
  type associated with all values in the list. To remove all annotations
  set this to an empty named list
  [`list()`](https://rdrr.io/r/base/list.html) or NULL and store the
  entity.

- is_search_enabled:

  (Optional\[bool\]) When creating or updating a table or view,
  specifies if full-text search should be enabled. Note that enabling
  full-text search might slow down the indexing of the table or view.

- scope_ids:

  (list\[str\]) The list of container IDs that define the scope of this
  view. For submission views, this is the list of evaluation queues that
  the view is associated with.

## Value

NULL

## Methods

- `SubmissionView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="submissionview", view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), annotations=list(), is_search_enabled=NULL, scope_ids=list())`:
  Constructor for `SubmissionView`

- [`synAddColumn`](https://r-docs.synapse.org/latest/reference/SubmissionView_AddColumn.md)`(instance, column, index=NULL)`:
  Add column(s) to the table. Note that this does not store the
  column(s) in Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this SubmissionView instance to store the column(s) in
  Synapse. This is a convenience function to eliminate the need to
  manually add the column(s) to the `$columns` list.  
    
  This function will add an item to the `$columns` attribute of the
  SubmissionView instance. `$columns` is a named list where the key is
  the name of the column and the value is the Column object.

- [`synDeleteColumn`](https://r-docs.synapse.org/latest/reference/SubmissionView_DeleteColumn.md)`(instance, name)`:
  Mark a column for deletion. Note that this does not delete the column
  from Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this SubmissionView instance to delete the column from
  Synapse. This is a convenience function to eliminate the need to
  manually delete the column from the named list and add it to the
  `$_columns_to_delete` attribute.

- [`synReorderColumn`](https://r-docs.synapse.org/latest/reference/SubmissionView_ReorderColumn.md)`(instance, name, index)`:
  Reorder a column in the table. Note that this does not store the
  column in Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this SubmissionView instance to store the column in
  Synapse. This is a convenience function to eliminate the need to
  manually reorder the named list stored in the `$columns` attribute.  
    
  You must ensure that the index is within the bounds of the number of
  columns in the table. If you pass in an index that is out of bounds
  the column will be added to the end of the list.

- [`synGetPermissions`](https://r-docs.synapse.org/latest/reference/SubmissionView_GetPermissions.md)`(instance, synapse_client=NULL)`:
  Get the
  [permissions](https://python-docs.synapse.org/reference/permissions/)
  that the caller has on an Entity.

- [`synSetPermissions`](https://r-docs.synapse.org/latest/reference/SubmissionView_SetPermissions.md)`(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)`:
  Sets permission that a user or group has on an Entity. An Entity may
  have its own ACL or inherit its ACL from a benefactor.

- [`synDeletePermissions`](https://r-docs.synapse.org/latest/reference/SubmissionView_DeletePermissions.md)`(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)`:
  Delete the entire **local** Access Control List (ACL) for a given
  Entity. This is not scoped to a specific user or group, but rather
  removes all permissions associated with the Entity. After this
  operation, the Entity will inherit permissions from its benefactor,
  which is typically its parent entity or the Project it belongs to.  
    
  In order to remove permissions for a specific user or group, you
  should use the
  [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/SubmissionView_SetPermissions.md)
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

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/SubmissionView_GetAcl.md)`(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`:
  Get the [ACL](https://python-docs.synapse.org/reference/permissions/)
  that a user or group has on an Entity.

- [`synListAcl`](https://r-docs.synapse.org/latest/reference/SubmissionView_ListAcl.md)`(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)`:
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

- [`synQuery`](https://r-docs.synapse.org/latest/reference/SubmissionView_Query.md)`(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)`:
  Query for data on a table stored in Synapse. The results will always
  be returned as a data frame unless you specify a `download_location`
  in which case the results will be downloaded to that location. There
  are a number of arguments that you may pass to this function depending
  on if you are getting the results back as a DataFrame or downloading
  the results to a file.

- [`synQueryPartMask`](https://r-docs.synapse.org/latest/reference/SubmissionView_QueryPartMask.md)`(query, part_mask, timeout=250L, synapse_client=NULL)`:
  Query for data on a table stored in Synapse. This is a more advanced
  use case of the
  [`synQuery()`](https://r-docs.synapse.org/latest/reference/SubmissionView_Query.md)
  function that allows you to determine what additional metadata about
  the table or query should also be returned. If you do not need this
  additional information then you are better off using the
  [`synQuery()`](https://r-docs.synapse.org/latest/reference/SubmissionView_Query.md)
  function.  
    
  The query for this method uses this Rest API:  
  \<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html\>

- [`synSnapshot`](https://r-docs.synapse.org/latest/reference/SubmissionView_Snapshot.md)`(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)`:
  Creates a snapshot of the `SubmissionView` entity. Synapse handles
  snapshot creation differently for `Table`- and `View`-like entities.
  `View` snapshots are created using the asynchronous job API.  
    
  Making a snapshot of a view allows you to create an immutable version
  of the view at the time of the snapshot. This is useful to create
  checkpoints in time that you may go back and reference, or use in a
  publication. Snapshots are immutable and cannot be changed. They may
  only be deleted.

## Examples

``` r
if (FALSE) { # \dontrun{
## Create a new SubmissionView.
    library(synapser)
    synLogin()

    my_submission_view = SubmissionView(
        name = "My Submission View",
        parent_id = "syn1234",
        scope_ids = list("syn5678", "syn6789") # IDs of evaluation queues
    ) |> synStore()
    my_submission_view
} # }
```

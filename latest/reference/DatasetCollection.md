# DatasetCollection

A `DatasetCollection` object represents the metadata of a Synapse
Dataset Collection.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/DatasetCollection.html>

A Dataset Collection is a type of view defined by a flat list of
Datasets.

## Usage

``` r
DatasetCollection(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="datasetcollection", view_type_mask=256L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), columns=list(), annotations=list())
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[character\]) The unique immutable ID for this dataset
  collection. A new ID will be generated for new DatasetCollections.
  Once issued, this ID is guaranteed to never change or be re-issued

- name:

  (Optional\[character\]) The name of this dataset collection. Must be
  256 characters or less. Names may only contain: letters, numbers,
  spaces, underscores, hyphens, periods, plus signs, apostrophes, and
  parentheses

- parent_id:

  (Optional\[character\]) The ID of the Entity that is the parent of
  this dataset collection.

- activity:

  (Optional\[Activity\]) The Activity model represents the main record
  of Provenance in Synapse. It is analogous to the Activity defined in
  the [W3C Specification](https://www.w3.org/TR/prov-n/) on Provenance.

- version_number:

  (Optional\[integer\]) The version number issued to this version on the
  object.

- view_entity_type:

  (character) The API model string for the type of view. This is used to
  determine the default columns that are added to the table. Defaults to
  `"datasetcollection"`.

- view_type_mask:

  (integer) The Bit Mask representing DatasetCollection type. As defined
  in the Synapse REST API:
  <https://rest-docs.synapse.org/rest/GET/column/tableview/defaults.html>.
  Defaults to 256.

- include_default_columns:

  (Optional\[logical\]) When creating a dataset collection or view,
  specifies if default columns should be included. Default columns are
  columns that are automatically added to the dataset collection or
  view. These columns are managed by Synapse and cannot be modified. If
  you attempt to create a column with the same name as a default column,
  you will receive a warning when you store the dataset collection.  
    
  **`include_default_columns` is only used if this is the first time
  that the view is being stored.** If you are updating an existing view
  this attribute will be ignored.  
    
  The column you are overriding will not behave the same as a default
  column. For example, suppose you create a column called `id` on a
  DatasetCollection. When using a default column, the `id` stores the
  Synapse ID of each of the entities included in the scope of the view.
  If you override the `id` column with a new column, the `id` column
  will no longer store the Synapse ID of the entities in the view.
  Instead, it will store the values you provide when you store the
  dataset collection. It will be stored as an annotation on the entity
  for the row you are modifying.

- description:

  (Optional\[character\]) The description of the dataset collection.
  Must be 1000 characters or less.

- etag:

  (Optional\[character\]) Synapse employs an Optimistic Concurrency
  Control (OCC) scheme to handle concurrent updates. Since the E-Tag
  changes every time an entity is updated it is used to detect when a
  client's current representation of an entity is out-of-date.

- created_on:

  (Optional\[character\]) The date this dataset collection was created.

- modified_on:

  (Optional\[character\]) The date this dataset collection was last
  modified. In YYYY-MM-DD-Thh:mm:ss.sssZ format

- created_by:

  (Optional\[character\]) The ID of the user that created this dataset
  collection.

- modified_by:

  (Optional\[character\]) The ID of the user that last modified this
  dataset collection.

- version_label:

  (Optional\[character\]) The version label for this dataset collection.

- version_comment:

  (Optional\[character\]) The version comment for this dataset
  collection.

- is_latest_version:

  (Optional\[logical\]) If this is the latest version of the object.

- is_search_enabled:

  (Optional\[logical\]) When creating or updating a dataset collection
  or view specifies if full text search should be enabled. Note that
  enabling full text search might slow down the indexing of the dataset
  collection or view.

- items:

  (Optional\[list\[EntityRef\]\]) The flat list of datasets that define
  this collection. This is effectively a list of the rows that are
  in/will be in the collection after it is stored. The only way to add
  or remove rows is to add or remove items from this list.

- columns:

  (Optional\[Union\[list\[Column\], OrderedDict\[str, Column\],
  dict\[str, Column\]\]\]) The columns of this dataset collection. This
  is an ordered named list where the key is the name of the column and
  the value is the Column object. When creating a new instance of a
  DatasetCollection object you may pass any of the following types as
  the `columns` argument:  
    
  - A list of Column objects  
  - A named list where the key is the name of the column and the value
  is the Column object  
    
  The order of the columns will be the order they are stored in Synapse.
  If you need to reorder the columns the recommended approach is to use
  the
  [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_ReorderColumn.md)
  function. Additionally, you may add, and delete columns using the
  [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_AddColumn.md),
  and
  [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_DeleteColumn.md)
  functions on your dataset collection class instance.  
    
  You may modify the attributes of the Column object to change the
  column type, name, or other attributes. For example, suppose you'd
  like to change a column from a INTEGER to a DOUBLE. You can do so by
  changing the column type attribute of the Column object. The next time
  you store the dataset collection the column will be updated in Synapse
  with the new type.  
    


      library(synapser)
      synLogin()

      collection = DatasetCollection(id = "syn1234") |> synGet()
      collection$columns[["my_column"]]$column_type = "DOUBLE"
      collection = collection |> synStore()

  Note that the keys in this named list should match the column names as
  they are in Synapse. However, know that the name attribute of the
  Column object is used for all interactions with the Synapse API. The
  named list key is purely for the usage of this interface. For example,
  if you wish to rename a column you may do so by changing the name
  attribute of the Column object. The key in the named list does not
  need to be changed. The next time you store the dataset collection the
  column will be updated in Synapse with the new name and the key in the
  named list will be updated.

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Additional metadata
  associated with the dataset collection. The key is the name of your
  desired annotations. The value is an object containing a list of
  values (use empty list to represent no values for key) and the value
  type associated with all values in the list.

## Value

NULL

## Methods

- `DatasetCollection(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="datasetcollection", view_type_mask=256L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), columns=list(), annotations=list())`:
  Constructor for `DatasetCollection`

- [`synAddColumn`](https://r-docs.synapse.org/latest/reference/DatasetCollection_AddColumn.md)`(instance, column, index=NULL)`:
  Add column(s) to the table. Note that this does not store the
  column(s) in Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this DatasetCollection instance to store the column(s) in
  Synapse. This is a convenience function to eliminate the need to
  manually add the column(s) to the `$columns` list.  
    
  This function will add an item to the `$columns` attribute of the
  DatasetCollection instance. `$columns` is a named list where the key
  is the name of the column and the value is the Column object.

- [`synAddItem`](https://r-docs.synapse.org/latest/reference/DatasetCollection_AddItem.md)`(instance, item)`:
  Adds a dataset to the dataset collection. Effect is not seen until the
  dataset collection is stored.

- [`synDeleteColumn`](https://r-docs.synapse.org/latest/reference/DatasetCollection_DeleteColumn.md)`(instance, name)`:
  Mark a column for deletion. Note that this does not delete the column
  from Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this DatasetCollection instance to delete the column from
  Synapse. This is a convenience function to eliminate the need to
  manually delete the column from the named list and add it to the
  `$_columns_to_delete` attribute.

- [`synDeletePermissions`](https://r-docs.synapse.org/latest/reference/DatasetCollection_DeletePermissions.md)`(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)`:
  Delete the entire Access Control List (ACL) for a given Entity. This
  is not scoped to a specific user or group, but rather removes all
  permissions associated with the Entity. After this operation, the
  Entity will inherit permissions from its benefactor, which is
  typically its parent entity or the Project it belongs to.  
    
  In order to remove permissions for a specific user or group, you
  should use the
  [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_SetPermissions.md)
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

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/DatasetCollection_GetAcl.md)`(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`:
  Get the
  [ACL](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)
  that a user or group has on an Entity.

- [`synGetPermissions`](https://r-docs.synapse.org/latest/reference/DatasetCollection_GetPermissions.md)`(instance, synapse_client=NULL)`:
  Get the
  [permissions](https://python-docs.synapse.org/reference/permissions/)
  that the caller has on an Entity.

- [`synListAcl`](https://r-docs.synapse.org/latest/reference/DatasetCollection_ListAcl.md)`(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)`:
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

- [`synQuery`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Query.md)`(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)`:
  Query for data on a table stored in Synapse. The results will always
  be returned as a data frame unless you specify a `download_location`
  in which case the results will be downloaded to that location. There
  are a number of arguments that you may pass to this function depending
  on if you are getting the results back as a data frame or downloading
  the results to a file.

- [`synQueryPartMask`](https://r-docs.synapse.org/latest/reference/DatasetCollection_QueryPartMask.md)`(query, part_mask, timeout=250L, synapse_client=NULL)`:
  Query for data on a table stored in Synapse. This is a more advanced
  use case of the
  [`synQuery()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Query.md)
  function that allows you to determine what additional metadata about
  the table or query should also be returned. If you do not need this
  additional information then you are better off using the
  [`synQuery()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Query.md)
  function.  
    
  The query for this method uses this Rest API:
  <https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>

- [`synRemoveItem`](https://r-docs.synapse.org/latest/reference/DatasetCollection_RemoveItem.md)`(instance, item)`:
  Removes an entity from the dataset collection. Must be a Dataset or
  EntityRef. Effect is not seen until the dataset collection is stored.
  Unless the version is specified, all entities with the same ID will be
  removed.

- [`synReorderColumn`](https://r-docs.synapse.org/latest/reference/DatasetCollection_ReorderColumn.md)`(instance, name, index)`:
  Reorder a column in the table. Note that this does not store the
  column in Synapse. You must call the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  function on this DatasetCollection instance to store the column in
  Synapse. This is a convenience function to eliminate the need to
  manually reorder the named list stored in the `$columns` attribute.  
    
  You must ensure that the index is within the bounds of the number of
  columns in the table. If you pass in an index that is out of bounds
  the column will be added to the end of the list.

- [`synSetPermissions`](https://r-docs.synapse.org/latest/reference/DatasetCollection_SetPermissions.md)`(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)`:
  Sets permission that a user or group has on an Entity. An Entity may
  have its own ACL or inherit its ACL from a benefactor.

- [`synSnapshot`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Snapshot.md)`(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)`:
  Creates a snapshot of the dataset collection. A snapshot is a saved,
  read-only version of the dataset collection at the time it was
  created. Dataset collection snapshots are created using the
  asynchronous job API.

- [`synUpdateRows`](https://r-docs.synapse.org/latest/reference/DatasetCollection_UpdateRows.md)`(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, date_columns=NULL, date_format=NULL, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)`:
  Update the values of rows in the dataset collection. This method can
  only be used to update values in custom columns. Default columns
  cannot be updated, but may be used as primary keys.  
    
  Limitations:  
    
  - When updating many rows the requests to Synapse will be chunked into
  smaller requests. The limit is 2MB per request. This chunking will
  happen automatically and should not be a concern for most users. If
  you are having issues with the request being too large you may lower
  the number of rows you are trying to update.  
  - The `primary_keys` argument must contain at least one column.  
  - The `primary_keys` argument cannot contain columns that are a LIST
  type.  
  - The `primary_keys` argument cannot contain columns that are a JSON
  type.  
  - The values used as the `primary_keys` must be unique in the table.
  If there are multiple rows with the same values in the `primary_keys`
  the behavior is that an error will be raised.  
  - The columns used in `primary_keys` cannot contain updated values.
  Since the values in these columns are used to determine if a row
  exists, they cannot be updated in the same transaction.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Create a new Dataset Collection from a list of Datasets.
    library(synapser)
    synLogin()

    my_datasets = list(Dataset(id = "syn1234"), Dataset(id = "syn1235"), Dataset(id = "syn1236"))
    my_collection = DatasetCollection(parent_id = "syn987", name = "my-new-collection", items = my_datasets)
    my_collection |> synStore()

## Example 2: Add Datasets to an existing Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()

    # Add a dataset to the collection
    my_collection |> synAddItem(Dataset(id = "syn1235"))
    my_collection |> synStore()

## Example 3: Remove Datasets from a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()

    # Remove a dataset from the collection
    my_collection |> synRemoveItem(Dataset(id = "syn1235"))
    my_collection |> synStore()

## Example 4: Query data from a Dataset Collection.
    library(synapser)
    synLogin()

    row = synQuery(query = "SELECT * FROM syn1234 WHERE id = 'syn1235'")
    print(row)

## Example 5: Add a custom column to a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synAddColumn(Column(name = "my_annotation", column_type = "STRING"))
    my_collection |> synStore()

## Example 6: Update custom column values in a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    # my_annotation must already exist in the dataset collection as a custom column
    modified_data = data.frame(
        id = c("syn1234"),
        my_annotation = c("good data")
    )
    my_collection |> synUpdateRows(values = modified_data, primary_keys = list("id"), dry_run = FALSE)

## Example 7: Save a snapshot of a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synSnapshot(comment = "My first snapshot", label = "My first snapshot")

## Example 8: Deleting a Dataset Collection.
    library(synapser)
    synLogin()

    DatasetCollection(id = "syn4567") |> synDelete()
} # }
```

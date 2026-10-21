\name{Dataset}
\alias{Dataset}
\docType{class}
\title{
Dataset
}
\format{An S3-style class object.}
\description{
A \code{Dataset} object represents the metadata of a Synapse Dataset.
\url{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Dataset.html}
}
\usage{
Dataset(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="dataset", view_type_mask=128L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), size=NULL, checksum=NULL, count=NULL, columns=list(), annotations=list())
}
\arguments{
\item{id}{(Optional[character]) The unique immutable ID for this dataset. A new ID will be generated for new Datasets. Once issued, this ID is guaranteed to never change or be re-issued}
\item{name}{(Optional[character]) The name of this dataset. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses}
\item{parent_id}{(Optional[character]) The ID of the Entity that is the parent of this dataset.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analogous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance.}
\item{version_number}{(Optional[integer]) The version number issued to this version on the object.}
\item{view_entity_type}{(character) The API model string for the type of view. This is used to determine the default columns that are added to the table. Defaults to \code{"dataset"}.}
\item{view_type_mask}{(integer) The Bit Mask representing Dataset type. As defined in the Synapse REST API: \url{https://rest-docs.synapse.org/rest/GET/column/tableview/defaults.html}. Defaults to 128.}
\item{include_default_columns}{(Optional[logical]) When creating a dataset or view, specifies if default columns should be included. Default columns are columns that are automatically added to the dataset or view. These columns are managed by Synapse and cannot be modified. If you attempt to create a column with the same name as a default column, you will receive a warning when you store the dataset.\cr
\cr
\strong{\code{include_default_columns} is only used if this is the first time that the view is being stored.} If you are updating an existing view this attribute will be ignored.\cr
\cr
The column you are overriding will not behave the same as a default column. For example, suppose you create a column called \code{id} on a Dataset. When using a default column, the \code{id} stores the Synapse ID of each of the entities included in the scope of the view. If you override the \code{id} column with a new column, the \code{id} column will no longer store the Synapse ID of the entities in the view. Instead, it will store the values you provide when you store the dataset. It will be stored as an annotation on the entity for the row you are modifying.}
\item{description}{(Optional[character]) The description of the dataset. Must be 1000 characters or less.}
\item{etag}{(Optional[character]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[character]) The date this dataset was created.}
\item{modified_on}{(Optional[character]) The date this dataset was last modified. In YYYY-MM-DD-Thh:mm:ss.sssZ format}
\item{created_by}{(Optional[character]) The ID of the user that created this dataset.}
\item{modified_by}{(Optional[character]) The ID of the user that last modified this dataset.}
\item{version_label}{(Optional[character]) The version label for this dataset.}
\item{version_comment}{(Optional[character]) The version comment for this dataset.}
\item{is_latest_version}{(Optional[logical]) If this is the latest version of the object.}
\item{is_search_enabled}{(Optional[logical]) When creating or updating a dataset or view specifies if full text search should be enabled. Note that enabling full text search might slow down the indexing of the dataset or view.}
\item{items}{(Optional[list[EntityRef]]) The flat list of file entity references that define this dataset. This is effectively a list of the rows that are in/will be in the dataset after it is stored. The only way to add or remove rows is to add or remove items from this list.}
\item{size}{(Optional[integer]) The cumulative size, in bytes, of all items (files) in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{checksum}{(Optional[character]) The checksum is computed over a sorted concatenation of the checksums of all items in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{count}{(Optional[integer]) The number of items/files in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{columns}{(Optional; a list of Column objects or a named list of Column objects) The columns of this dataset. This is an ordered named list where the key is the name of the column and the value is the Column object. When creating a new instance of a Dataset object you may pass any of the following types as the \code{columns} argument:\cr
\cr
- A list of Column objects\cr
- A named list where the key is the name of the column and the value is the Column object\cr
\cr
The order of the columns will be the order they are stored in Synapse. If you need to reorder the columns the recommended approach is to use the \code{\link[=Dataset_synReorderColumn]{synReorderColumn}()} function. Additionally, you may add, and delete columns using the \code{\link[=Dataset_synAddColumn]{synAddColumn}()}, and \code{\link[=Dataset_synDeleteColumn]{synDeleteColumn}()} functions on your dataset class instance.\cr
\cr
You may modify the attributes of the Column object to change the column type, name, or other attributes. For example, suppose you'd like to change a column from a INTEGER to a DOUBLE. You can do so by changing the column type attribute of the Column object. The next time you store the dataset the column will be updated in Synapse with the new type.\cr
\cr
\preformatted{
library(synapser)
synLogin()

dataset = Dataset(id = "syn1234") |> synGet()
dataset$columns[["my_column"]]$column_type = "DOUBLE"
dataset = dataset |> synStore()
}\cr
\cr
Note that the keys in this named list should match the column names as they are in Synapse. However, know that the name attribute of the Column object is used for all interactions with the Synapse API. The named list key is purely for the usage of this interface. For example, if you wish to rename a column you may do so by changing the name attribute of the Column object. The key in the named list does not need to be changed. The next time you store the dataset the column will be updated in Synapse with the new name and the key in the named list will be updated.}
\item{annotations}{(Optional[named list]) Additional metadata associated with the dataset. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a new dataset from a list of EntityRefs.
    # Dataset items consist of references to Synapse Files using an Entity Reference.
    # If you are adding items to a Dataset directly, you must provide them in the form of
    # an EntityRef class instance.
    library(synapser)
    synLogin()

    my_entity_refs = list(EntityRef(id = "syn1234"), EntityRef(id = "syn1235"), EntityRef(id = "syn1236"))
    my_dataset = Dataset(parent_id = "syn987", name = "my-new-dataset", items = my_entity_refs)
    my_dataset |> synStore()

## Example 2: Add entities to an existing dataset.
    # Using synAddItem(), you can add Synapse entities that are Files, Folders, or EntityRefs that point to a Synapse entity.
    # If the entity is a Folder (or an EntityRef that points to a folder), all of the child Files
    # within the Folder will be added to the Dataset recursively.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()

    # Add a file to the dataset
    my_dataset |> synAddItem(File(id = "syn1235"))

    # Add a folder to the dataset
    # All child files are recursively added to the dataset
    my_dataset |> synAddItem(Folder(id = "syn1236"))

    # Add an entity reference to the dataset
    my_dataset |> synAddItem(EntityRef(id = "syn1237", version = 1L))

    my_dataset |> synStore()

## Example 3: Remove entities from a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()

    # Remove a file from the dataset
    my_dataset |> synRemoveItem(File(id = "syn1235"))

    # Remove a folder from the dataset
    # All child files are recursively removed from the dataset
    my_dataset |> synRemoveItem(Folder(id = "syn1236"))

    # Remove an entity reference from the dataset
    my_dataset |> synRemoveItem(EntityRef(id = "syn1237", version = 1L))

    my_dataset |> synStore()

## Example 4: Query data from a dataset.
    library(synapser)
    synLogin()

    row = synQuery(query = "SELECT * FROM syn1234 WHERE id = 'syn1235'")
    print(row)

## Example 5: Add a custom column to a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddColumn(Column(name = "my_annotation", column_type = "STRING"))
    my_dataset |> synStore()

## Example 6: Update custom column values in a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    # my_annotation must already exist in the dataset as a custom column
    modified_data = data.frame(
        id = c("syn1234"),
        my_annotation = c("good data")
    )
    my_dataset |> synUpdateRows(values = modified_data, primary_keys = list("id"), dry_run = FALSE)

## Example 7: Save a snapshot of a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synSnapshot(comment = "My first snapshot", label = "My first snapshot")

## Example 8: Deleting a dataset.
    library(synapser)
    synLogin()

    Dataset(id = "syn4567") |> synDelete()
}
}
\section{Methods}{
\itemize{
\item \code{Dataset(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="dataset", view_type_mask=128L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), size=NULL, checksum=NULL, count=NULL, columns=list(), annotations=list())}: Constructor for \code{\link{Dataset}}
\item \code{\link[=Dataset_synAddColumn]{synAddColumn}(instance, column, index=NULL)}: Add column(s) to the table. Note that this does not store the column(s) in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Dataset instance to
store the column(s) in Synapse. This is a convenience function to eliminate
the need to manually add the column(s) to the \code{$columns} list.
\cr
\cr
This function will add an item to the \code{$columns} attribute of the Dataset
instance. \code{$columns} is a named list where the key is the name of the column
and the value is the Column object.
\item \code{\link[=Dataset_synAddItem]{synAddItem}(instance, item, synapse_client=NULL)}: Adds an item in the form of an \code{\link{EntityRef}} to the dataset.
For Folders, children are added recursively. Effect is not seen
until the dataset is stored.
\item \code{\link[=Dataset_synDeleteColumn]{synDeleteColumn}(instance, name)}: Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Dataset instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the named list and add it to the
\code{$_columns_to_delete} attribute.
\item \code{\link[=Dataset_synDeletePermissions]{synDeletePermissions}(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.
\cr
\cr
In order to remove permissions for a specific user or group, you
should use the \code{\link[=Dataset_synSetPermissions]{synSetPermissions}()} function with the \code{access_type} set to
an empty list.
\cr
\cr
By default, Entities such as FileEntity and Folder inherit their permission from
their containing Project. For such Entities the Project is the Entity's 'benefactor'.
This permission inheritance can be overridden by creating an ACL for the Entity.
When this occurs the Entity becomes its own benefactor and all permission are
determined by its own ACL.
\cr
\cr
If the ACL of an Entity is deleted, then its benefactor will automatically be set
to its parent's benefactor.
\cr
\cr
\strong{Special notice for Projects:} The ACL for a Project cannot be deleted, you
must individually update or revoke the permissions for each user or group.
\item \code{\link[=Dataset_synGetAcl]{synGetAcl}(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}
that a user or group has on an Entity.
\item \code{\link[=Dataset_synGetPermissions]{synGetPermissions}(instance, synapse_client=NULL)}: Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
\item \code{\link[=Dataset_synListAcl]{synListAcl}(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.
\cr
\cr
This function returns the local sharing settings for the entity and optionally
its children. It provides a mapping of all ACLs for the given container/entity.
\cr
\cr
\strong{Important Note:} This function returns the LOCAL sharing settings only, not
the effective permissions that each Synapse User ID/Team has on the entities.
More permissive permissions could be granted via a Team that the user has access
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{\link[=Dataset_synQuery]{synQuery}(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. The results will always be
returned as a data frame unless you specify a \code{download_location} in which
case the results will be downloaded to that location. There are a number of
arguments that you may pass to this function depending on if you are getting
the results back as a data frame or downloading the results to a file.
\item \code{\link[=Dataset_synQueryPartMask]{synQueryPartMask}(query, part_mask, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. This is a more advanced use case
of the \code{\link[=Dataset_synQuery]{synQuery}()} function that allows you to determine what additional metadata
about the table or query should also be returned. If you do not need this
additional information then you are better off using the \code{\link[=Dataset_synQuery]{synQuery}()} function.
\cr
\cr
The query for this method uses this Rest API:
\url{https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html}
\item \code{\link[=Dataset_synRemoveItem]{synRemoveItem}(instance, item, synapse_client=NULL)}: Removes an item from the dataset. For Folders, all
children of the folder are removed recursively.
Effect is not seen until the dataset is stored.
\item \code{\link[=Dataset_synReorderColumn]{synReorderColumn}(instance, name, index)}: Reorder a column in the table. Note that this does not store the column in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Dataset instance to
store the column in Synapse. This is a convenience function to eliminate
the need to manually reorder the named list stored in the \code{$columns} attribute.
\cr
\cr
You must ensure that the index is within the bounds of the number of columns in
the table. If you pass in an index that is out of bounds the column will be
added to the end of the list.
\item \code{\link[=Dataset_synSetPermissions]{synSetPermissions}(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{\link[=Dataset_synSnapshot]{synSnapshot}(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)}: Creates a snapshot of the dataset. A snapshot is a saved, read-only version of the dataset
at the time it was created. Dataset snapshots are created using the asynchronous job API.
\item \code{\link[=Dataset_synUpdateRows]{synUpdateRows}(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, date_columns=NULL, date_format=NULL, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)}: Update the values of rows in the dataset. This method can only
be used to update values in custom columns. Default columns cannot be updated, but
may be used as primary keys.
\cr
\cr
Limitations:
\cr
\cr
- When updating many rows the requests to Synapse will be chunked into smaller
    requests. The limit is 2MB per request. This chunking will happen
    automatically and should not be a concern for most users. If you are
    having issues with the request being too large you may lower the
    number of rows you are trying to update.\cr
- The \code{primary_keys} argument must contain at least one column.\cr
- The \code{primary_keys} argument cannot contain columns that are a LIST type.\cr
- The \code{primary_keys} argument cannot contain columns that are a JSON type.\cr
- The values used as the \code{primary_keys} must be unique in the table. If there
    are multiple rows with the same values in the \code{primary_keys} the behavior
    is that an error will be raised.\cr
- The columns used in \code{primary_keys} cannot contain updated values. Since
    the values in these columns are used to determine if a row exists, they
    cannot be updated in the same transaction.
}
}

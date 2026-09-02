%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Dataset}
\alias{Dataset}
\docType{class}
\title{
Dataset
}
\format{An S3-style class object.}
\description{
A \code{Dataset} object represents the metadata of a Synapse Dataset.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Dataset.html>
}
\usage{
Dataset(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), view_entity_type="dataset", view_type_mask=128L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), size=NULL, checksum=NULL, count=NULL, columns=list(), annotations=list())
}
\arguments{
\item{id}{}
\item{name}{}
\item{parent_id}{}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analogous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance.}
\item{version_number}{(Optional[int]) The version number issued to this version on the object.}
\item{_last_persistent_instance}{}
\item{_columns_to_delete}{}
\item{view_entity_type}{}
\item{view_type_mask}{}
\item{include_default_columns}{(Optional[bool]) When creating a dataset or view, specifies if default columns should be included. Default columns are columns that are automatically added to the dataset or view. These columns are managed by Synapse and cannot be modified. If you attempt to create a column with the same name as a default column, you will receive a warning when you store the dataset.\cr
\cr
**\code{include_default_columns} is only used if this is the first time that the view is being stored.** If you are updating an existing view this attribute will be ignored. If you want to add all default columns back to your view then you may use this code snippet to accomplish this:\cr
\cr
import asyncio from synapseclient import Synapse from synapseclient.models import Dataset\cr
\cr
syn = Synapse() syn.login()\cr
\cr
async def main(): view = await Dataset(id="syn1234").get_async() await view._append_default_columns() await view.store_async()\cr
\cr
asyncio.run(main())\cr
\cr
The column you are overriding will not behave the same as a default column. For example, suppose you create a column called \code{id} on a Dataset. When using a default column, the \code{id} stores the Synapse ID of each of the entities included in the scope of the view. If you override the \code{id} column with a new column, the \code{id} column will no longer store the Synapse ID of the entities in the view. Instead, it will store the values you provide when you store the dataset. It will be stored as an annotation on the entity for the row you are modifying.}
\item{description}{}
\item{etag}{}
\item{created_on}{}
\item{modified_on}{}
\item{created_by}{}
\item{modified_by}{}
\item{version_label}{(Optional[str]) The version label for this dataset.}
\item{version_comment}{(Optional[str]) The version comment for this dataset.}
\item{is_latest_version}{(Optional[bool]) If this is the latest version of the object.}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a dataset or view specifies if full text search should be enabled. Note that enabling full text search might slow down the indexing of the dataset or view.}
\item{items}{(Optional[list[EntityRef]]) The flat list of file entity references that define this dataset. This is effectively a list of the rows that are in/will be in the dataset after it is stored. The only way to add or remove rows is to add or remove items from this list.}
\item{size}{(Optional[int]) The cumulative size, in bytes, of all items (files) in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{checksum}{(Optional[str]) The checksum is computed over a sorted concatenation of the checksums of all items in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{count}{(Optional[int]) The number of items/files in the dataset. This is only correct after the dataset has been stored or newly read from Synapse.}
\item{columns}{}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the dataset. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a new dataset from a list of EntityRefs.
    # Dataset items consist of references to Synapse Files using an Entity Reference.
    # If you are adding items to a Dataset directly, you must provide them in the form of
    # an \code{EntityRef} class instance.

    from synapseclient import Synapse
    from synapseclient.models import Dataset, EntityRef

    syn = Synapse()
    syn.login()

    my_entity_refs = [EntityRef(id="syn1234"), EntityRef(id="syn1235"), EntityRef(id="syn1236")]
    my_dataset = Dataset(parent_id="syn987", name="my-new-dataset", items=my_entity_refs)
    my_dataset.store()

## Example 2: Add entities to an existing dataset.
    # Using \code{add_item}, you can add Synapse entities that are Files, Folders, or EntityRefs that point to a Synapse entity.
    # If the entity is a Folder (or an EntityRef that points to a folder), all of the child Files
    # within the Folder will be added to the Dataset recursively.

    from synapseclient import Synapse
    from synapseclient.models import Dataset, File, Folder, EntityRef

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()

    # Add a file to the dataset
    my_dataset.add_item(File(id="syn1235"))

    # Add a folder to the dataset
    # All child files are recursively added to the dataset
    my_dataset.add_item(Folder(id="syn1236"))

    # Add an entity reference to the dataset
    my_dataset.add_item(EntityRef(id="syn1237", version=1))

    my_dataset.store()

## Example 3: Remove entities from a dataset.


    from synapseclient import Synapse
    from synapseclient.models import Dataset, File, Folder, EntityRef

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()

    # Remove a file from the dataset
    my_dataset.remove_item(File(id="syn1235"))

    # Remove a folder from the dataset
    # All child files are recursively removed from the dataset
    my_dataset.remove_item(Folder(id="syn1236"))

    # Remove an entity reference from the dataset
    my_dataset.remove_item(EntityRef(id="syn1237", version=1))

    my_dataset.store()

## Example 4: Query data from a dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()
    row = my_dataset.query(query="SELECT * FROM syn1234 WHERE id = 'syn1235'")
    print(row)

## Example 5: Add a custom column to a dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset, Column, ColumnType

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()
    my_dataset.add_column(Column(name="my_annotation", column_type=ColumnType.STRING))
    my_dataset.store()

## Example 6: Update custom column values in a dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()
    # my_annotation must already exist in the dataset as a custom column
    modified_data = pd.DataFrame(
        {"id": ["syn1234"], "my_annotation": ["good data"]}
    )
    my_dataset.update_rows(values=modified_data, primary_keys=["id"], dry_run=False)

## Example 7: Save a snapshot of a dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset

    syn = Synapse()
    syn.login()

    my_dataset = Dataset(id="syn1234").get()
    my_dataset.snapshot(comment="My first snapshot", label="My first snapshot")

## Example 8: Deleting a dataset
    from synapseclient import Synapse
    from synapseclient.models import Dataset

    syn = Synapse()
    syn.login()

    Dataset(id="syn4567").delete()
}
}
\section{Methods}{
\itemize{
\item \code{Dataset(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), view_entity_type="dataset", view_type_mask=128L, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, items=list(), size=NULL, checksum=NULL, count=NULL, columns=list(), annotations=list())}: Constructor for \code{\link{Dataset}}
\item \code{add_column(column, index=NULL)}: Add column(s) to the table. Note that this does not store the column(s) in\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
store the column(s) in Synapse. This is a convenience function to eliminate\cr
the need to manually add the column(s) to the dictionary.\cr
\cr
\cr
This function will add an item to the \code{.columns} attribute of this class\cr
instance. \code{.columns} is a dictionary where the key is the name of the column\cr
and the value is the Column object.
\item \code{add_item(item, synapse_client=NULL)}: Adds an item in the form of an EntityRef to the dataset.\cr
For Folders, children are added recursively. Effect is not seen\cr
until the dataset is stored.
\item \code{delete_column(name)}: Mark a column for deletion. Note that this does not delete the column from\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
delete the column from Synapse. This is a convenience function to eliminate\cr
the need to manually delete the column from the dictionary and add it to the\cr
\code{._columns_to_delete} attribute.
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
\item \code{get_acl(principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{get_permissions(synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{list_acl(recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL, _progress_bar=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{query(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. The results will always be\cr
returned as a Pandas DataFrame unless you specify a \code{download_location} in which\cr
case the results will be downloaded to that location. There are a number of\cr
arguments that you may pass to this function depending on if you are getting\cr
the results back as a DataFrame or downloading the results to a file.
\item \code{query_part_mask(query, part_mask, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. This is a more advanced use case\cr
of the \code{query} function that allows you to determine what addiitional metadata\cr
about the table or query should also be returned. If you do not need this\cr
additional information then you are better off using the \code{query} function.\cr
\cr
The query for this method uses this Rest API:\cr
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
\item \code{remove_item(item, synapse_client=NULL)}: Removes an item from the dataset. For Folders, all\cr
children of the folder are removed recursively.\cr
Effect is not seen until the dataset is stored.
\item \code{reorder_column(name, index)}: Reorder a column in the table. Note that this does not store the column in\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
store the column in Synapse. This is a convenience function to eliminate\cr
the need to manually reorder the \code{.columns} attribute dictionary.\cr
\cr
You must ensure that the index is within the bounds of the number of columns in\cr
the table. If you pass in an index that is out of bounds the column will be\cr
added to the end of the list.
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{snapshot(comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)}: Creates a snapshot of the dataset. A snapshot is a saved, read-only version of the dataset\cr
at the time it was created. Dataset snapshots are created using the asyncronous job API.
\item \code{update_rows(values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)}: Update the values of rows in the dataset. This method can only\cr
be used to update values in custom columns. Default columns cannot be updated, but\cr
may be used as primary keys.\cr
\cr
Limitations:\cr
\cr
- When updating many rows the requests to Synapse will be chunked into smaller\cr
    requests. The limit is 2MB per request. This chunking will happen\cr
    automatically and should not be a concern for most users. If you are\cr
    having issues with the request being too large you may lower the\cr
    number of rows you are trying to update.\cr
- The \code{primary_keys} argument must contain at least one column.\cr
- The \code{primary_keys} argument cannot contain columns that are a LIST type.\cr
- The \code{primary_keys} argument cannot contain columns that are a JSON type.\cr
- The values used as the \code{primary_keys} must be unique in the table. If there\cr
    are multiple rows with the same values in the \code{primary_keys} the behavior\cr
    is that an exception will be raised.\cr
- The columns used in \code{primary_keys} cannot contain updated values. Since\cr
    the values in these columns are used to determine if a row exists, they\cr
    cannot be updated in the same transaction.
}
}


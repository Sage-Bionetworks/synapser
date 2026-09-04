%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{EntityView}
\alias{EntityView}
\docType{class}
\title{
EntityView
}
\format{An S3-style class object.}
\description{
A view of Entities within a defined scope. The purpose of a \code{EntityView}, also known
as an \code{FileView}, is to create a SQL-like view of entities within a
defined scope. The scope is defined by the \code{scope_ids} attribute. The \code{scope_ids}
attribute is a list of \code{syn} container ids that define where to search for rows to
include in the view. Entities within the scope are included in the view if they
match the criteria defined by the \code{view_type_mask} attribute. The \code{view_type_mask}
attribute is a bit mask representing the types to include in the view. You may set
this to a single value using the [ViewTypeMask][synapseclient.models.ViewTypeMask]
enum or you may set this to multiple values using the bitwise OR operator.
}
\usage{
EntityView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), view_entity_type=NULL, view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), is_search_enabled=NULL, scope_ids=list(), annotations=list())
}
\arguments{
\item{id}{}
\item{name}{}
\item{parent_id}{}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analygous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance. Activity cannot be removed during a store operation by setting it to None. You must use: \code{\link[=synDelete]{synDelete}} or \code{\link[=synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}}.}
\item{version_number}{}
\item{_last_persistent_instance}{}
\item{_columns_to_delete}{}
\item{view_entity_type}{}
\item{view_type_mask}{(Optional[Union[int, ViewTypeMask]]) Bit mask representing the types to include in the view. You may set this to a single value using the [ViewTypeMask][synapseclient.models.ViewTypeMask] enum or you may set this to multiple values using the bitwise OR operator. When this is returned after storing or reading from Synapse it will be returned as an integer.\cr
\cr
The following are the possible types (type=):\cr
\cr
- File=0x01 - Project=0x02 - Table=0x04 - Folder=0x08 - View=0x10 - Docker=0x20 - SubmissionView=0x40 - Dataset=0x80 - DatasetCollection=0x100 - MaterializedView=0x200\cr
\cr
To include multiple types in the view you will be using the bitwise OR operator to combine the types. For example, if you want to include both Files and Folders in the view you would use the following code:\cr
\cr
from synapseclient import Synapse from synapseclient.models import EntityView, ViewTypeMask\cr
\cr
syn = Synapse() syn.login()\cr
\cr
view = EntityView(name="My EntityView", parent_id="syn1234", scope_ids=["syn1234"], view_type_mask=ViewTypeMask.FILE | ViewTypeMask.FOLDER).store()}
\item{include_default_columns}{(Optional[bool]) When creating a entityview or view, specifies if default columns should be included. Default columns are columns that are automatically added to the entityview or view. These columns are managed by Synapse and cannot be modified. If you attempt to create a column with the same name as a default column, you will receive a warning when you store the entityview.\cr
\cr
**\code{include_default_columns} is only used if this is the first time that the view is being stored.** If you are updating an existing view this attribute will be ignored. If you want to add all default columns back to your view then you may use this code snippet to accomplish this:\cr
\cr
import asyncio from synapseclient import Synapse from synapseclient.models import EntityView # May also use: Dataset\cr
\cr
syn = Synapse() syn.login()\cr
\cr
async def main(): view = await EntityView(id="syn1234").get_async() await view._append_default_columns() await view.store_async()\cr
\cr
asyncio.run(main())\cr
\cr
The column you are overriding will not behave the same as a default column. For example, suppose you create a column called \code{id} on a EntityView. When using a default column, the \code{id} stores the Synapse ID of each of the entities included in the scope of the view. If you override the \code{id} column with a new column, the \code{id} column will no longer store the Synapse ID of the entities in the view. Instead, it will store the values you provide when you store the entityview. It will be stored as an annotation on the entity for the row you are modifying.}
\item{description}{}
\item{etag}{}
\item{created_on}{}
\item{modified_on}{}
\item{created_by}{}
\item{modified_by}{}
\item{version_label}{}
\item{version_comment}{}
\item{is_latest_version}{}
\item{columns}{}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a dataset or view specifies if full text search should be enabled. Note that enabling full text search might slow down the indexing of the dataset or view.}
\item{scope_ids}{(Optional[set[str]]) The list of container ids that define the scope of this view. This may be a single container or multiple containers. A container in this context may refer to a Project or Folder which contains zero or more entities. The entities in the container(s) will be included in the view if they match the criteria defined by the \code{view_type_mask} attribute.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the entityview. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{EntityView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), view_entity_type=NULL, view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), is_search_enabled=NULL, scope_ids=list(), annotations=list())}: Constructor for \code{\link{EntityView}}
\item \code{add_column(column, index=NULL)}: Add column(s) to the entityview. Note that this does not store the column(s) in\cr
Synapse. You must call the \code{.store()} function on this entityview class instance to\cr
store the column(s) in Synapse. This is a convenience function to eliminate\cr
the need to manually add the column(s) to the dictionary.\cr
\cr
\cr
This function will add an item to the \code{.columns} attribute of this class\cr
instance. \code{.columns} is a dictionary where the key is the name of the column\cr
and the value is the Column object.
\item \code{bind_schema(json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{delete_column(name)}: Mark a column for deletion. Note that this does not delete the column from\cr
Synapse. You must call the \code{.store()} function on this entityview class instance to\cr
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
\item \code{reorder_column(name, index)}: Reorder a column in the entityview. Note that this does not store the column in\cr
Synapse. You must call the \code{.store()} function on this entityview class instance to\cr
store the column in Synapse. This is a convenience function to eliminate\cr
the need to manually reorder the \code{.columns} attribute dictionary.\cr
\cr
You must ensure that the index is within the bounds of the number of columns in\cr
the entityview. If you pass in an index that is out of bounds the column will be\cr
added to the end of the list.
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{snapshot(comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)}: Creates a snapshot of the \code{View}-like entity.\cr
Synapse handles snapshot creation differently for \code{Table}- and \code{View}-like\cr
entities. \code{View} snapshots are created using the asyncronous job API.\cr
\cr
\cr
Making a snapshot of a view allows you to create an immutable version of the\cr
view at the time of the snapshot. This is useful to create checkpoints in time\cr
that you may go back and reference, or use in a publication. Snapshots are\cr
immutable and cannot be changed. They may only be deleted.
\item \code{unbind_schema(synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{update_rows(values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)}: This method leverages the logic provided by [upsert_rows_async][synapseclient.models.Table.upsert_rows_async] to provide\cr
an interface for updating rows in a \code{View}-like entity. Update functionality will only work for\cr
values in custom columns within a \code{View}-like entity.\cr
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
\item \code{validate_schema(synapse_client=NULL)}: Validate the entity against the bound JSON schema.
}
}


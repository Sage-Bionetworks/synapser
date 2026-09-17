%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionView}
\alias{SubmissionView}
\docType{class}
\title{
SubmissionView
}
\format{An S3-style class object.}
\description{
A \code{SubmissionView} object represents the metadata of a Synapse Submission View.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/SubmissionView.html>
}
\usage{
SubmissionView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="submissionview", view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), annotations=list(), is_search_enabled=NULL, scope_ids=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this entity. A new ID will be generated for new Entities. Once issued, this ID is guaranteed to never change or be re-issued.}
\item{name}{(Optional[str]) The name of this entity. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses.}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this Entity.}
\item{activity}{}
\item{version_number}{(Optional[int]) The version number issued to this version on the object.}
\item{view_entity_type}{(ViewEntityType) The API model string for the type of view. This is used to determine the default columns that are added to the table. Must be defined as a \code{ViewEntityType} enum.}
\item{view_type_mask}{}
\item{include_default_columns}{}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this entity was created.}
\item{modified_on}{(Optional[str]) The date this entity was last modified.}
\item{created_by}{(Optional[str]) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this entity.}
\item{version_label}{(Optional[str]) The version label for this entity.}
\item{version_comment}{(Optional[str]) The version comment for this entity.}
\item{is_latest_version}{(Optional[bool]) If this is the latest version of the object.}
\item{columns}{(Optional[Union[list[Column], OrderedDict[str, Column], dict[str, Column]]]) The columns of this submission view. This is an ordered dictionary where the key is the name of the column and the value is the Column object. When creating a new instance of a SubmissionView object you may pass any of the following types as the \code{columns} argument: - A list of Column objects - A dictionary where the key is the name of the column and the value is the Column object - An OrderedDict where the key is the name of the column and the value is the Column object The order of the columns will be the order they are stored in Synapse. If you need to reorder the columns the recommended approach is to use the \code{.reorder_column()} method. Additionally, you may add, and delete columns using the \code{.add_column()}, and \code{.delete_column()} methods on your view class instance.\cr
\cr
You may modify the attributes of the Column object to change the column type, name, or other attributes. For example, suppose you'd like to change a column from a INTEGER to a DOUBLE. You can do so by changing the column type attribute of the Column object. The next time you store the view the column will be updated in Synapse with the new type. from synapseclient import Synapse from synapseclient.models import SubmissionView, Column, ColumnType\cr
\cr
syn = Synapse() syn.login()\cr
\cr
submission_view = SubmissionView(id="syn1234").get() submission_view.columns["my_column"].column_type = ColumnType.DOUBLE submission_view.store() Note that the keys in this dictionary should match the column names as they are in Synapse. However, know that the name attribute of the Column object is used for all interactions with the Synapse API. The OrderedDict key is purely for the usage of this interface. For example, if you wish to rename a column you may do so by changing the name attribute of the Column object. The key in the OrderedDict does not need to be changed. The next time you store the view the column will be updated in Synapse with the new name and the key in the OrderedDict will be updated.}
\item{annotations}{}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a table or view, specifies if full-text search should be enabled. Note that enabling full-text search might slow down the indexing of the table or view.}
\item{scope_ids}{(list[str]) The list of container IDs that define the scope of this view. For submission views, this is the list of evaluation queues that the view is associated with.}
}
\value{
NULL
}
\examples{
\dontrun{
## Create a new SubmissionView.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionView

    syn = Synapse()
    syn.login()

    my_submission_view = SubmissionView(
        name="My Submission View",
        parent_id="syn1234",
        scope_ids=["syn5678", "syn6789"],  # IDs of evaluation queues
    ).store()
    print(my_submission_view)
}
}
\section{Methods}{
\itemize{
\item \code{SubmissionView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, view_entity_type="submissionview", view_type_mask=NULL, include_default_columns=TRUE, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), annotations=list(), is_search_enabled=NULL, scope_ids=list())}: Constructor for \code{\link{SubmissionView}}
\item \code{synAddColumn(instance, column, index=NULL)}: Add column(s) to the table. Note that this does not store the column(s) in\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
store the column(s) in Synapse. This is a convenience function to eliminate\cr
the need to manually add the column(s) to the dictionary.\cr
\cr
\cr
This function will add an item to the \code{.columns} attribute of this class\cr
instance. \code{.columns} is a dictionary where the key is the name of the column\cr
and the value is the Column object.
\item \code{synDeleteColumn(instance, name)}: Mark a column for deletion. Note that this does not delete the column from\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
delete the column from Synapse. This is a convenience function to eliminate\cr
the need to manually delete the column from the dictionary and add it to the\cr
\code{._columns_to_delete} attribute.
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
\item \code{synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{synGetPermissions(instance, synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{synListAcl(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{synQuery(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. The results will always be\cr
returned as a Pandas DataFrame unless you specify a \code{download_location} in which\cr
case the results will be downloaded to that location. There are a number of\cr
arguments that you may pass to this function depending on if you are getting\cr
the results back as a DataFrame or downloading the results to a file.
\item \code{synQueryPartMask(query, part_mask, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. This is a more advanced use case\cr
of the \code{query} function that allows you to determine what addiitional metadata\cr
about the table or query should also be returned. If you do not need this\cr
additional information then you are better off using the \code{query} function.\cr
\cr
The query for this method uses this Rest API:\cr
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
\item \code{synReorderColumn(instance, name, index)}: Reorder a column in the table. Note that this does not store the column in\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
store the column in Synapse. This is a convenience function to eliminate\cr
the need to manually reorder the \code{.columns} attribute dictionary.\cr
\cr
You must ensure that the index is within the bounds of the number of columns in\cr
the table. If you pass in an index that is out of bounds the column will be\cr
added to the end of the list.
\item \code{synSetPermissions(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)}: Creates a snapshot of the \code{SubmissionView} entity.\cr
Synapse handles snapshot creation differently for \code{Table}- and \code{View}-like\cr
entities. \code{View} snapshots are created using the asyncronous job API.\cr
\cr
Making a snapshot of a view allows you to create an immutable version of the\cr
view at the time of the snapshot. This is useful to create checkpoints in time\cr
that you may go back and reference, or use in a publication. Snapshots are\cr
immutable and cannot be changed. They may only be deleted.
}
}


%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{MaterializedView}
\alias{MaterializedView}
\docType{class}
\title{
MaterializedView
}
\format{An S3-style class object.}
\description{
A materialized view is a type of table that is automatically built from a Synapse
SQL query. Its content is read only and based off the \code{defining_sql} attribute.
The SQL of the materialized view may contain JOIN clauses on multiple tables.

A \code{MaterializedView} object represents this concept in Synapse:
<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/MaterializedView.html>
}
\usage{
MaterializedView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=<factory>, is_search_enabled=NULL, defining_sql=NULL, annotations=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this entity. Once issued, this ID is guaranteed to never change or be re-issued.}
\item{name}{(Optional[str]) The name of this entity. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses.}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this entity.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse.}
\item{version_number}{(Optional[int]) The version number issued to this version on the object.}
\item{_last_persistent_instance}{}
\item{_columns_to_delete}{}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this entity was created.}
\item{modified_on}{(Optional[str]) The date this entity was last modified. In YYYY-MM-DD-Thh:mm:ss.sssZ format.}
\item{created_by}{(Optional[str]) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this entity.}
\item{version_label}{(Optional[str]) The version label for this entity.}
\item{version_comment}{(Optional[str]) The version comment for this entity.}
\item{is_latest_version}{(Optional[bool]) If this is the latest version of the object.}
\item{columns}{(Optional[OrderedDict]) (Read Only) The columns of a materialized view are dynamic based on the select statement of the definingSQL. This list of columnIds is for read-only purposes.}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a table or view specifies if full text search should be enabled.}
\item{defining_sql}{(Optional[str]) The synapse SQL statement that defines the data in the materialized view.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the entityview. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a new materialized view with a defining SQL query.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    materialized_view = MaterializedView(
        name="My Materialized View",
        description="A test materialized view",
        parent_id="syn12345",
        defining_sql="SELECT * FROM syn67890"
    )
    materialized_view = materialized_view.store()
    print(f"Created Materialized View with ID: {materialized_view.id}")

## Example 2: Update the defining SQL of an existing materialized view.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    materialized_view = MaterializedView(id="syn12345").get()
    materialized_view.defining_sql = "SELECT column1, column2 FROM syn67890"
    materialized_view = materialized_view.store()
    print("Updated Materialized View defining SQL.")

## Example 3: Delete a materialized view.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    materialized_view = MaterializedView(id="syn12345")
    materialized_view.delete()
    print("Deleted Materialized View.")

## Example 4: Query data from a materialized view.

    from synapseclient import Synapse
    from synapseclient.models import query

    syn = Synapse()
    syn.login()

    query_result = query("SELECT * FROM syn66080386")
    print(query_result)

## Example 5: Retrieve and update annotations for a materialized view.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    materialized_view = MaterializedView(id="syn12345").get()
    materialized_view.annotations["key1"] = ["value1"]
    materialized_view.annotations["key2"] = ["value2"]
    materialized_view.store()
    print("Updated annotations for Materialized View.")

## Example 6: Create a materialized view with a JOIN clause.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    defining_sql = '''
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    '''

    materialized_view = MaterializedView(
        name="Join Materialized View",
        description="A materialized view with a JOIN clause",
        parent_id="syn11111",
        defining_sql=defining_sql,
    )
    materialized_view = materialized_view.store()
    print(f"Created Materialized View with ID: {materialized_view.id}")

## Example 7: Create a materialized view with a LEFT JOIN clause.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    defining_sql = '''
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    LEFT JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    '''

    materialized_view = MaterializedView(
        name="Left Join Materialized View",
        description="A materialized view with a LEFT JOIN clause",
        parent_id="syn11111",
        defining_sql=defining_sql,
    )
    materialized_view = materialized_view.store()
    print(f"Created Materialized View with ID: {materialized_view.id}")

## Example 8: Create a materialized view with a RIGHT JOIN clause.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    defining_sql = '''
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    RIGHT JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    '''

    materialized_view = MaterializedView(
        name="Right Join Materialized View",
        description="A materialized view with a RIGHT JOIN clause",
        parent_id="syn11111",
        defining_sql=defining_sql,
    )
    materialized_view = materialized_view.store()
    print(f"Created Materialized View with ID: {materialized_view.id}")

## Example 9: Create a materialized view with a UNION clause.

    from synapseclient import Synapse
    from synapseclient.models import MaterializedView

    syn = Synapse()
    syn.login()

    defining_sql = '''
    SELECT column1 AS new_column1, column2 AS new_column2
    FROM syn12345
    UNION
    SELECT column1 AS new_column1, column2 AS new_column2
    FROM syn67890
    '''

    materialized_view = MaterializedView(
        name="Union Materialized View",
        description="A materialized view with a UNION clause",
        parent_id="syn11111",
        defining_sql=defining_sql,
    )
    materialized_view = materialized_view.store()
    print(f"Created Materialized View with ID: {materialized_view.id}")
}
}
\section{Methods}{
\itemize{
\item \code{MaterializedView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=<factory>, is_search_enabled=NULL, defining_sql=NULL, annotations=list())}: Constructor for \code{\link{MaterializedView}}
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
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
}
}


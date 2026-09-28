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
MaterializedView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), is_search_enabled=NULL, defining_sql=NULL, annotations=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this entity. Once issued, this ID is guaranteed to never change or be re-issued.}
\item{name}{(Optional[str]) The name of this entity. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses.}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this entity.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse.}
\item{version_number}{(Optional[int]) The version number issued to this version on the object.}
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
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the materialized view. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty named list \code{list()} or NULL and store the entity.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a new materialized view with a defining SQL query.
    library(synapser)
    synLogin()

    materialized_view = MaterializedView(
        name = "My Materialized View",
        description = "A test materialized view",
        parent_id = "syn12345",
        defining_sql = "SELECT * FROM syn67890"
    ) |> synStore()
    print(sprintf("Created Materialized View with ID: \%s", materialized_view$id))

## Example 2: Update the defining SQL of an existing materialized view.
    library(synapser)
    synLogin()

    materialized_view = MaterializedView(id = "syn12345") |>
        synGet() |>
        synSetProperties(defining_sql = "SELECT column1, column2 FROM syn67890") |>
        synStore()
    print("Updated Materialized View defining SQL.")

## Example 3: Delete a materialized view.
    library(synapser)
    synLogin()

    MaterializedView(id = "syn12345") |> synDelete()
    print("Deleted Materialized View.")

## Example 4: Query data from a materialized view.
    library(synapser)
    synLogin()

    query_result = synQuery(query = "SELECT * FROM syn12345")
    print(query_result)

## Example 5: Retrieve and update annotations for a materialized view.
    library(synapser)
    synLogin()

    materialized_view = MaterializedView(id = "syn12345") |> synGet()
    materialized_view = materialized_view |>
        synSetProperties(
            annotations = append(
                materialized_view$annotations,
                list(key1 = "value1", key2 = "value2")
            )
        ) |>
        synStore()
    print("Updated annotations for Materialized View.")

## Example 6: Create a materialized view with a JOIN clause.
    library(synapser)
    synLogin()

    defining_sql = "
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    "

    materialized_view = MaterializedView(
        name = "Join Materialized View",
        description = "A materialized view with a JOIN clause",
        parent_id = "syn11111",
        defining_sql = defining_sql
    ) |> synStore()
    print(sprintf("Created Materialized View with ID: \%s", materialized_view$id))

## Example 7: Create a materialized view with a LEFT JOIN clause.
    library(synapser)
    synLogin()

    defining_sql = "
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    LEFT JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    "

    materialized_view = MaterializedView(
        name = "Left Join Materialized View",
        description = "A materialized view with a LEFT JOIN clause",
        parent_id = "syn11111",
        defining_sql = defining_sql
    ) |> synStore()
    print(sprintf("Created Materialized View with ID: \%s", materialized_view$id))

## Example 8: Create a materialized view with a RIGHT JOIN clause.
    library(synapser)
    synLogin()

    defining_sql = "
    SELECT t1.column1 AS new_column1, t2.column2 AS new_column2
    FROM syn12345 t1
    RIGHT JOIN syn67890 t2
    ON t1.id = t2.foreign_id
    "

    materialized_view = MaterializedView(
        name = "Right Join Materialized View",
        description = "A materialized view with a RIGHT JOIN clause",
        parent_id = "syn11111",
        defining_sql = defining_sql
    ) |> synStore()
    print(sprintf("Created Materialized View with ID: \%s", materialized_view$id))

## Example 9: Create a materialized view with a UNION clause.
    library(synapser)
    synLogin()

    defining_sql = "
    SELECT column1 AS new_column1, column2 AS new_column2
    FROM syn12345
    UNION
    SELECT column1 AS new_column1, column2 AS new_column2
    FROM syn67890
    "

    materialized_view = MaterializedView(
        name = "Union Materialized View",
        description = "A materialized view with a UNION clause",
        parent_id = "syn11111",
        defining_sql = defining_sql
    ) |> synStore()
    print(sprintf("Created Materialized View with ID: \%s", materialized_view$id))
}
}
\section{Methods}{
\itemize{
\item \code{MaterializedView(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, columns=list(), is_search_enabled=NULL, defining_sql=NULL, annotations=list())}: Constructor for \code{\link{MaterializedView}}
\item \code{\link[=MaterializedView_synGetPermissions]{synGetPermissions}(instance, synapse_client=NULL)}: Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
\item \code{\link[=MaterializedView_synSetPermissions]{synSetPermissions}(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{\link[=MaterializedView_synDeletePermissions]{synDeletePermissions}(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire \strong{local} Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.
\cr
\cr
In order to remove permissions for a specific user or group, you
should use the \code{\link[=MaterializedView_synSetPermissions]{synSetPermissions}()} function with the \code{access_type} set to
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
\item \code{\link[=MaterializedView_synGetAcl]{synGetAcl}(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}
that a user or group has on an Entity.
\item \code{\link[=MaterializedView_synListAcl]{synListAcl}(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.
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
\item \code{\link[=MaterializedView_synQuery]{synQuery}(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. The results will always be
returned as a data frame unless you specify a \code{download_location} in which
case the results will be downloaded to that location. There are a number of
arguments that you may pass to this function depending on if you are getting
the results back as a DataFrame or downloading the results to a file.
\item \code{\link[=MaterializedView_synQueryPartMask]{synQueryPartMask}(query, part_mask, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. This is a more advanced use case
of the \code{\link[=MaterializedView_synQuery]{synQuery}()} function that allows you to determine what additional metadata
about the table or query should also be returned. If you do not need this
additional information then you are better off using the \code{\link[=MaterializedView_synQuery]{synQuery}()} function.
\cr
\cr
The query for this method uses this Rest API:\cr
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
}
}

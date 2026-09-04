%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Table}
\alias{Table}
\docType{class}
\title{
Table
}
\format{An S3-style class object.}
\description{
A Table represents the metadata of a table.
}
\usage{
Table(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), description=NULL, columns=list(), etag=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, annotations=list())
}
\arguments{
\item{id}{}
\item{name}{}
\item{parent_id}{}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analygous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance. Activity cannot be removed during a store operation by setting it to None. You must use: \code{\link[=synDelete]{synDelete}} or \code{\link[=synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}}.}
\item{version_number}{(Optional[int]) (Read Only) The version number issued to this version on the object. Use this \code{.snapshot()} method to create a new version of the table.}
\item{_last_persistent_instance}{}
\item{_columns_to_delete}{}
\item{description}{}
\item{columns}{}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this table was created.}
\item{created_by}{(Optional[str]) The ID of the user that created this table.}
\item{modified_on}{(Optional[str]) The date this table was last modified. In YYYY-MM-DD-Thh:mm:ss.sssZ format}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this table.}
\item{version_label}{(Optional[str]) (Read Only) The version label for this table. Use the \code{.snapshot()} method to create a new version of the table.}
\item{version_comment}{(Optional[str]) (Read Only) The version comment for this table. Use the \code{.snapshot()} method to create a new version of the table.}
\item{is_latest_version}{(Optional[bool]) (Read Only) If this is the latest version of the object.}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a table or view specifies if full text search should be enabled. Note that enabling full text search might slow down the indexing of the table or view.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the table. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict \code{{}} or None and store the entity.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create a table with data without specifying columns
    # This API is setup to allow the data to define which columns are created on the
    # Synapse table automatically. The limitation with this behavior is that the
    # columns created will only be of the following types:

    # - STRING
    # - LARGETEXT
    # - INTEGER
    # - DOUBLE
    # - BOOLEAN
    # - DATE

    # The determination of the column type is based on the data that is passed in
    # using the pandas function
    # \href{https://pandas.pydata.org/docs/reference/api/pandas.api.types.infer_dtype.html}{infer_dtype}.
    # If you need a more specific column type, or need to add options to the colums
    # follow the examples below.

    import pandas as pd

    from synapseclient import Synapse
    from synapseclient.models import Table, SchemaStorageStrategy

    syn = Synapse()
    syn.login()

    my_data = pd.DataFrame(
        {
            "my_string_column": ["a", "b", "c", "d"],
            "my_integer_column": [1, 2, 3, 4],
            "my_double_column": [1.0, 2.0, 3.0, 4.0],
            "my_boolean_column": [True, False, True, False],
        }
    )

    table = Table(
        name="my_table",
        parent_id="syn1234",
    ).store()

    table.store_rows(values=my_data, schema_storage_strategy=SchemaStorageStrategy.INFER_FROM_DATA)

    # Prints out the stored data about this specific column
    print(table.columns["my_string_column"])

## Example 2: Rename an existing column
    # This examples shows how you may retrieve a table from synapse, rename a column,
    # and then store the table back in synapse.

    from synapseclient import Synapse
    from synapseclient.models import Table

    syn = Synapse()
    syn.login()

    table = Table(
        name="my_table",
        parent_id="syn1234",
    ).get()

    # You may also get the table by id:
    table = Table(
        id="syn4567"
    ).get()

    table.columns["my_old_column"].name = "my_new_column"

    # Before the data is stored in synapse you'll still be able to use the old key to access the column entry
    print(table.columns["my_old_column"])

    table.store()

    # After the data is stored in synapse you'll be able to use the new key to access the column entry
    print(table.columns["my_new_column"])

## Example 3: Create a table with a list of columns
    # A list of columns may be passed in when creating a new table. The order of the
    # columns in the list will be the order they are stored in Synapse. If the table
    # already exists and you create the Table instance in this way the columns will
    # be appended to the end of the existing columns.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    columns = [
        Column(name="my_string_column", column_type=ColumnType.STRING),
        Column(name="my_integer_column", column_type=ColumnType.INTEGER),
        Column(name="my_double_column", column_type=ColumnType.DOUBLE),
        Column(name="my_boolean_column", column_type=ColumnType.BOOLEAN),
    ]

    table = Table(
        name="my_table",
        parent_id="syn1234",
        columns=columns
    )

    table.store()


## Example 4: Creating a table with a dictionary of columns
    # When specifying a number of columns via a dict setting the \code{name} attribute
    # on the \code{Column} object is optional. When it is not specified it will be
    # pulled from the key of the dict.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    columns = {
        "my_string_column": Column(column_type=ColumnType.STRING),
        "my_integer_column": Column(column_type=ColumnType.INTEGER),
        "my_double_column": Column(column_type=ColumnType.DOUBLE),
        "my_boolean_column": Column(column_type=ColumnType.BOOLEAN),
    }

    table = Table(
        name="my_table",
        parent_id="syn1234",
        columns=columns
    )

    table.store()

## Example 5: Creating a table with an OrderedDict of columns
    # When specifying a number of columns via a dict setting the \code{name} attribute
    # on the \code{Column} object is optional. When it is not specified it will be
    # pulled from the key of the dict.

    from collections import OrderedDict
    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    columns = OrderedDict({
        "my_string_column": Column(column_type=ColumnType.STRING),
        "my_integer_column": Column(column_type=ColumnType.INTEGER),
        "my_double_column": Column(column_type=ColumnType.DOUBLE),
        "my_boolean_column": Column(column_type=ColumnType.BOOLEAN),
    })

    table = Table(
        name="my_table",
        parent_id="syn1234",
        columns=columns
    )

    table.store()
}
}
\section{Methods}{
\itemize{
\item \code{Table(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, _last_persistent_instance=NULL, _columns_to_delete=list(), description=NULL, columns=list(), etag=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, annotations=list())}: Constructor for \code{\link{Table}}
\item \code{add_column(column, index=NULL)}: Add column(s) to the table. Note that this does not store the column(s) in\cr
Synapse. You must call the \code{.store()} function on this table class instance to\cr
store the column(s) in Synapse. This is a convenience function to eliminate\cr
the need to manually add the column(s) to the dictionary.\cr
\cr
\cr
This function will add an item to the \code{.columns} attribute of this class\cr
instance. \code{.columns} is a dictionary where the key is the name of the column\cr
and the value is the Column object.
\item \code{bind_schema(json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
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
\item \code{delete_rows(query=NULL, df=NULL, job_timeout=600L, synapse_client=NULL)}: Delete rows from a table given a query or a pandas dataframe to select rows.\cr
The query at a minimum must select the \code{ROW_ID} and \code{ROW_VERSION} columns. If you want to\cr
inspect the data that will be deleted ahead of time you may use the\cr
\code{.query} method to get the data.\cr
The dataframe must at least contain the \code{ROW_ID} and \code{ROW_VERSION} columns. And \code{ROW_ETAG} column is also required\cr
if the entity is one of the following: \code{EntityView}, \code{Dataset}, \code{DatasetCollection}, or \code{SubmissionView}.\cr
If both query and df are provided, the query will be used.
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
\item \code{snapshot(comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, synapse_client=NULL)}: Request to create a new snapshot of a table. The provided comment, label, and\cr
activity will be applied to the current version thereby creating a snapshot\cr
and locking the current version. After the snapshot is created a new version\cr
will be started with an 'in-progress' label.
\item \code{store_rows(values, schema_storage_strategy=NULL, column_expansion_strategy=NULL, dry_run=FALSE, additional_changes=NULL, insert_size_bytes=943718400L, csv_table_descriptor=NULL, read_csv_kwargs=NULL, to_csv_kwargs=NULL, job_timeout=600L, synapse_client=NULL)}: Add or update rows in Synapse from the sources defined below. In most cases the\cr
result of this function call will append rows to the table. In the case of an\cr
update this method works on a full row replacement. What this means is\cr
that you may not do a partial update of a row. If you want to update a row\cr
you must pass in all the data for that row, or the data for the columns not\cr
provided will be set to null.\cr
\cr
If you'd like to update a row see the example \code{Updating rows in a table} below.\cr
\cr
If you'd like to perform an \code{upsert} or partial update of a row you may use\cr
the \code{.upsert_rows()} method. See that method for more information.\cr
\cr
\cr
Note the following behavior for the order of columns:\cr
\cr
- If a column is added via the \code{add_column} method it will be added at the\cr
    index you specify, or at the end of the columns list.\cr
- If column(s) are added during the contruction of your \code{Table} instance, ie.\cr
    \code{Table(columns=[Column(name="foo")])}, they will be added at the begining\cr
    of the columns list.\cr
- If you use the \code{store_rows} method and the \code{schema_storage_strategy} is set to\cr
    \code{INFER_FROM_DATA} the columns will be added at the end of the columns list.\cr
\cr
\cr
**Limitations:**\cr
\cr
- Synapse limits the number of rows that may be stored in a single request to\cr
    a CSV file that is 1GB. If you are storing a CSV file that is larger than\cr
    this limit the data will be chunked into smaller requests. This process is\cr
    done by reading the file once to determine what the row and byte boundries\cr
    are and calculating the MD5 hash of that portion, then reading the file\cr
    again to send the data to Synapse. This process is done to ensure that the\cr
    data is not corrupted during the upload process, in addition Synapse\cr
    requires the MD5 hash of the data to be sent in the request along with the\cr
    number of bytes that are being sent.\cr
- The limit of 1GB is also enforced when storing a dictionary or a DataFrame.\cr
    The data will be converted to a CSV format using the \code{.to_csv()} pandas\cr
    function. If you are storing more than a 1GB file it is recommended that\cr
    you store the data as a CSV and use the file path to upload the data. This\cr
    is due to the fact that the DataFrame chunking process is slower than\cr
    reading portions of a file on disk and calculating the MD5 hash of that\cr
    portion.\cr
\cr
The following is a Sequence Daigram that describes the process noted in the\cr
limitation above. It shows how the data is chunked into smaller requests when\cr
the data exceeds the limit of 1GB, and how portions of the data are read from\cr
the CSV file on disk while being uploaded to Synapse.\cr
\cr
``\code{mermaid\cr
sequenceDiagram\cr
    participant User\cr
    participant Table\cr
    participant FileSystem\cr
    participant Synapse\cr
\cr
    User->>Table: store_rows(values)\cr
\cr
    alt CSV size > 1GB\cr
        Table->>Synapse: Apply schema changes before uploading\cr
        note over Table, FileSystem: Read CSV twice\cr
        Table->>FileSystem: Read entire CSV (First Pass)\cr
        FileSystem-->>Table: Compute chunk sizes & MD5 hashes\cr
\cr
        loop Read and Upload CSV chunks (Second Pass)\cr
            Table->>FileSystem: Read next chunk from CSV\cr
            FileSystem-->>Table: Return bytes\cr
            Table->>Synapse: Upload CSV chunk\cr
            Synapse-->>Table: Return }file_handle_id\code{\cr
            Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows\cr
            Synapse-->>Table: Transaction result\cr
        end\cr
    else\cr
        Table->>Synapse: Upload CSV without splitting & Any additional schema changes\cr
        Synapse-->>Table: Return }file_handle_id\code{\cr
        Table->>Synapse: Send }TableUpdateTransaction' to append/update rows\cr
        Synapse-->>Table: Transaction result\cr
    end\cr
\cr
    Table-->>User: Upload complete\cr
``\code{\cr
\cr
The following is a Sequence Daigram that describes the process noted in the\cr
limitation above for DataFrames. It shows how the data is chunked into smaller\cr
requests when the data exceeds the limit of 1GB, and how portions of the data\cr
are read from the DataFrame while being uploaded to Synapse.\cr
\cr
}`\code{mermaid\cr
sequenceDiagram\cr
    participant User\cr
    participant Table\cr
    participant MemoryBuffer\cr
    participant Synapse\cr
\cr
    User->>Table: store_rows(DataFrame)\cr
\cr
    loop For all rows in DataFrame in 100 row increments\cr
        Table->>MemoryBuffer: Convert DataFrame rows to CSV in-memory\cr
        MemoryBuffer-->>Table: Compute chunk sizes & MD5 hashes\cr
    end\cr
\cr
\cr
    alt Multiple chunks detected\cr
        Table->>Synapse: Apply schema changes before uploading\cr
    end\cr
\cr
    loop For all chunks found in first loop\cr
        loop for all parts in chunk byte boundry\cr
            Table->>MemoryBuffer: Read small (< 8MB) part of the chunk\cr
            MemoryBuffer-->>Table: Return bytes (with correct offset)\cr
            Table->>Synapse: Upload part\cr
            Synapse-->>Table: Upload response\cr
        end\cr
        Table->>Synapse: Complete upload\cr
        Synapse-->>Table: Return }file_handle_id\code{\cr
        Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows\cr
        Synapse-->>Table: Transaction result\cr
    end\cr
\cr
    Table-->>User: Upload complete\cr
}``
\item \code{unbind_schema(synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{upsert_rows(values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, synapse_client=NULL)}: This method allows you to perform an \code{upsert} (Update and Insert) for row(s).\cr
This means that you may update a row with only the data that you want to change.\cr
When supplied with a row that does not match the given \code{primary_keys} a new\cr
row will be inserted.\cr
\cr
\cr
Using the \code{primary_keys} argument you may specify which columns to use to\cr
determine if a row already exists. If a row exists with the same values in the\cr
columns specified in this list the row will be updated. If a row does not exist\cr
it will be inserted.\cr
\cr
\cr
Limitations:\cr
\cr
- The request to update, and the request to insert data does not occur in a\cr
    single transaction. This means that the update of data may succeed, but the\cr
    insert of data may fail. Additionally, as noted in the limitation below, if\cr
    data is chunked up into multiple requests you may find that a portion of\cr
    your data is updated, but another portion is not.\cr
- The number of rows that may be upserted in a single call should be\cr
    kept to a minimum (< 50,000). There is significant overhead in the request\cr
    to Synapse for each row that is upserted. If you are upserting a large\cr
    number of rows a better approach may be to query for the data you want\cr
    to update, update the data, then use the [store_rows_async][synapseclient.models.mixins.table_components.TableStoreRowMixin.store_rows_async] method to\cr
    update the data in Synapse. Any rows you want to insert may be added\cr
    to the DataFrame that is passed to the [store_rows_async][synapseclient.models.mixins.table_components.TableStoreRowMixin.store_rows_async] method.\cr
- When upserting mnay rows the requests to Synapse will be chunked into smaller\cr
    requests. The limit is 2MB per request. This chunking will happen\cr
    automatically and should not be a concern for most users. If you are\cr
    having issues with the request being too large you may lower the\cr
    number of rows you are trying to upsert, or note the above limitation.\cr
- The \code{primary_keys} argument must contain at least one column.\cr
- The \code{primary_keys} argument cannot contain columns that are a LIST type.\cr
- The \code{primary_keys} argument cannot contain columns that are a JSON type.\cr
- The values used as the \code{primary_keys} must be unique in the table. If there\cr
    are multiple rows with the same values in the \code{primary_keys} the behavior\cr
    is that an exception will be raised.\cr
- The columns used in \code{primary_keys} cannot contain updated values. Since\cr
    the values in these columns are used to determine if a row exists, they\cr
    cannot be updated in the same transaction.\cr
\cr
The following is a Sequence Diagram that describces the upsert process at a\cr
high level:\cr
\cr
``\code{mermaid\cr
sequenceDiagram\cr
    participant User\cr
    participant Table\cr
    participant Synapse\cr
\cr
    User->>Table: upsert_rows()\cr
\cr
    loop Query and Process Updates in Chunks (rows_per_query)\cr
        Table->>Synapse: Query existing rows using primary keys\cr
        Synapse-->>Table: Return matching rows\cr
        Note Over Table: Create partial row updates\cr
\cr
        loop For results from query\cr
            Note Over Table: Sum row/chunk size\cr
            alt Chunk size exceeds update_size_bytes\cr
                Table->>Synapse: Push update chunk\cr
                Synapse-->>Table: Acknowledge update\cr
            end\cr
            Table->>Table: Add row to chunk\cr
        end\cr
\cr
        alt Remaining updates exist\cr
            Table->>Synapse: Push final update chunk\cr
            Synapse-->>Table: Acknowledge update\cr
        end\cr
    end\cr
\cr
    alt New rows exist\cr
        Table->>Table: Identify new rows for insertion\cr
        Table->>Table: Call }store_rows()\code{ function\cr
    end\cr
\cr
    Table-->>User: Upsert complete\cr
}``
\item \code{validate_schema(synapse_client=NULL)}: Validate the entity against the bound JSON schema.
}
}


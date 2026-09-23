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
Table(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, description=NULL, columns=list(), etag=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, annotations=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this table. A new ID will be generated for new Tables. Once issued, this ID is guaranteed to never change or be re-issued}
\item{name}{(Optional[str]) The name of this table. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this table.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analygous to the Activity defined in the \href{https://www.w3.org/TR/prov-n/}{W3C Specification} on Provenance. Activity cannot be removed during a store operation by setting it to None. You must use: \code{\link[=synDelete]{synDelete}} or \code{\link[=synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}}.}
\item{version_number}{(Optional[int]) (Read Only) The version number issued to this version on the object. Use this \code{\link[=synSnapshot]{synSnapshot}()} function to create a new version of the table.}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{columns}{(Optional[Union[list[Column], OrderedDict[str, Column], dict[str, Column]]]) The columns of this table. This is an ordered named list where the key is the name of the column and the value is the Column object. When creating a new instance of a Table object you may pass any of the following types as the \code{columns} argument:\cr
\cr
- A list of Column objects\cr
- A named list where the key is the name of the column and the value is the Column object\cr
\cr
The order of the columns will be the order they are stored in Synapse. If you need to reorder the columns the recommended approach is to use the \code{\link[=synReorderColumn]{synReorderColumn}()} function. Additionally, you may add, and delete columns using the \code{\link[=synAddColumn]{synAddColumn}()}, and \code{\link[=synDeleteColumn]{synDeleteColumn}()} functions on your Table instance.\cr
\cr
You may modify the attributes of the Column object to change the column type, name, or other attributes. For example suppose I'd like to change a column from a INTEGER to a DOUBLE. I can do so by changing the column type attribute of the Column object. The next time you store the table the column will be updated in Synapse with the new type.\cr
\cr
\preformatted{
library(synapser)
synLogin()

table = Table(id = "syn1234") |> synGet()
table$columns[["my_column"]]$column_type = "DOUBLE"
table = table |> synStore()
}\cr
\cr
Note that the keys in this named list should match the column names as they are in Synapse. However, know that the name attribute of the Column object is used for all interactions with the Synapse API. The named list key is purely for the usage of this interface. For example, if you wish to rename a column you may do so by changing the name attribute of the Column object. The key in the named list does not need to be changed. The next time you store the table the column will be updated in Synapse with the new name and the key in the named list will be updated.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this table was created.}
\item{created_by}{(Optional[str]) The ID of the user that created this table.}
\item{modified_on}{(Optional[str]) The date this table was last modified. In YYYY-MM-DD-Thh:mm:ss.sssZ format}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this table.}
\item{version_label}{(Optional[str]) (Read Only) The version label for this table. Use the \code{\link[=synSnapshot]{synSnapshot}()} function to create a new version of the table.}
\item{version_comment}{(Optional[str]) (Read Only) The version comment for this table. Use the \code{\link[=synSnapshot]{synSnapshot}()} function to create a new version of the table.}
\item{is_latest_version}{(Optional[bool]) (Read Only) If this is the latest version of the object.}
\item{is_search_enabled}{(Optional[bool]) When creating or updating a table or view specifies if full text search should be enabled. Note that enabling full text search might slow down the indexing of the table or view.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the table. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty named list \code{list()} or NULL and store the entity.}
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
    # infer_dtype (https://pandas.pydata.org/docs/reference/api/pandas.api.types.infer_dtype.html).
    # If you need a more specific column type, or need to add options to the columns
    # follow the examples below.
    library(synapser)
    synLogin()

    my_data = data.frame(
        my_string_column = c("a", "b", "c", "d"),
        my_integer_column = c(1, 2, 3, 4),
        my_double_column = c(1.0, 2.0, 3.0, 4.0),
        my_boolean_column = c(TRUE, FALSE, TRUE, FALSE)
    )

    table = Table(
        name = "my_table",
        parent_id = "syn1234"
    ) |> synStore()

    table |> synStoreRows(values = my_data, schema_storage_strategy = "INFER_FROM_DATA")

    # Prints out the stored data about this specific column
    table$columns[["my_string_column"]]

## Example 2: Rename an existing column
    # This examples shows how you may retrieve a table from synapse, rename a column,
    # and then store the table back in synapse.
    library(synapser)
    synLogin()

    table = Table(
        name = "my_table",
        parent_id = "syn1234"
    ) |> synGet()

    # You may also get the table by id:
    table = Table(id = "syn4567") |> synGet()

    table$columns[["my_old_column"]]$name = "my_new_column"

    # Before the data is stored in synapse you'll still be able to use the old key to access the column entry
    table$columns[["my_old_column"]]

    table = table |> synStore()

    # After the data is stored in synapse you'll be able to use the new key to access the column entry
    table$columns[["my_new_column"]]

## Example 3: Create a table with a list of columns
    # A list of columns may be passed in when creating a new table. The order of the
    # columns in the list will be the order they are stored in Synapse. If the table
    # already exists and you create the Table instance in this way the columns will
    # be appended to the end of the existing columns.
    library(synapser)
    synLogin()

    columns = list(
        Column(name = "my_string_column", column_type = "STRING"),
        Column(name = "my_integer_column", column_type = "INTEGER"),
        Column(name = "my_double_column", column_type = "DOUBLE"),
        Column(name = "my_boolean_column", column_type = "BOOLEAN")
    )

    table = Table(
        name = "my_table",
        parent_id = "syn1234",
        columns = columns
    )

    table |> synStore()

## Example 4: Creating a table with a named list of columns
    # When specifying a number of columns via a named list setting the name attribute
    # on the Column object is optional. When it is not specified it will be
    # pulled from the key of the named list.
    library(synapser)
    synLogin()

    columns = list(
        my_string_column = Column(column_type = "STRING"),
        my_integer_column = Column(column_type = "INTEGER"),
        my_double_column = Column(column_type = "DOUBLE"),
        my_boolean_column = Column(column_type = "BOOLEAN")
    )

    table = Table(
        name = "my_table",
        parent_id = "syn1234",
        columns = columns
    )

    table |> synStore()
}
}
\section{Methods}{
\itemize{
\item \code{Table(id=NULL, name=NULL, parent_id=NULL, activity=NULL, version_number=NULL, description=NULL, columns=list(), etag=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, version_label=NULL, version_comment=NULL, is_latest_version=NULL, is_search_enabled=NULL, annotations=list())}: Constructor for \code{\link{Table}}
\item \code{\link[=Table_synAddColumn]{synAddColumn}(instance, column, index=NULL)}: Add column(s) to the table. Note that this does not store the column(s) in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Table instance to
store the column(s) in Synapse. This is a convenience function to eliminate
the need to manually add the column(s) to the \code{$columns} list.
\cr
\cr
This function will add an item to the \code{$columns} attribute of the Table
instance. \code{$columns} is a named list where the key is the name of the column
and the value is the Column object.
\item \code{\link[=Table_synBindSchema]{synBindSchema}(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{\link[=Table_synDeleteColumn]{synDeleteColumn}(instance, name)}: Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Table instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the named list and add it to the
\code{$_columns_to_delete} attribute.
\item \code{\link[=Table_synDeletePermissions]{synDeletePermissions}(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire \strong{local} Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.
\cr
\cr
In order to remove permissions for a specific user or group, you
should use the \code{\link[=Table_synSetPermissions]{synSetPermissions}()} function with the \code{access_type} set to
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
\item \code{\link[=Table_synDeleteRows]{synDeleteRows}(instance, query=NULL, df=NULL, job_timeout=600L, synapse_client=NULL)}: Delete rows from a table given a query or a data frame to select rows.
The query at a minimum must select the \code{ROW_ID} and \code{ROW_VERSION} columns. If you want to
inspect the data that will be deleted ahead of time you may use the
\code{\link[=Table_synQuery]{synQuery}()} function to get the data.
The data frame must at least contain the \code{ROW_ID} and \code{ROW_VERSION} columns. And \code{ROW_ETAG} column is also required
if the entity is one of the following: \code{EntityView}, \code{Dataset}, \code{DatasetCollection}, or \code{SubmissionView}.
If both query and df are provided, the query will be used.
\item \code{\link[=Table_synGetAcl]{synGetAcl}(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}
that a user or group has on an Entity.
\item \code{\link[=Table_synGetPermissions]{synGetPermissions}(instance, synapse_client=NULL)}: Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
\item \code{\link[=Table_synGetSchema]{synGetSchema}(instance, synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{\link[=Table_synGetSchemaDerivedKeys]{synGetSchemaDerivedKeys}(instance, synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{\link[=Table_synListAcl]{synListAcl}(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.
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
\item \code{\link[=Table_synQuery]{synQuery}(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. The results will always be
returned as a data frame unless you specify a \code{download_location} in which
case the results will be downloaded to that location. There are a number of
arguments that you may pass to this function depending on if you are getting
the results back as a DataFrame or downloading the results to a file.
\item \code{\link[=Table_synQueryPartMask]{synQueryPartMask}(query, part_mask, timeout=250L, synapse_client=NULL)}: Query for data on a table stored in Synapse. This is a more advanced use case
of the \code{\link[=Table_synQuery]{synQuery}()} function that allows you to determine what additional metadata
about the table or query should also be returned. If you do not need this
additional information then you are better off using the \code{\link[=Table_synQuery]{synQuery}()} function.
\cr
\cr
The query for this method uses this Rest API:\cr
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
\item \code{\link[=Table_synReorderColumn]{synReorderColumn}(instance, name, index)}: Reorder a column in the table. Note that this does not store the column in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Table instance to
store the column in Synapse. This is a convenience function to eliminate
the need to manually reorder the named list stored in the \code{$columns} attribute.
\cr
\cr
You must ensure that the index is within the bounds of the number of columns in
the table. If you pass in an index that is out of bounds the column will be
added to the end of the list.
\item \code{\link[=Table_synSetPermissions]{synSetPermissions}(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{\link[=Table_synSnapshot]{synSnapshot}(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, synapse_client=NULL)}: Request to create a new snapshot of a table. The provided comment, label, and
activity will be applied to the current version thereby creating a snapshot
and locking the current version. After the snapshot is created a new version
will be started with an 'in-progress' label.
\item \code{\link[=Table_synStoreRows]{synStoreRows}(instance, values, schema_storage_strategy=NULL, column_expansion_strategy=NULL, dry_run=FALSE, additional_changes=NULL, insert_size_bytes=943718400L, csv_table_descriptor=NULL, read_csv_kwargs=NULL, to_csv_kwargs=NULL, job_timeout=600L, synapse_client=NULL)}: Add or update rows in Synapse from the sources defined below. In most cases the
result of this function call will append rows to the table. In the case of an
update this method works on a full row replacement. What this means is
that you may not do a partial update of a row. If you want to update a row
you must pass in all the data for that row, or the data for the columns not
provided will be set to null.

If you'd like to update a row see the example \code{Updating rows in a table} below.

If you'd like to perform an \code{upsert} or partial update of a row you may use
the \code{\link[=Table_synUpsertRows]{synUpsertRows}()} function. See that function for more information.


Note the following behavior for the order of columns:

- If a column is added via the \code{\link[=Table_synAddColumn]{synAddColumn}()} function it will be added at the
    index you specify, or at the end of the columns list.\cr
- If column(s) are added during the construction of your \code{Table} instance, ie.
    \code{Table(columns = list(Column(name = "foo")))}, they will be added at the beginning
    of the columns list.\cr
- If you use the \code{\link[=Table_synStoreRows]{synStoreRows}()} function and the \code{schema_storage_strategy} is set to
    \code{INFER_FROM_DATA} the columns will be added at the end of the columns list.


\strong{Limitations:}

- Synapse limits the number of rows that may be stored in a single request to
    a CSV file that is 1GB. If you are storing a CSV file that is larger than
    this limit the data will be chunked into smaller requests. This process is
    done by reading the file once to determine what the row and byte boundries
    are and calculating the MD5 hash of that portion, then reading the file
    again to send the data to Synapse. This process is done to ensure that the
    data is not corrupted during the upload process, in addition Synapse
    requires the MD5 hash of the data to be sent in the request along with the
    number of bytes that are being sent.\cr
- The limit of 1GB is also enforced when storing a named list or a DataFrame.
    The data will be converted to a CSV format using the \code{to_csv()} pandas
    function. If you are storing more than a 1GB file it is recommended that
    you store the data as a CSV and use the file path to upload the data. This
    is due to the fact that the DataFrame chunking process is slower than
    reading portions of a file on disk and calculating the MD5 hash of that
    portion.

The following is a Sequence Diagram that describes the process noted in the
limitation above. It shows how the data is chunked into smaller requests when
the data exceeds the limit of 1GB, and how portions of the data are read from
the CSV file on disk while being uploaded to Synapse.

\preformatted{
sequenceDiagram
    participant User
    participant Table
    participant FileSystem
    participant Synapse

    User->>Table: store_rows(values)

    alt CSV size > 1GB
        Table->>Synapse: Apply schema changes before uploading
        note over Table, FileSystem: Read CSV twice
        Table->>FileSystem: Read entire CSV (First Pass)
        FileSystem-->>Table: Compute chunk sizes & MD5 hashes

        loop Read and Upload CSV chunks (Second Pass)
            Table->>FileSystem: Read next chunk from CSV
            FileSystem-->>Table: Return bytes
            Table->>Synapse: Upload CSV chunk
            Synapse-->>Table: Return file_handle_id
            Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows
            Synapse-->>Table: Transaction result
        end
    else
        Table->>Synapse: Upload CSV without splitting & Any additional schema changes
        Synapse-->>Table: Return file_handle_id
        Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows
        Synapse-->>Table: Transaction result
    end

    Table-->>User: Upload complete
}

The following is a Sequence Diagram that describes the process noted in the
limitation above for DataFrames. It shows how the data is chunked into smaller
requests when the data exceeds the limit of 1GB, and how portions of the data
are read from the DataFrame while being uploaded to Synapse.

\preformatted{
sequenceDiagram
    participant User
    participant Table
    participant MemoryBuffer
    participant Synapse

    User->>Table: store_rows(DataFrame)

    loop For all rows in DataFrame in 100 row increments
        Table->>MemoryBuffer: Convert DataFrame rows to CSV in-memory
        MemoryBuffer-->>Table: Compute chunk sizes & MD5 hashes
    end


    alt Multiple chunks detected
        Table->>Synapse: Apply schema changes before uploading
    end

    loop For all chunks found in first loop
        loop for all parts in chunk byte boundry
            Table->>MemoryBuffer: Read small (< 8MB) part of the chunk
            MemoryBuffer-->>Table: Return bytes (with correct offset)
            Table->>Synapse: Upload part
            Synapse-->>Table: Upload response
        end
        Table->>Synapse: Complete upload
        Synapse-->>Table: Return file_handle_id
        Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows
        Synapse-->>Table: Transaction result
    end

    Table-->>User: Upload complete
}
\item \code{\link[=Table_synUnbindSchema]{synUnbindSchema}(instance, synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{\link[=Table_synUpsertRows]{synUpsertRows}(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, synapse_client=NULL)}: This method allows you to perform an \code{upsert} (Update and Insert) for row(s).
This means that you may update a row with only the data that you want to change.
When supplied with a row that does not match the given \code{primary_keys} a new
row will be inserted.


Using the \code{primary_keys} argument you may specify which columns to use to
determine if a row already exists. If a row exists with the same values in the
columns specified in this list the row will be updated. If a row does not exist
it will be inserted.


Limitations:

- The request to update, and the request to insert data does not occur in a
    single transaction. This means that the update of data may succeed, but the
    insert of data may fail. Additionally, as noted in the limitation below, if
    data is chunked up into multiple requests you may find that a portion of
    your data is updated, but another portion is not.\cr
- The number of rows that may be upserted in a single call should be
    kept to a minimum (< 50,000). There is significant overhead in the request
    to Synapse for each row that is upserted. If you are upserting a large
    number of rows a better approach may be to query for the data you want
    to update, update the data, then use the \code{\link[=Table_synStoreRows]{synStoreRows}()} function to
    update the data in Synapse. Any rows you want to insert may be added
    to the data frame that is passed to the \code{\link[=Table_synStoreRows]{synStoreRows}()} function.\cr
- When upserting many rows the requests to Synapse will be chunked into smaller
    requests. The limit is 2MB per request. This chunking will happen
    automatically and should not be a concern for most users. If you are
    having issues with the request being too large you may lower the
    number of rows you are trying to upsert, or note the above limitation.\cr
- The \code{primary_keys} argument must contain at least one column.\cr
- The \code{primary_keys} argument cannot contain columns that are a LIST type.\cr
- The \code{primary_keys} argument cannot contain columns that are a JSON type.\cr
- The \code{primary_keys} columns must be present in the data being upserted. An
    error is raised if a primary key column is missing.\cr
- The values in the \code{primary_keys} columns cannot be null. A null value
    cannot be used to match an existing row, so an error is raised if any row
    has a null value in a primary key column.\cr
- The values used as the \code{primary_keys} must be unique in the table. If there
    are multiple rows with the same values in the \code{primary_keys} the behavior
    is that an exception will be raised.\cr
- The columns used in \code{primary_keys} cannot contain updated values. Since
    the values in these columns are used to determine if a row exists, they
    cannot be updated in the same transaction.

The following is a Sequence Diagram that describes the upsert process at a
high level:

\preformatted{
sequenceDiagram
    participant User
    participant Table
    participant Synapse

    User->>Table: upsert_rows()

    loop Query and Process Updates in Chunks (rows_per_query)
        Table->>Synapse: Query existing rows using primary keys
        Synapse-->>Table: Return matching rows
        Note Over Table: Create partial row updates

        loop For results from query
            Note Over Table: Sum row/chunk size
            alt Chunk size exceeds update_size_bytes
                Table->>Synapse: Push update chunk
                Synapse-->>Table: Acknowledge update
            end
            Table->>Table: Add row to chunk
        end

        alt Remaining updates exist
            Table->>Synapse: Push final update chunk
            Synapse-->>Table: Acknowledge update
        end
    end

    alt New rows exist
        Table->>Table: Identify new rows for insertion
        Table->>Table: Call synStoreRows() function
    end

    Table-->>User: Upsert complete
}
\item \code{\link[=Table_synValidateSchema]{synValidateSchema}(instance, synapse_client=NULL)}: Validate the entity against the bound JSON schema.
}
}

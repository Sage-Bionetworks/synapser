%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStoreRows}
\alias{Table_synStoreRows}
\docType{methods}
\title{
Table :  store_rows
}
\description{
Add or update rows in Synapse from the sources defined below. In most cases the
result of this function call will append rows to the table. In the case of an
update this method works on a full row replacement. What this means is
that you may not do a partial update of a row. If you want to update a row
you must pass in all the data for that row, or the data for the columns not
provided will be set to null.

If you'd like to update a row see the example \code{Updating rows in a table} below.

If you'd like to perform an \code{upsert} or partial update of a row you may use
the \code{.upsert_rows()} method. See that method for more information.


Note the following behavior for the order of columns:

- If a column is added via the \code{add_column} method it will be added at the
    index you specify, or at the end of the columns list.
- If column(s) are added during the contruction of your \code{Table} instance, ie.
    \code{Table(columns=[Column(name="foo")])}, they will be added at the begining
    of the columns list.
- If you use the \code{store_rows} method and the \code{schema_storage_strategy} is set to
    \code{INFER_FROM_DATA} the columns will be added at the end of the columns list.


**How datetime values are interpreted:**

Synapse \code{DATE} columns store an exact moment in time, represented as the
number of milliseconds since \code{1970-01-01 00:00:00} UTC. Before upload,
datetime values are converted to that representation as follows:

- Timezone-aware datetimes (e.g. localized with \code{zoneinfo.ZoneInfo} or
    \code{pandas.Series.dt.tz_localize}) are converted to UTC exactly. This is
    the recommended way to pass datetime data: the stored value does not
    depend on the timezone settings of the machine performing the upload
    or on the date the upload is run.
- Naive datetimes (no \code{tzinfo}) are assumed to be in the local timezone
    of the machine **at the time of upload**. That single UTC offset is
    applied to every value, including values whose dates fall in a
    different daylight saving period, which will be stored shifted by one
    hour. For example, uploading \code{2017-02-14 11:23} (a PST date, UTC-8)
    from a machine currently on PDT (UTC-7) stores \code{2017-02-14 18:23} UTC
    instead of the correct \code{19:23} UTC. To avoid this, localize your data
    first, e.g. \code{df["col"] = df["col"].dt.tz_localize("America/Los_Angeles")}.
- Plain \code{datetime.date} objects (as opposed to datetimes) are treated
    as midnight of that date and converted the same way naive
    datetimes are: using the local timezone of the machine **at the
    time of upload**, with the same daylight-saving-shift risk
    described above.
- Midnight values deserve extra care: the one-hour daylight saving
    shift described above can move a naive midnight datetime — or a
    \code{datetime.date}, which is treated as midnight — to 11 PM of the
    previous day, changing the calendar date the value displays as.

**Why timezone-aware values are recommended:**

A naive datetime such as \code{2017-02-14 11:23} is only "what a clock on the
wall said." Before it can be stored as an exact moment in time, something
has to answer: *a clock where?* Timezone-aware values answer that
question in the data itself; naive values leave the client to guess, and
it guesses the uploading machine's current timezone.

A zone name like \code{"America/Los_Angeles"} does not mean a fixed offset
such as UTC-8. It means "a Los Angeles wall clock" — and those clocks
move twice a year: UTC-7 in summer (PDT), UTC-8 in winter (PST). When
pandas localizes a column with
\code{df["col"].dt.tz_localize("America/Los_Angeles")}, it looks up what LA
clocks were set to on each value's own date:

- \code{2017-02-14} → winter → interpreted using UTC-8
- \code{2018-10-01} → summer → interpreted using UTC-7

When the data is queried back with \code{query(..., convert_to_datetime=True)},
\code{DATE} columns are returned as timezone-aware datetimes in UTC. Use
\code{Series.dt.tz_convert} to view them in another timezone.

**Limitations:**

- Synapse limits the number of rows that may be stored in a single request to
    a CSV file that is 1GB. If you are storing a CSV file that is larger than
    this limit the data will be chunked into smaller requests. This process is
    done by reading the file once to determine what the row and byte boundries
    are and calculating the MD5 hash of that portion, then reading the file
    again to send the data to Synapse. This process is done to ensure that the
    data is not corrupted during the upload process, in addition Synapse
    requires the MD5 hash of the data to be sent in the request along with the
    number of bytes that are being sent.
- The limit of 1GB is also enforced when storing a dictionary or a DataFrame.
    The data will be converted to a CSV format using the \code{.to_csv()} pandas
    function. If you are storing more than a 1GB file it is recommended that
    you store the data as a CSV and use the file path to upload the data. This
    is due to the fact that the DataFrame chunking process is slower than
    reading portions of a file on disk and calculating the MD5 hash of that
    portion.

The following is a Sequence Daigram that describes the process noted in the
limitation above. It shows how the data is chunked into smaller requests when
the data exceeds the limit of 1GB, and how portions of the data are read from
the CSV file on disk while being uploaded to Synapse.

``\code{mermaid
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
            Synapse-->>Table: Return }file_handle_id\code{
            Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows
            Synapse-->>Table: Transaction result
        end
    else
        Table->>Synapse: Upload CSV without splitting & Any additional schema changes
        Synapse-->>Table: Return }file_handle_id\code{
        Table->>Synapse: Send }TableUpdateTransaction' to append/update rows
        Synapse-->>Table: Transaction result
    end

    Table-->>User: Upload complete
``\code{

The following is a Sequence Daigram that describes the process noted in the
limitation above for DataFrames. It shows how the data is chunked into smaller
requests when the data exceeds the limit of 1GB, and how portions of the data
are read from the DataFrame while being uploaded to Synapse.

}`\code{mermaid
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
        Synapse-->>Table: Return }file_handle_id\code{
        Table->>Synapse: Send 'TableUpdateTransaction' to append/update rows
        Synapse-->>Table: Transaction result
    end

    Table-->>User: Upload complete
}``
}
\usage{
synStoreRows(instance, values, schema_storage_strategy=NULL, column_expansion_strategy=NULL, dry_run=FALSE, additional_changes=NULL, insert_size_bytes=943718400L, csv_table_descriptor=NULL, date_columns=NULL, date_format=NULL, read_csv_kwargs=NULL, to_csv_kwargs=NULL, job_timeout=600L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{values}{(Union[str, dict[str, Any], object]) Supports storing data from the following sources:\cr
\cr
- A string holding the path to a CSV file. If the \code{schema_storage_strategy} is set to \code{None} the data will be uploaded as is. If \code{schema_storage_strategy} is set to \code{INFER_FROM_DATA} the data will be read into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. The code makes assumptions about the format of the columns in the CSV as detailed in the [csv_to_pandas_df][synapseclient.models.mixins.table_components.csv_to_pandas_df] function. You may pass in additional arguments to the \code{csv_to_pandas_df} function by passing them in as keyword arguments to this function. - A dictionary where the key is the column name and the value is one or more values. The values will be wrapped into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. You may pass in additional arguments to the \code{pd.DataFrame} function by passing them in as keyword arguments to this function. Read about the available arguments in the \href{https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html}{Pandas DataFrame} documentation. - A \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}}
\item{schema_storage_strategy}{(SchemaStorageStrategy) Determines how to automate the creation of columns based on the data that is being stored. If you want to have full control over the schema you may set this to \code{None} and create the columns manually.\cr
\cr
The limitation with this behavior is that the columns created may only be of the following types:\cr
\cr
- STRING - LARGETEXT - INTEGER - DOUBLE - BOOLEAN - DATE\cr
\cr
The determination is based on how this pandas function infers the data type: \href{https://pandas.pydata.org/docs/reference/api/pandas.api.types.infer_dtype.html}{infer_dtype}\cr
\cr
This may also only set the \code{name}, \code{column_type}, and \code{maximum_size} of the column when the column is created. If this is used to update the column the \code{maxium_size} will only be updated depending on the value of \code{column_expansion_strategy}. The other attributes of the column will be set to the default values on create, or remain the same if the column already exists.\cr
\cr
\cr
The usage of this feature will never delete a column, shrink a column, or change the type of a column that already exists. If you need to change any of these attributes you must do so after getting the table via a \code{.get()} call, updating the columns as needed, then calling \code{.store()} on the table.}
\item{column_expansion_strategy}{(ColumnExpansionStrategy) Determines how to automate the expansion of columns based on the data that is being stored. The options given allow cells with a limit on the length of content (Such as strings) to be expanded to a larger size if the data being stored exceeds the limit. If you want to have full control over the schema you may set this to \code{None} and create the columns manually. String type columns are the only ones that support this feature.}
\item{dry_run}{(bool) Log the actions that would be taken, but do not actually perform the actions. This will not print out the data that would be stored or modified as a result of this action. It will print out the actions that would be taken, such as creating a new column, updating a column, or updating table metadata. This is useful for debugging and understanding what actions would be taken without actually performing them.}
\item{additional_changes}{(list[ForwardRef('TableUpdateRequest')]) Additional changes to the table that should execute within the same transaction as appending or updating rows. Each change is a TableUpdateRequest, which is one of TableSchemaChangeRequest, AppendableRowSetRequest, UploadToTableRequest, or TableSearchChangeRequest. This is used as a part of the \code{upsert_rows} method call to allow for the updating of rows and the updating of the table schema in the same transaction. In most cases you will not need to use this argument.}
\item{insert_size_bytes}{(int) The maximum size of data that will be stored to Synapse within a single transaction. The API have a limit of 1GB, but the default is set to 900 MB to allow for some overhead in the request. The implication of this limit is that when you are storing a CSV that is larger than this limit the data will be chunked into smaller requests by reading the file once to determine what the row and byte boundries are and calculating the MD5 hash of that portion, then reading the file again to send the data to Synapse. This process is done to ensure that the data is not corrupted during the upload process, in addition Synapse requires the MD5 hash of the data to be sent in the request along with the number of bytes that are being sent. This argument is also used when storing a dictionary or a DataFrame. The data will be converted to a CSV format using the \code{.to_csv()} pandas function. When storing data as a DataFrame the minimum that it will be chunked to is 100 rows of data, regardless of if the data is larger than the limit.}
\item{csv_table_descriptor}{(Optional[CsvTableDescriptor]) When passing in a CSV file this will allow you to specify the format of the CSV file. This is only used when the \code{values} argument is a string holding the path to a CSV file. See [CsvTableDescriptor][synapseclient.models.CsvTableDescriptor] for more information.}
\item{date_columns}{(Optional[list[str]]) (CSV file only) The names of columns in your CSV file that contain dates or datetimes stored as formatted strings (e.g. \code{"2024-01-15"} or \code{"01/15/2024 13:30"}). The columns are parsed with \code{pandas.to_datetime} and converted to epoch time in milliseconds before the data is uploaded, which is the format Synapse requires for \code{DATE} columns. The conversion is done by reading the CSV file into a pandas DataFrame and uploading a temporary copy with the converted values, which requires the CSV file to contain a header row. When \code{schema_storage_strategy} is set to \code{INFER_FROM_DATA} the parsed columns will be inferred as \code{DATE} columns. The parsed values are naive datetimes unless the strings carry a UTC offset — see *How datetime values are interpreted* above for how they are converted to epoch time. When the offsets in a column differ between rows (e.g. a mix of \code{-0800} and \code{-0700} values) the values are normalized to UTC, preserving the exact moments in time.}
\item{date_format}{(Optional[Union[str, dict[str, str]]]) (CSV file only) How the strings in \code{date_columns} are formatted — a \href{https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes}{strftime format string} (e.g. \code{"%m/%d/%Y"}) applied to every column, or a dict mapping column names to their formats. Supply this so that ambiguous dates (e.g. \code{"01/02/2024"}) are not silently misinterpreted and to optimize the data upload performance. If the values in a column do not match the format a \code{ValueError} is raised.}
\item{read_csv_kwargs}{(Optional[dict[str, Any]]) Additional arguments to pass to the \code{pd.read_csv} function when reading in a CSV file. This is only used when the \code{values} argument is a string holding the path to a CSV file and either \code{schema_storage_strategy} is set to \code{INFER_FROM_DATA} or \code{date_columns} is provided. See <https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html> for complete list of supported arguments.}
\item{to_csv_kwargs}{(Optional[dict[str, Any]]) Additional arguments to pass to the \code{pd.DataFrame.to_csv} function when writing the data to a CSV file. This is only used when the \code{values} argument is a Pandas DataFrame. See <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_csv.html> for complete list of supported arguments. Any kwargs you supply are merged on top of the default \code{{"escapechar": "\"}}, so you only need to override \code{escapechar} explicitly if you want different behavior.}
\item{job_timeout}{(int) The maximum amount of time to wait for a job to complete. This is used when inserting, and updating rows of data. Each individual request to Synapse will be sent as an independent job. If the timeout is reached a \code{SynapseTimeoutError} will be raised. The default is 600 seconds}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None
}
\examples{
\dontrun{
## Example 1: Inserting rows into a table that already has columns
    # This example shows how you may insert rows into a table.

    # Suppose we have a table with the following columns:

    # | col1 | col2 | col3 |
    # |------|------| -----|

    # The following code will insert rows into the table:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        data_to_insert = {
            'col1': ['A', 'B', 'C'],
            'col2': [1, 2, 3],
            'col3': [1, 2, 3],
        }

        await Table(id="syn1234").store_rows_async(values=data_to_insert)

    asyncio.run(main())

    The resulting table will look like this:

    | col1 | col2 | col3 |
    |------|------| -----|
    | A    | 1    | 1    |
    | B    | 2    | 2    |
    | C    | 3    | 3    |

## Example 2: Inserting rows into a table that does not have columns
    # This example shows how you may insert rows into a table that does not have
    # columns. The columns will be inferred from the data that is being stored.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table, SchemaStorageStrategy # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        data_to_insert = {
            'col1': ['A', 'B', 'C'],
            'col2': [1, 2, 3],
            'col3': [1, 2, 3],
        }

        await Table(id="syn1234").store_rows_async(
            values=data_to_insert,
            schema_storage_strategy=SchemaStorageStrategy.INFER_FROM_DATA
        )

    asyncio.run(main())

    The resulting table will look like this:

    | col1 | col2 | col3 |
    |------|------| -----|
    | A    | 1    | 1    |
    | B    | 2    | 2    |
    | C    | 3    | 3    |

## Example 3: Using the dry_run option with a SchemaStorageStrategy of INFER_FROM_DATA
    # This example shows how you may use the \code{dry_run} option with the
    # \code{SchemaStorageStrategy} set to \code{INFER_FROM_DATA}. This will show you the
    # actions that would be taken, but not actually perform the actions.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table, SchemaStorageStrategy # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        data_to_insert = {
            'col1': ['A', 'B', 'C'],
            'col2': [1, 2, 3],
            'col3': [1, 2, 3],
        }

        await Table(id="syn1234").store_rows_async(
            values=data_to_insert,
            dry_run=True,
            schema_storage_strategy=SchemaStorageStrategy.INFER_FROM_DATA
        )

    asyncio.run(main())

    The result of running this action will print to the console the actions that
    would be taken, but not actually perform the actions.

## Example 4: Updating rows in a table
    # This example shows how you may query for data in a table, update the data,
    # and then store the updated rows back in Synapse.

    # Suppose we have a table that has the following data:


    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 1    | 1    |
    # | B    | 2    | 2    |
    # | C    | 3    | 3    |

    # Behind the scenese the tables also has \code{ROW_ID} and \code{ROW_VERSION} columns
    # which are used to identify the row that is being updated. These columns
    # are not shown in the table above, but is included in the data that is
    # returned when querying the table. If you add data that does not have these
    # columns the data will be treated as new rows to be inserted.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table, query_async # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        query_results = await query_async(query="select * from syn1234 where col1 in ('A', 'B')")

        # Update \code{col2} of the row where \code{col1} is \code{A} to \code{22}
        query_results.loc[query_results['col1'] == 'A', 'col2'] = 22

        # Update \code{col3} of the row where \code{col1} is \code{B} to \code{33}
        query_results.loc[query_results['col1'] == 'B', 'col3'] = 33

        await Table(id="syn1234").store_rows_async(values=query_results)

    asyncio.run(main())

    The resulting table will look like this:

    | col1 | col2 | col3 |
    |------|------| -----|
    | A    | 22   | 1    |
    | B    | 2    | 33   |
    | C    | 3    | 3    |

## Example 5: Inserting rows from a CSV file that contains date columns

    # This example shows how you may insert rows from a CSV file that contains
    # date columns. The date columns are converted
    # to epoch time in milliseconds before the data is uploaded so that Synapse
    # can store them in \code{DATE} columns.

    # Suppose we have a CSV file with the following data:

    # | col1 | date_col1  | date_col2  |
    # |------|------------|------------|
    # | A    | 01/15/2024 | 2024-01-20 |
    # | B    | 02/20/2024 | 2024-02-25 |

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table, SchemaStorageStrategy

    syn = Synapse()
    syn.login()

    async def main():
        await Table(id="syn1234").store_rows_async(
            values="path/to/file.csv",
            schema_storage_strategy=SchemaStorageStrategy.INFER_FROM_DATA,
            date_columns=["date_col1", "date_col2"],
            date_format={"date_col1": "\%m/\%d/\%Y", "date_col2": "\%Y-\%m-\%d"},
        )

    asyncio.run(main())
}
}
\keyword{Table}

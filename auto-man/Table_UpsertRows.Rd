%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpsertRows}
\alias{synUpsertRows}
\docType{methods}
\title{
Table :  upsert_rows
}
\description{
This method allows you to perform an \code{upsert} (Update and Insert) for row(s).
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
    your data is updated, but another portion is not.
- The number of rows that may be upserted in a single call should be
    kept to a minimum (< 50,000). There is significant overhead in the request
    to Synapse for each row that is upserted. If you are upserting a large
    number of rows a better approach may be to query for the data you want
    to update, update the data, then use the [store_rows_async][synapseclient.models.mixins.table_components.TableStoreRowMixin.store_rows_async] method to
    update the data in Synapse. Any rows you want to insert may be added
    to the DataFrame that is passed to the [store_rows_async][synapseclient.models.mixins.table_components.TableStoreRowMixin.store_rows_async] method.
- When upserting mnay rows the requests to Synapse will be chunked into smaller
    requests. The limit is 2MB per request. This chunking will happen
    automatically and should not be a concern for most users. If you are
    having issues with the request being too large you may lower the
    number of rows you are trying to upsert, or note the above limitation.
- The \code{primary_keys} argument must contain at least one column.
- The \code{primary_keys} argument cannot contain columns that are a LIST type.
- The \code{primary_keys} argument cannot contain columns that are a JSON type.
- The values used as the \code{primary_keys} must be unique in the table. If there
    are multiple rows with the same values in the \code{primary_keys} the behavior
    is that an exception will be raised.
- The columns used in \code{primary_keys} cannot contain updated values. Since
    the values in these columns are used to determine if a row exists, they
    cannot be updated in the same transaction.

The following is a Sequence Diagram that describces the upsert process at a
high level:

``\code{mermaid
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
        Table->>Table: Call }store_rows()\code{ function
    end

    Table-->>User: Upsert complete
}``
}
\usage{
synUpsertRows(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{values}{(Union[str, dict[str, Any], object]) Supports storing data from the following sources:\cr
\cr
- A string holding the path to a CSV file. The data will be read into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. The code makes assumptions about the format of the columns in the CSV as detailed in the [csv_to_pandas_df][synapseclient.models.mixins.table_components.csv_to_pandas_df] function. You may pass in additional arguments to the \code{csv_to_pandas_df} function by passing them in as keyword arguments to this function. - A dictionary where the key is the column name and the value is one or more values. The values will be wrapped into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. You may pass in additional arguments to the \code{pd.DataFrame} function by passing them in as keyword arguments to this function. Read about the available arguments in the \href{https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html}{Pandas DataFrame} documentation. - A \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}}
\item{primary_keys}{(list[str]) The columns to use to determine if a row already exists. If a row exists with the same values in the columns specified in this list the row will be updated. If a row does not exist it will be inserted.}
\item{dry_run}{(bool) If set to True the data will not be updated in Synapse. A message will be printed to the console with the number of rows that would have been updated and inserted. If you would like to see the data that would be updated and inserted you may set the \code{dry_run} argument to True and set the log level to DEBUG by setting the debug flag when creating your Synapse class instance like: \code{syn = Synapse(debug=True)}.}
\item{rows_per_query}{(int) The number of rows that will be queries from Synapse per request. Since we need to query for the data that is being updated this will determine the number of rows that are queried at a time. The default is 50,000 rows.}
\item{update_size_bytes}{(int) The maximum size of the request that will be sent to Synapse when updating rows of data. The default is 1.9MB.}
\item{insert_size_bytes}{(int) The maximum size of the request that will be sent to Synapse when inserting rows of data. The default is 900MB.}
\item{job_timeout}{(int) The maximum amount of time to wait for a job to complete. This is used when inserting, and updating rows of data. Each individual request to Synapse will be sent as an independent job. If the timeout is reached a \code{SynapseTimeoutError} will be raised. The default is 600 seconds}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor\cr
\cr
**kwargs: Additional arguments that are passed to the \code{pd.DataFrame} function when the \code{values} argument is a path to a csv file.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Updating 2 rows and inserting 1 row
    # In this given example we have a table with the following data:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 1    | 1    |
    # | B    | 2    | 2    |

    # The following code will update the first row's \code{col2} to \code{22}, update the
    # second row's \code{col3} to \code{33}, and insert a new row:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}
    import pandas as pd

    syn = Synapse()
    syn.login()


    async def main():
        table = await Table(id="syn123").get_async(include_columns=True)

        df = pd.DataFrame({
            'col1': ['A', 'B', 'C'],
            'col2': [22, 2, 3],
            'col3': [1, 33, 3],
        })

        await table.upsert_rows_async(values=df, primary_keys=["col1"])

    asyncio.run(main())

    The resulting table will look like this:

    | col1 | col2 | col3 |
    |------|------| -----|
    | A    | 22   | 1    |
    | B    | 2    | 33   |
    | C    | 3    | 3    |

## Example 2: Deleting data from a specific cell
    # In this given example we have a table with the following data:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 1    | 1    |
    # | B    | 2    | 2    |

    # The following code will update the first row's \code{col2} to \code{22}, update the
    # second row's \code{col3} to \code{33}, and insert a new row:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()


    async def main():
        table = await Table(id="syn123").get_async(include_columns=True)

        dictionary_of_data = {
            'col1': ['A', 'B'],
            'col2': [None, 2],
            'col3': [1, None],
        }

        await table.upsert_rows_async(values=dictionary_of_data, primary_keys=["col1"])

    asyncio.run(main())


    The resulting table will look like this:

    | col1 | col2 | col3 |
    |------|------| -----|
    | A    |      | 1    |
    | B    | 2    |      |
}
}
\keyword{Table}

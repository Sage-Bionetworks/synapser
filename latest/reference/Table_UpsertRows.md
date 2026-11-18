# Table : upsert_rows

This method allows you to perform an `upsert` (Update and Insert) for
row(s). This means that you may update a row with only the data that you
want to change. When supplied with a row that does not match the given
`primary_keys` a new row will be inserted.

Using the `primary_keys` argument you may specify which columns to use
to determine if a row already exists. If a row exists with the same
values in the columns specified in this list the row will be updated. If
a row does not exist it will be inserted.

Limitations:

\- The request to update, and the request to insert data does not occur
in a single transaction. This means that the update of data may succeed,
but the insert of data may fail. Additionally, as noted in the
limitation below, if data is chunked up into multiple requests you may
find that a portion of your data is updated, but another portion is
not.\
\- The number of rows that may be upserted in a single call should be
kept to a minimum (\< 50,000). There is significant overhead in the
request to Synapse for each row that is upserted. If you are upserting a
large number of rows a better approach may be to query for the data you
want to update, update the data, then use the
[`synStoreRows()`](https://r-docs.synapse.org/latest/reference/Table_StoreRows.md)
function to update the data in Synapse. Any rows you want to insert may
be added to the data frame that is passed to the
[`synStoreRows()`](https://r-docs.synapse.org/latest/reference/Table_StoreRows.md)
function.\
\- When upserting many rows the requests to Synapse will be chunked into
smaller requests. The limit is 2MB per request. This chunking will
happen automatically and should not be a concern for most users. If you
are having issues with the request being too large you may lower the
number of rows you are trying to upsert, or note the above limitation.\
\- The `primary_keys` argument must contain at least one column.\
\- The `primary_keys` argument cannot contain columns that are a LIST
type.\
\- The `primary_keys` argument cannot contain columns that are a JSON
type.\
\- The `primary_keys` columns must be present in the data being
upserted. An error is raised if a primary key column is missing.\
\- The values in the `primary_keys` columns cannot be null. A null value
cannot be used to match an existing row, so an error is raised if any
row has a null value in a primary key column.\
\- The values used as the `primary_keys` must be unique in the table. If
there are multiple rows with the same values in the `primary_keys` the
behavior is that an exception will be raised.\
\- The columns used in `primary_keys` cannot contain updated values.
Since the values in these columns are used to determine if a row exists,
they cannot be updated in the same transaction.

The following is a Sequence Diagram that describes the upsert process at
a high level:

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

## Usage

``` r
synUpsertRows(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, date_columns=NULL, date_format=NULL, synapse_client=NULL)
```

## Arguments

- instance:

  (Table) The Table instance to operate on.

- values:

  (Union\[str, dict\[str, Any\], object\]) Supports storing data from
  the following sources:\
  \
  \- A string holding the path to a CSV file. The data will be read into
  a [Pandas
  DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe).
  The code makes assumptions about the format of the columns in the CSV
  as detailed in the
  [csv_to_pandas_df](https://python-docs.synapse.org/en/stable/reference/experimental/sync/table/#csv-to-pandas-df-reference-sync)
  function.\
  \- A named list where the key is the column name and the value is one
  or more values. The values will be wrapped into a [Pandas
  DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe).
  You may pass in additional arguments to the pandas DataFrame
  constructor by passing them in as keyword arguments to this function.
  Read about the available arguments in the [Pandas
  DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html)
  documentation.\
  \- A [Pandas
  DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe)

- primary_keys:

  (list\[str\]) The columns to use to determine if a row already exists.
  If a row exists with the same values in the columns specified in this
  list the row will be updated. If a row does not exist it will be
  inserted.

- dry_run:

  (bool) If set to TRUE the data will not be updated in Synapse. A
  message will be printed to the console with the number of rows that
  would have been updated and inserted. If you would like to see the
  data that would be updated and inserted you may set the `dry_run`
  argument to TRUE.

- rows_per_query:

  (int) The number of rows that will be queried from Synapse per
  request. Since we need to query for the data that is being updated
  this will determine the number of rows that are queried at a time. The
  default is 50,000 rows.

- update_size_bytes:

  (int) The maximum size of the request that will be sent to Synapse
  when updating rows of data. The default is 1.9MB.

- insert_size_bytes:

  (int) The maximum size of the request that will be sent to Synapse
  when inserting rows of data. The default is 900MB.

- job_timeout:

  (int) The maximum amount of time to wait for a job to complete. This
  is used when inserting, and updating rows of data. Each individual
  request to Synapse will be sent as an independent job. If the timeout
  is reached a timeout error will be raised. The default is 600 seconds

- date_columns:

  (Optional\[list\[character\]\]) (CSV file only) The names of columns
  in your CSV file that contain dates or datetimes stored as formatted
  strings (e.g. `"2024-01-15"` or `"01/15/2024 13:30"`). The columns are
  parsed with `pandas.to_datetime` and converted to epoch time in
  milliseconds before the data is uploaded, which is the format Synapse
  requires for `DATE` columns.

- date_format:

  (Optional\[character or named list\]) (CSV file only) How the strings
  in `date_columns` are formatted — a [strftime format
  string](https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes)
  (e.g. `"%m/%d/%Y"`) applied to every column, or a named list mapping
  column names to their formats. Supply this so that ambiguous dates
  (e.g. `"01/02/2024"`) are not silently misinterpreted and to optimize
  the data upload performance. If the values in a column do not match
  the format an error is raised.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Note

When `values` is a path to a CSV file, you may pass additional keyword
arguments to the
[`csv_to_pandas_df`](https://python-docs.synapse.org/en/stable/reference/experimental/sync/table/#csv-to-pandas-df-reference-sync)
function by adding them as extra named arguments to `synUpsertRows()`,
e.g. `separator = ";"` or `lines_to_skip = 1L`.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Updating 2 rows and inserting 1 row
    # In this given example we have a table with the following data:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 1    | 1    |
    # | B    | 2    | 2    |

    # The following code will update the first row's col2 to 22, update the
    # second row's col3 to 33, and insert a new row:
    library(synapser)
    synLogin()

    # Also works with Dataset
    table = Table(id = "syn123") |> synGet(table_options = TableOptions(include_columns = TRUE))

    df = data.frame(
        col1 = c("A", "B", "C"),
        col2 = c(22, 2, 3),
        col3 = c(1, 33, 3)
    )

    table |> synUpsertRows(values = df, primary_keys = list("col1"))

    # The resulting table will look like this:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 22   | 1    |
    # | B    | 2    | 33   |
    # | C    | 3    | 3    |

## Example 2: Deleting data from a specific cell
    # In this given example we have a table with the following data:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    | 1    | 1    |
    # | B    | 2    | 2    |

    # The following code will clear the value in the first row's col2, and the
    # second row's col3:
    library(synapser)
    synLogin()

    # Also works with Dataset
    table = Table(id = "syn123") |> synGet(table_options = TableOptions(include_columns = TRUE))

    data_to_upsert = data.frame(
        col1 = c("A", "B"),
        col2 = c(NA, 2),
        col3 = c(1, NA)
    )

    table |> synUpsertRows(values = data_to_upsert, primary_keys = list("col1"))

    # The resulting table will look like this:

    # | col1 | col2 | col3 |
    # |------|------| -----|
    # | A    |      | 1    |
    # | B    | 2    |      |

## Example 3: Upserting data with date columns
    # In this given example we have a table with the following data:

    # | col1 | date_col   |
    # |------|------------|
    # | A    | 2024-01-15 |
    # | B    | 2024-02-20 |

    # Suppose we have a CSV file with the following data that we want to upsert:

    # | col1 | date_col   |
    # |------|------------|
    # | A    | 03/10/2024 |
    # | C    | 04/01/2024 |

    # The date_columns/date_format arguments tell the client how to parse
    # the formatted date strings in the CSV file so that they can be compared
    # against, and stored in, the table's DATE column. The following code
    # will update row A's date_col and insert a new row for C:
    library(synapser)
    synLogin()

    # Also works with Dataset
    Table(id = "syn123") |> synUpsertRows(
        values = "path/to/file.csv",
        primary_keys = list("col1"),
        date_columns = list("date_col"),
        date_format = "%m/%d/%Y"
    )

    # The resulting table will look like this:

    # | col1 | date_col   |
    # |------|------------|
    # | A    | 2024-03-10 |
    # | B    | 2024-02-20 |
    # | C    | 2024-04-01 |
} # }
```

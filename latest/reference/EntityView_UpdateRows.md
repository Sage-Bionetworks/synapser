# EntityView : update_rows

This method leverages the logic provided by
[`synUpsertRows()`](https://r-docs.synapse.org/latest/reference/Table_UpsertRows.md)
to provide an interface for updating rows in a `View`-like entity.
Update functionality will only work for values in custom columns within
a `View`-like entity.

Limitations:

\- When updating many rows the requests to Synapse will be chunked into
smaller requests. The limit is 2MB per request. This chunking will
happen automatically and should not be a concern for most users. If you
are having issues with the request being too large you may lower the
number of rows you are trying to update.\
\- The `primary_keys` argument must contain at least one column.\
\- The `primary_keys` argument cannot contain columns that are a LIST
type.\
\- The `primary_keys` argument cannot contain columns that are a JSON
type.\
\- The `primary_keys` columns must be present in the data being updated.
An error is raised if a primary key column is missing.\
\- The values in the `primary_keys` columns cannot be null. A null value
cannot be used to match an existing row, so an error is raised if any
row has a null value in a primary key column.\
\- The values used as the `primary_keys` must be unique in the table. If
there are multiple rows with the same values in the `primary_keys` the
behavior is that an error will be raised.\
\- The columns used in `primary_keys` cannot contain updated values.
Since the values in these columns are used to determine if a row exists,
they cannot be updated in the same transaction.

## Usage

``` r
synUpdateRows(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, date_columns=NULL, date_format=NULL, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)
```

## Arguments

- instance:

  (EntityView) The EntityView instance to operate on.

- values:

  (Union\[str, dict\[str, Any\], object\]) Supports storing data from
  the following sources:\
  \
  \- A string holding the path to a CSV file. The data will be read into
  a data frame. The code makes assumptions about the format of the
  columns in the CSV as detailed in the
  [csv_to_pandas_df](https://python-docs.synapse.org/en/stable/reference/experimental/sync/table/#csv-to-pandas-df-reference-sync)
  function.\
  \- A named list where the key is the column name and the value is one
  or more values. The values will be wrapped into a data frame.\
  \- A data frame

- primary_keys:

  (list\[str\]) The columns to use to determine if a row already exists.
  If a row exists with the same values in the columns specified in this
  list the row will be updated. If a row does not exist nothing will be
  done.

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
  is reached a timeout error will be raised. The default is 600 seconds.

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

- wait_for_eventually_consistent_view:

  (bool) Only used if the table is a view. If set to TRUE this will wait
  for the view to reflect any changes that you've made to the view. This
  is useful if you need to query the view after making changes to the
  data. If you set this value to `TRUE` your view must contain the
  default `id` column which is the Synapse ID of the row. If you do not
  have this column in your view you will need to add it to the view
  before you can use this feature. The default is FALSE.

- wait_for_eventually_consistent_view_timeout:

  (int) The maximum amount of time to wait for a view to be eventually
  consistent. The default is 600 seconds.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Note

When `values` is a path to a CSV file, you may pass additional keyword
arguments to the
[`csv_to_pandas_df`](https://python-docs.synapse.org/en/stable/reference/experimental/sync/table/#csv-to-pandas-df-reference-sync)
function by adding them as extra named arguments to `synUpdateRows()`,
e.g. `separator = ";"` or `lines_to_skip = 1L`.

## Examples

``` r
if (FALSE) { # \dontrun{
## Updating custom annotation columns in a view
    # Rows are matched on the `id` column, and the values in `species` are updated.
    library(synapser)
    synLogin()

    my_view = EntityView(id = "syn123") |> synGet()

    modified_data = data.frame(
        id = c("syn456", "syn789"),
        species = c("Homo sapiens", "Mus musculus")
    )
    my_view |> synUpdateRows(values = modified_data, primary_keys = list("id"), dry_run = FALSE)
    my_view |> synStore()
} # }
```

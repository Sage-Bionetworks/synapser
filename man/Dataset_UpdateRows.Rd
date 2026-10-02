\name{synUpdateRows}
\alias{Dataset_synUpdateRows}
\docType{methods}
\title{
Dataset :  update_rows
}
\description{
Update the values of rows in the dataset. This method can only
be used to update values in custom columns. Default columns cannot be updated, but
may be used as primary keys.

Limitations:

- When updating many rows the requests to Synapse will be chunked into smaller
    requests. The limit is 2MB per request. This chunking will happen
    automatically and should not be a concern for most users. If you are
    having issues with the request being too large you may lower the
    number of rows you are trying to update.\cr
- The \code{primary_keys} argument must contain at least one column.\cr
- The \code{primary_keys} argument cannot contain columns that are a LIST type.\cr
- The \code{primary_keys} argument cannot contain columns that are a JSON type.\cr
- The values used as the \code{primary_keys} must be unique in the table. If there
    are multiple rows with the same values in the \code{primary_keys} the behavior
    is that an error will be raised.\cr
- The columns used in \code{primary_keys} cannot contain updated values. Since
    the values in these columns are used to determine if a row exists, they
    cannot be updated in the same transaction.
}
\usage{
synUpdateRows(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, date_columns=NULL, date_format=NULL, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{values}{(object) Supports storing data from the following sources:\cr
\cr
- A string holding the path to a CSV file. The data will be read into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. The code makes assumptions about the format of the columns in the CSV as detailed in the \href{https://python-docs.synapse.org/reference/experimental/sync/table/#csv-to-pandas-df-reference-sync}{csv_to_pandas_df} function. You may pass in additional arguments to the \code{csv_to_pandas_df} function by passing them in as extra named arguments to this function.\cr
- A named list where the key is the column name and the value is one or more values. The values will be wrapped into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. You may pass in additional arguments to the pandas DataFrame constructor by passing them in as extra named arguments to this function. Read about the available arguments in the \href{https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html}{Pandas DataFrame} documentation.\cr
- A \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}}
\item{primary_keys}{(list[character]) The columns to use to determine if a row already exists. If a row exists with the same values in the columns specified in this list the row will be updated. If a row does not exist nothing will be done.}
\item{dry_run}{(logical) If set to TRUE the data will not be updated in Synapse. A message will be printed to the console with the number of rows that would have been updated and inserted.}
\item{rows_per_query}{(integer) The number of rows that will be queried from Synapse per request. Since we need to query for the data that is being updated this will determine the number of rows that are queried at a time. The default is 50,000 rows.}
\item{update_size_bytes}{(integer) The maximum size of the request that will be sent to Synapse when updating rows of data. The default is 1.9MB.}
\item{insert_size_bytes}{(integer) The maximum size of the request that will be sent to Synapse when inserting rows of data. The default is 900MB.}
\item{job_timeout}{(integer) The maximum amount of time to wait for a job to complete. This is used when inserting, and updating rows of data. Each individual request to Synapse will be sent as an independent job. If the timeout is reached a timeout error will be raised. The default is 600 seconds}
\item{date_columns}{(Optional[list[character]]) (CSV file only) The names of columns in your CSV file that contain dates or datetimes stored as formatted strings (e.g. \code{"2024-01-15"} or \code{"01/15/2024 13:30"}). The columns are parsed with \code{pandas.to_datetime} and converted to epoch time in milliseconds before the data is uploaded, which is the format Synapse requires for \code{DATE} columns.}
\item{date_format}{(Optional[character or named list]) (CSV file only) How the strings in \code{date_columns} are formatted — a \href{https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes}{strftime format string} (e.g. \code{"\%m/\%d/\%Y"}) applied to every column, or a named list mapping column names to their formats. Supply this so that ambiguous dates (e.g. \code{"01/02/2024"}) are not silently misinterpreted and to optimize the data upload performance. If the values in a column do not match the format an error is raised.}
\item{wait_for_eventually_consistent_view}{(logical) Only used if the table is a view. If set to TRUE this will wait for the view to reflect any changes that you've made to the view. This is useful if you need to query the view after making changes to the data.}
\item{wait_for_eventually_consistent_view_timeout}{(integer) The maximum amount of time to wait for a view to be eventually consistent. The default is 600 seconds.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Update custom column values in a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()

    # my_annotation must already exist in the dataset as a custom column
    modified_data = data.frame(
        id = c("syn1234"),
        my_annotation = c("good data")
    )
    my_dataset |> synUpdateRows(values = modified_data, primary_keys = list("id"), dry_run = FALSE)
}
}
\keyword{Dataset}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpdateRows}
\alias{synUpdateRows}
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
    number of rows you are trying to update.
- The \code{primary_keys} argument must contain at least one column.
- The \code{primary_keys} argument cannot contain columns that are a LIST type.
- The \code{primary_keys} argument cannot contain columns that are a JSON type.
- The values used as the \code{primary_keys} must be unique in the table. If there
    are multiple rows with the same values in the \code{primary_keys} the behavior
    is that an exception will be raised.
- The columns used in \code{primary_keys} cannot contain updated values. Since
    the values in these columns are used to determine if a row exists, they
    cannot be updated in the same transaction.
}
\usage{
synUpdateRows(instance, values, primary_keys, dry_run=FALSE, rows_per_query=50000L, update_size_bytes=1992294.4, insert_size_bytes=943718400L, job_timeout=600L, wait_for_eventually_consistent_view=FALSE, wait_for_eventually_consistent_view_timeout=600L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{values}{(object) Supports storing data from the following sources:\cr
\cr
- A string holding the path to a CSV file. The data will be read into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. The code makes assumptions about the format of the columns in the CSV as detailed in the [csv_to_pandas_df][synapseclient.models.mixins.table_components.csv_to_pandas_df] function. You may pass in additional arguments to the \code{csv_to_pandas_df} function by passing them in as keyword arguments to this function. - A dictionary where the key is the column name and the value is one or more values. The values will be wrapped into a \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}. You may pass in additional arguments to the \code{pd.DataFrame} function by passing them in as keyword arguments to this function. Read about the available arguments in the \href{https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html}{Pandas DataFrame} documentation. - A \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{Pandas DataFrame}}
\item{primary_keys}{(list[str]) The columns to use to determine if a row already exists. If a row exists with the same values in the columns specified in this list the row will be updated. If a row does not exist nothing will be done.}
\item{dry_run}{(bool) If set to True the data will not be updated in Synapse. A message will be printed to the console with the number of rows that would have been updated and inserted. If you would like to see the data that would be updated and inserted you may set the \code{dry_run} argument to True and set the log level to DEBUG by setting the debug flag when creating your Synapse class instance like: \code{syn = Synapse(debug=True)}.}
\item{rows_per_query}{(int) The number of rows that will be queried from Synapse per request. Since we need to query for the data that is being updated this will determine the number of rows that are queried at a time. The default is 50,000 rows.}
\item{update_size_bytes}{(int) The maximum size of the request that will be sent to Synapse when updating rows of data. The default is 1.9MB.}
\item{insert_size_bytes}{(int) The maximum size of the request that will be sent to Synapse when inserting rows of data. The default is 900MB.}
\item{job_timeout}{(int) The maximum amount of time to wait for a job to complete. This is used when inserting, and updating rows of data. Each individual request to Synapse will be sent as an independent job. If the timeout is reached a \code{SynapseTimeoutError} will be raised. The default is 600 seconds}
\item{wait_for_eventually_consistent_view}{(bool) Only used if the table is a view. If set to True this will wait for the view to reflect any changes that you've made to the view. This is useful if you need to query the view after making changes to the data.}
\item{wait_for_eventually_consistent_view_timeout}{(int) The maximum amount of time to wait for a view to be eventually consistent. The default is 600 seconds.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor\cr
\cr
**kwargs: Additional arguments that are passed to the \code{pd.DataFrame} function when the \code{values} argument is a path to a csv file.}
}
\value{
NULL
}
\examples{
\dontrun{
## Update custom column values in a dataset.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset
    import pandas as pd

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()

        # my_annotation must already exist in the dataset as a custom column
        modified_data = pd.DataFrame(
            {"id": ["syn1234"], "my_annotation": ["good data"]}
        )
        await my_dataset.update_rows_async(values=modified_data, primary_keys=["id"], dry_run=False)

    asyncio.run(main())
}
}
\keyword{Dataset}

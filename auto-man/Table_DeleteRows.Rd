%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeleteRows}
\alias{synDeleteRows}
\docType{methods}
\title{
Table :  delete_rows
}
\description{
Delete rows from a table given a query or a pandas dataframe to select rows.
The query at a minimum must select the \code{ROW_ID} and \code{ROW_VERSION} columns. If you want to
inspect the data that will be deleted ahead of time you may use the
\code{.query} method to get the data.
The dataframe must at least contain the \code{ROW_ID} and \code{ROW_VERSION} columns. And \code{ROW_ETAG} column is also required
if the entity is one of the following: \code{EntityView}, \code{Dataset}, \code{DatasetCollection}, or \code{SubmissionView}.
If both query and df are provided, the query will be used.
}
\usage{
synDeleteRows(instance, query=NULL, df=NULL, job_timeout=600L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{query}{(Optional[str]) The query to select the rows to delete. The query at a minimum must select the \code{ROW_ID} and \code{ROW_VERSION} columns. See this document that describes the expected syntax of the query: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html>}
\item{df}{(Optional[object]) A pandas dataframe that contains the rows to delete. The dataframe must at least contain the \code{ROW_ID} and \code{ROW_VERSION} columns. If the entity is one of the following: \code{EntityView}, \code{Dataset}, \code{DatasetCollection}, or \code{SubmissionView} then the dataframe must also contain the \code{ROW_ETAG} column. See this document that describes the expected columns of the dataframe: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.html>}
\item{job_timeout}{(int) The amount of time to wait for table updates to complete before a \code{SynapseTimeoutError} is thrown. The default is 600 seconds.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The results of your query or dataframe for the rows that were deleted from the table.
}
\examples{
\dontrun{
## Example 1: Selecting a row to delete
    # This example shows how you may select a row to delete from a table.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        await Table(id="syn1234").delete_rows_async(query="SELECT ROW_ID, ROW_VERSION FROM syn1234 WHERE foo = 'asdf'")

    asyncio.run(main())

## Example 2: Selecting all rows that contain a null value
    # This example shows how you may select a row to delete from a table where
    # a column has a null value.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    async def main():
        await Table(id="syn1234").delete_rows_async(query="SELECT ROW_ID, ROW_VERSION FROM syn1234 WHERE foo is null")

    asyncio.run(main())

## Example 3: Selecting rows to delete using a dataframe
    # This example shows how you may select a row to delete from a table based on a dataframe.

    import asyncio
    import pandas as pd
    from synapseclient import Synapse
    from synapseclient.models import Table # Also works with \code{Dataset}

    syn = Synapse()
    syn.login()

    # Creating a pandas dataframe that contains the rows to delete.
    # In this example, we create a dataframe that specifies the first two rows of the table for deletion.
    # Assuming no changes have been made to the table so the ROW_VERSION is 1.

    df = pd.DataFrame({"ROW_ID": [1, 2], "ROW_VERSION": [1, 1]})
    async def main():
        await Table(id="syn1234").delete_rows_async(df=df)

    asyncio.run(main())
}
}
\keyword{Table}

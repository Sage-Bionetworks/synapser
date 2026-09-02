%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synQuery}
\alias{synQuery}
\docType{methods}
\title{
SubmissionView :  query
}
\description{
Query for data on a table stored in Synapse. The results will always be
returned as a Pandas DataFrame unless you specify a \code{download_location} in which
case the results will be downloaded to that location. There are a number of
arguments that you may pass to this function depending on if you are getting
the results back as a DataFrame or downloading the results to a file.
}
\usage{
synQuery(instance, query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionView) The SubmissionView instance to operate on.}
\item{query}{(str) The query to run. The query must be valid syntax that Synapse can understand. See this document that describes the expected syntax of the query: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html>}
\item{include_row_id_and_row_version}{(bool) If True the \code{ROW_ID} and \code{ROW_VERSION} columns will be returned in the DataFrame. These columns are required if using the query results to update rows in the table. These columns are the primary keys used by Synapse to uniquely identify rows in the table.}
\item{convert_to_datetime}{(bool) (DataFrame only) If set to True, will convert all Synapse DATE columns from UNIX timestamp integers into UTC datetime objects}
\item{download_location}{(CSV Only) If set to a path the results will be downloaded to that directory. The results will be downloaded as a CSV file. A path to the downloaded file will be returned instead of a DataFrame.}
\item{quote_character}{(CSV Only) The character to use to quote fields. The default is a double quote.}
\item{escape_character}{(CSV Only) The character to use to escape special characters. The default is a backslash.}
\item{line_end}{(CSV Only) The character to use to end a line. The default is the system's line separator.}
\item{separator}{(CSV Only) The character to use to separate fields. The default is a comma.}
\item{header}{(CSV Only) If set to True the first row will be used as the header row. The default is True.\cr
\cr
**kwargs: (DataFrame only) Additional keyword arguments to pass to pandas.read_csv. See <https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html> for complete list of supported arguments. This is exposed as internally the query downloads a CSV from Synapse and then loads it into a dataframe.}
\item{timeout}{}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The results of the query as a Pandas DataFrame or a path to the downloaded
    query results if \code{download_location} is set.
}
\examples{
\dontrun{
## Querying for data
    # This example shows how you may query for data in a table and print out the
    # results.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import query_async

    syn = Synapse()
    syn.login()

    async def main():
        results = await query_async(query="SELECT * FROM syn1234")
        print(results)

    asyncio.run(main())
}
}
\keyword{SubmissionView}

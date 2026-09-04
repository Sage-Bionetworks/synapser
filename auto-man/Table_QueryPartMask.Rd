%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synQueryPartMask}
\alias{synQueryPartMask}
\docType{methods}
\title{
Table :  query_part_mask
}
\description{
Query for data on a table stored in Synapse. This is a more advanced use case
of the \code{query} function that allows you to determine what addiitional metadata
about the table or query should also be returned. If you do not need this
additional information then you are better off using the \code{query} function.

The query for this method uses this Rest API:
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
}
\usage{
synQueryPartMask(instance, query, part_mask, timeout=250L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{query}{(str) The query to run. The query must be valid syntax that Synapse can understand. See this document that describes the expected syntax of the query: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html>}
\item{part_mask}{(int) The bitwise OR of the part mask values you want to return in the results. The following list of part masks are implemented to be returned in the results:\cr
\cr
- Query Results (queryResults) = 0x1 - Query Count (queryCount) = 0x2 - The sum of the file sizes (sumFileSizesBytes) = 0x40 - The last updated on date of the table (lastUpdatedOn) = 0x80}
\item{timeout}{}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The results of the query as a QueryResultOutput object.
}
\examples{
\dontrun{
## Querying for data with a part mask
    # This example shows how to use the bitwise \code{OR} of Python to combine the
    # part mask values and then use that to query for data in a table and print
    # out the results.

    # In this case we are getting the results of the query, the count of rows, and
    # the last updated on date of the table.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import query_part_mask_async

    syn = Synapse()
    syn.login()

    QUERY_RESULTS = 0x1
    QUERY_COUNT = 0x2
    LAST_UPDATED_ON = 0x80

    # Combine the part mask values using bitwise OR
    part_mask = QUERY_RESULTS | QUERY_COUNT | LAST_UPDATED_ON


    async def main():
        result = await query_part_mask_async(query="SELECT * FROM syn1234", part_mask=part_mask)
        print(result)

    asyncio.run(main())
}
}
\keyword{Table}

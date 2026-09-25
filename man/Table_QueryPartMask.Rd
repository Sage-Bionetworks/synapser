\name{synQueryPartMask}
\alias{Table_synQueryPartMask}
\docType{methods}
\title{
Table :  query_part_mask
}
\description{
Query for data on a table stored in Synapse. This is a more advanced use case
of the \code{\link[=synQuery]{synQuery}()} function that allows you to determine what additional metadata
about the table or query should also be returned. If you do not need this
additional information then you are better off using the \code{\link[=synQuery]{synQuery}()} function.

The query for this method uses this Rest API:
<https://rest-docs.synapse.org/rest/POST/entity/id/table/query/async/start.html>
}
\usage{
synQueryPartMask(query, part_mask, timeout=250L, synapse_client=NULL)
}
\arguments{
\item{query}{(str) The query to run. The query must be valid syntax that Synapse can understand. See this document that describes the expected syntax of the query: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html>}
\item{part_mask}{(int) The bitwise OR of the part mask values you want to return in the results. The following list of part masks are implemented to be returned in the results:\cr
\cr
- Query Results (queryResults) = 0x1\cr
- Query Count (queryCount) = 0x2\cr
- The sum of the file sizes (sumFileSizesBytes) = 0x40\cr
- The last updated on date of the table (lastUpdatedOn) = 0x80}
\item{timeout}{(int) The number of seconds to wait for the query job to complete before raising a timeout error. Defaults to 250.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The results of the query as a QueryResultOutput object.
}
\examples{
\dontrun{
## Querying for data with a part mask
    # This example shows how to use the bitwise OR to combine the
    # part mask values and then use that to query for data in a table and print
    # out the results.

    # In this case we are getting the results of the query, the count of rows, and
    # the last updated on date of the table.
    library(synapser)
    synLogin()

    QUERY_RESULTS = 0x1
    QUERY_COUNT = 0x2
    LAST_UPDATED_ON = 0x80

    # Combine the part mask values using bitwise OR
    part_mask = bitwOr(bitwOr(QUERY_RESULTS, QUERY_COUNT), LAST_UPDATED_ON)

    result = synQueryPartMask(query = "SELECT * FROM syn1234", part_mask = part_mask)
    result
}
}
\keyword{Table}

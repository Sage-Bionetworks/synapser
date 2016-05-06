\name{QueryResult}
\alias{QueryResult}
\alias{fetch}
\alias{collect}
\alias{collectAll}
\title{
  Retrieve Query Results
}
\description{
  QueryResult is a reference class that enables paging through query results.
}
\details{
  Synapse has the ability to query for entities using a SQL-like query language.
  See the Query service API wiki for details on how to form a query: http://sagebionetworks.jira.com/wiki/display/PLFM/Repository+Service+API#RepositoryServiceAPI-QueryAPI

  The QueryResult object is returned from the synapseQuery function when \code{blockSize} is specified. The
  client can then call either \code{fetch()} or \code{collect()} to get the next block of results as a data.frame.
  The difference is that with \code{collect()}, the results are accumulated. For example, after 3 calls to \code{collect()},
  with a \code{blockSize} of 10 we would expect a data.frame with 30 rows.

  The \code{collectAll()} method repeatedly requests blocks of \code{blocksize} query results until there are no more or the
  limit is reached. This can be slow, so use with caution. It's usually safer to set a limit.
}
\author{
  J. Christopher Bare <chris.bare@sagebase.org>
}
\seealso{
  \code{\link{synapseQuery}}
}
\examples{
\dontrun{
  ## get a QueryResult object back from a query
  qr <- synapseQuery("select id, name, parentId from file limit 1000", blockSize=100)

  ## get a data.frame with 100 results
  df <- qr$fetch()

  ## accumulate the next 300 results
  df <- qr$collect()
  df <- qr$collect()
  df <- qr$collect()

  # get number of rows accumulated
  # should be 400 with initial fetch plus 3 calls to collect
  length(qr)

  # return the selected column names
  names(qr)

  ## accumulate the remaining results.
  ## df will be a data.frame with all 1000 accumulated rows
  df <- qr$collectAll()
}
}
\keyword{query}
\keyword{results}
\keyword{paging}
\keyword{fetch}
\keyword{collect}
\keyword{collectAll}

\name{synapseQuery}
\alias{synapseQuery}
\alias{synQuery}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Query The Synapse API
}
\description{
Provides an interface to the Synapse API
}
\usage{
synapseQuery(queryStatement)
synQuery(queryStatement)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{queryStatement}{
The query statement
}
  \item{blockSize}{
Defaults to NULL. If \code{blockSize} is set to an integer, returns a \code{\link{QueryResult}} object.
}
}
\details{
See the Query service API wiki for details on how to form a query: http://sagebionetworks.jira.com/wiki/display/PLFM/Repository+Service+API#RepositoryServiceAPI-QueryAPI
}
\value{
Depending on whether \code{blockSize} is specified, returns a data.frame holding all query results or a \code{\link{QueryResult}} object, which enables paging through query results in increments of \code{blockSize} rows.

Care should be taken to return a reasonable number of results. The service enforces a limit on the size
of responses and will return an error if that limit is exceeded. Specifying only necessary columns, 
limiting the number of rows, and paging by specifying \code{blockSize} are all good strategies for
staying within the response size limit.
}

\author{
Nicole Deflaux
}

\seealso{
  \code{\link{QueryResult}}
}

\examples{
\dontrun{
  ## query for the first 1000 Files found, returning results as a data.frame
  df <- synQuery("select id, name, parentId from file limit 1000")


  ## get a QueryResult object back from a query
  qr <- synQuery("select id, name, parentId from file limit 1000", blockSize=100)

  ## get a data.frame with 100 results
  df <- qr$fetch()

  ## accumulate the next 300 results
  df <- qr$collect()
  df <- qr$collect()
  df <- qr$collect()

  ## accumulate the remaining results.
  ## df will be a data.frame with 1000 accumulated rows
  df <- qr$collectAll()
}
}
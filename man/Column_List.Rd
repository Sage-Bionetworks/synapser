\name{synList}
\alias{synList}
\docType{methods}
\title{
Column :  list
}
\description{
List columns with optional prefix filtering.
}
\usage{
synList(prefix=NULL, limit=100L, offset=0L, synapse_client=NULL)
}
\arguments{
\item{prefix}{(Optional[str]) Optional prefix to filter columns by name.}
\item{limit}{(int) Number of columns to retrieve per request to Synapse (pagination parameter). The function will continue retrieving results until all matching columns are returned.}
\item{offset}{(int) The index of the first column to return (pagination parameter).}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields \code{\link{Column}} instances. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{\link{Column}} instance at a time.
}
\examples{
\dontrun{
## Example 1: Getting all columns
    # This example shows how you may list all columns.
    library(synapser)
    synLogin()

    columns = synList()
    for (column in as.list(columns)) {
        print(column$name)
    }

## Example 2: Getting columns with a prefix
    # This example shows how you may list columns filtered by a name prefix.
    library(synapser)
    synLogin()

    columns = synList(prefix = "my_prefix")
    for (column in as.list(columns)) {
        print(column$name)
    }
}
}
\keyword{Column}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
synList(instance, prefix=NULL, limit=100L, offset=0L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Column) The Column instance to operate on.}
\item{prefix}{(Optional[str]) Optional prefix to filter columns by name.}
\item{limit}{(int) Number of columns to retrieve per request to Synapse (pagination parameter). The function will continue retrieving results until all matching columns are returned.}
\item{offset}{(int) The index of the first column to return (pagination parameter).}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A generator that yields Column instances.
}
\examples{
\dontrun{
## Example 1: Getting all columns
    Getting all columns

        from synapseclient import Synapse
        from synapseclient.models import Column

        syn = Synapse()
        syn.login()

        for column in Column.list():
            print(column.name)

## Example 2: Getting columns with a prefix
    Getting columns with a prefix

        from synapseclient import Synapse
        from synapseclient.models import Column

        syn = Synapse()
        syn.login()

        for column in Column.list(prefix="my_prefix"):
            print(column.name)
}
}
\keyword{Column}

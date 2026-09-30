\name{synReorderColumn}
\alias{DatasetCollection_synReorderColumn}
\docType{methods}
\title{
DatasetCollection :  reorder_column
}
\description{
Reorder a column in the table. Note that this does not store the column in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this DatasetCollection instance to
store the column in Synapse. This is a convenience function to eliminate
the need to manually reorder the named list stored in the \code{$columns} attribute.

You must ensure that the index is within the bounds of the number of columns in
the table. If you pass in an index that is out of bounds the column will be
added to the end of the list.
}
\usage{
synReorderColumn(instance, name, index)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{name}{(character) The name of the column to reorder.}
\item{index}{(integer) The index to move the column to starting with 0.}
}
\value{
NULL
}
\examples{
\dontrun{
## Reordering a column
    # This example shows how you may reorder a column in a dataset collection and
    # then store the change back in Synapse.
    library(synapser)
    synLogin()

    collection = DatasetCollection(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    # Move the column to the beginning of the list
    collection |> synReorderColumn(name = "my_column", index = 0L)
    collection |> synStore()
}
}
\keyword{DatasetCollection}

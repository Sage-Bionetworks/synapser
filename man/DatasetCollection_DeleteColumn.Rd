\name{synDeleteColumn}
\alias{DatasetCollection_synDeleteColumn}
\docType{methods}
\title{
DatasetCollection :  delete_column
}
\description{
Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this DatasetCollection instance to delete the column from Synapse.
}
\usage{
synDeleteColumn(instance, name)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{name}{(character) The name of the column to delete.}
}
\value{
NULL
}
\examples{
\dontrun{
## Deleting a column
    # This example shows how you may delete a column from a dataset collection
    # and then store the change back in Synapse.
    library(synapser)
    synLogin()

    collection = DatasetCollection(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    collection |> synDeleteColumn(name = "my_column")
    collection |> synStore()
}
}
\keyword{DatasetCollection}

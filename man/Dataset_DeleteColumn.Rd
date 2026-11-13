\name{synDeleteColumn}
\alias{Dataset_synDeleteColumn}
\docType{methods}
\title{
Dataset :  delete_column
}
\description{
Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this Dataset instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the named list and add it to the
\code{$_columns_to_delete} attribute.
}
\usage{
synDeleteColumn(instance, name)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{name}{(character) The name of the column to delete.}
}
\value{
NULL
}
\examples{
\dontrun{
## Deleting a column
    # This example shows how you may delete a column from a dataset and then
    # store the change back in Synapse.
    library(synapser)
    synLogin()

    dataset = Dataset(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    dataset |> synDeleteColumn(name = "my_column")
    dataset |> synStore()
}
}
\keyword{Dataset}

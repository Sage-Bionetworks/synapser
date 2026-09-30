\name{synAddColumn}
\alias{DatasetCollection_synAddColumn}
\docType{methods}
\title{
DatasetCollection :  add_column
}
\description{
Add column(s) to the table. Note that this does not store the column(s) in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this DatasetCollection instance to
store the column(s) in Synapse. This is a convenience function to eliminate
the need to manually add the column(s) to the \code{$columns} list.


This function will add an item to the \code{$columns} attribute of the DatasetCollection
instance. \code{$columns} is a named list where the key is the name of the column
and the value is the Column object.
}
\usage{
synAddColumn(instance, column, index=NULL)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{column}{(Column or list of Column) The column(s) to add, may be a single Column object or a list of Column objects.}
\item{index}{(integer) The index to insert the column at. If not passed in the column will be added to the end of the list.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Adding a single column
    # This example shows how you may add a single column to a dataset collection
    # and then store the change back in Synapse.
    library(synapser)
    synLogin()

    collection = DatasetCollection(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    collection |> synAddColumn(
        Column(name = "my_column", column_type = "STRING")
    )
    collection |> synStore()

## Example 2: Adding multiple columns
    # This example shows how you may add multiple columns to a dataset collection
    # and then store the change back in Synapse.

    library(synapser)
    synLogin()

    collection = DatasetCollection(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    collection |> synAddColumn(list(
        Column(name = "my_column", column_type = "STRING"),
        Column(name = "my_column2", column_type = "INTEGER")
    ))
    collection |> synStore()

## Example 3: Adding a column at a specific index
    # This example shows how you may add a column at a specific index to a
    # dataset collection and then store the change back in Synapse. If the index
    # is out of bounds the column will be added to the end of the list.

    library(synapser)
    synLogin()

    collection = DatasetCollection(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    collection |> synAddColumn(
        Column(name = "my_column", column_type = "STRING"),
        # Add the column at the beginning of the list
        index = 0L
    )
    collection |> synStore()
}
}
\keyword{DatasetCollection}

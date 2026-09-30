\name{synAddColumn}
\alias{EntityView_synAddColumn}
\docType{methods}
\title{
EntityView :  add_column
}
\description{
Add column(s) to the EntityView. Note that this does not store the column(s) in
Synapse. You must call the \code{\link[=synStore]{synStore}()} function on this EntityView instance to
store the column(s) in Synapse. This is a convenience function to eliminate
the need to manually add the column(s) to the \code{$columns} list.


This function will add an item to the \code{$columns} attribute of the EntityView
instance. \code{$columns} is a named list where the key is the name of the column
and the value is the Column object.
}
\usage{
synAddColumn(instance, column, index=NULL)
}
\arguments{
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{column}{(Column or list of Column) The column(s) to add, may be a single Column object or a list of Column objects.}
\item{index}{(int) The index to insert the column at. If not passed in the column will be added to the end of the list.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Adding a single column
    # This example shows how you may add a single column to an EntityView and then store
    # the change back in Synapse.

    library(synapser)
    synLogin()

    entityview = EntityView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    entityview |> synAddColumn(
        Column(name = "my_column", column_type = "STRING")
    )
    entityview |> synStore()

## Example 2: Adding multiple columns
    # This example shows how you may add multiple columns to an EntityView and then store
    # the change back in Synapse.

    library(synapser)
    synLogin()

    entityview = EntityView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    entityview |> synAddColumn(list(
        Column(name = "my_column", column_type = "STRING"),
        Column(name = "my_column2", column_type = "INTEGER")
    ))
    entityview |> synStore()

## Example 3: Adding a column at a specific index
    # This example shows how you may add a column at a specific index to an EntityView
    # and then store the change back in Synapse. If the index is out of bounds the
    # column will be added to the end of the list.

    library(synapser)
    synLogin()

    entityview = EntityView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    entityview |> synAddColumn(
        Column(name = "my_column", column_type = "STRING"),
        # Add the column at the beginning of the list
        index = 0L
    )
    entityview |> synStore()
}
}
\keyword{EntityView}

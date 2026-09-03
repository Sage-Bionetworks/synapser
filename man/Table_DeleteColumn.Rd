%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeleteColumn}
\alias{synDeleteColumn}
\docType{methods}
\title{
Table :  delete_column
}
\description{
Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{synStore()} function on this Table instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the named list and add it to the
\code{$_columns_to_delete} attribute.
}
\usage{
synDeleteColumn(instance, name)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{name}{(str) The name of the column to delete.}
}
\value{
NULL
}
\examples{
\dontrun{
## Deleting a column
    # This example shows how you may delete a column from a table and then store
    # the change back in Synapse.
    library(synapser)
    synLogin()

    table = Table(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    table |> synDeleteColumn(name = "my_column")
    table |> synStore()
}
}
\keyword{Table}

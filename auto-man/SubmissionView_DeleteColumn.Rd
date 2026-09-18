%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeleteColumn}
\alias{synDeleteColumn}
\docType{methods}
\title{
SubmissionView :  delete_column
}
\description{
Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{.store()} function on this table class instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the dictionary and add it to the
\code{._columns_to_delete} attribute.
}
\usage{
synDeleteColumn(instance, name)
}
\arguments{
\item{instance}{(SubmissionView) The SubmissionView instance to operate on.}
\item{name}{(str) The name of the column to delete.}
}
\value{
None
}
\examples{
\dontrun{
## Example 1: Deleting a column
    # This example shows how you may delete a column from a table and then store
    # the change back in Synapse.

    from synapseclient import Synapse
    from synapseclient.models import Table

    syn = Synapse()
    syn.login()

    table = Table(
        id="syn1234"
    ).get(include_columns=True)

    table.delete_column(name="my_column")
    table.store()

## Example 2: Deleting a column (async)
    # This example shows how you may delete a column from a table and then store
    # the change back in Synapse.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Table

    syn = Synapse()
    syn.login()

    async def main():
        table = await Table(
            id="syn1234"
        ).get_async(include_columns=True)

        table.delete_column(name="my_column")
        table.store_async()

    asyncio.run(main())
}
}
\keyword{SubmissionView}

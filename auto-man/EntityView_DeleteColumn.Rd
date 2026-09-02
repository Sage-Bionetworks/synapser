%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeleteColumn}
\alias{synDeleteColumn}
\docType{methods}
\title{
EntityView :  delete_column
}
\description{
Mark a column for deletion. Note that this does not delete the column from
Synapse. You must call the \code{.store()} function on this entityview class instance to
delete the column from Synapse. This is a convenience function to eliminate
the need to manually delete the column from the dictionary and add it to the
\code{._columns_to_delete} attribute.
}
\usage{
synDeleteColumn(instance, name)
}
\arguments{
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{name}{(str) The name of the column to delete.}
}
\value{
None
}
\examples{
\dontrun{
## Example 1: Deleting a column
    # This example shows how you may delete a column from a entityview and then store
    # the change back in Synapse.

    from synapseclient import Synapse
    from synapseclient.models import EntityView

    syn = Synapse()
    syn.login()

    entityview = EntityView(
        id="syn1234"
    ).get(include_columns=True)

    entityview.delete_column(name="my_column")
    entityview.store()

## Example 2: Deleting a column (async)
    # This example shows how you may delete a column from a entityview and then store
    # the change back in Synapse.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import EntityView

    syn = Synapse()
    syn.login()

    async def main():
        entityview = await EntityView(
            id="syn1234"
        ).get_async(include_columns=True)

        entityview.delete_column(name="my_column")
        await entityview.store_async()

    asyncio.run(main())
}
}
\keyword{EntityView}

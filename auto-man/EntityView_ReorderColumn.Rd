%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synReorderColumn}
\alias{synReorderColumn}
\docType{methods}
\title{
EntityView :  reorder_column
}
\description{
Reorder a column in the entityview. Note that this does not store the column in
Synapse. You must call the \code{.store()} function on this entityview class instance to
store the column in Synapse. This is a convenience function to eliminate
the need to manually reorder the \code{.columns} attribute dictionary.

You must ensure that the index is within the bounds of the number of columns in
the entityview. If you pass in an index that is out of bounds the column will be
added to the end of the list.
}
\usage{
synReorderColumn(instance, name, index)
}
\arguments{
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{name}{(str) The name of the column to reorder.}
\item{index}{(int) The index to move the column to starting with 0.}
}
\value{
None
}
\examples{
\dontrun{
## Example 1: Reordering a column
    # This example shows how you may reorder a column in a entityview and then store
    # the change back in Synapse.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, EntityView

    syn = Synapse()
    syn.login()

    entityview = EntityView(
        id="syn1234"
    ).get(include_columns=True)

    # Move the column to the beginning of the list
    entityview.reorder_column(name="my_column", index=0)
    entityview.store()


## Example 2: Reordering a column (async)
    # This example shows how you may reorder a column in a entityview and then store
    # the change back in Synapse.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, EntityView

    syn = Synapse()
    syn.login()

    async def main():
        entityview = await EntityView(
            id="syn1234"
        ).get_async(include_columns=True)

        # Move the column to the beginning of the list
        entityview.reorder_column(name="my_column", index=0)
        entityview.store_async()

    asyncio.run(main())
}
}
\keyword{EntityView}

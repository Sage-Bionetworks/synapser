%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synAddColumn}
\alias{synAddColumn}
\docType{methods}
\title{
Dataset :  add_column
}
\description{
Add column(s) to the table. Note that this does not store the column(s) in
Synapse. You must call the \code{.store()} function on this table class instance to
store the column(s) in Synapse. This is a convenience function to eliminate
the need to manually add the column(s) to the dictionary.


This function will add an item to the \code{.columns} attribute of this class
instance. \code{.columns} is a dictionary where the key is the name of the column
and the value is the Column object.
}
\usage{
synAddColumn(instance, column, index=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{column}{(Union[ForwardRef('Column'), list[ForwardRef('Column')]]) The column(s) to add, may be a single Column object or a list of Column objects.}
\item{index}{(int) The index to insert the column at. If not passed in the column will be added to the end of the list.}
}
\value{
None
}
\examples{
\dontrun{
## Example 1: Adding a single column
    # This example shows how you may add a single column to a table and then store
    # the change back in Synapse.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    table = Table(
        id="syn1234"
    ).get(include_columns=True)

    table.add_column(
        Column(name="my_column", column_type=ColumnType.STRING)
    )
    table.store()


## Example 2: Adding multiple columns
    # This example shows how you may add multiple columns to a table and then store
    # the change back in Synapse.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    table = Table(
        id="syn1234"
    ).get(include_columns=True)

    table.add_column([
        Column(name="my_column", column_type=ColumnType.STRING),
        Column(name="my_column2", column_type=ColumnType.INTEGER),
    ])
    table.store()

## Example 3: Adding a column at a specific index
    # This example shows how you may add a column at a specific index to a table
    # and then store the change back in Synapse. If the index is out of bounds the
    # column will be added to the end of the list.

    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    table = Table(
        id="syn1234"
    ).get(include_columns=True)

    table.add_column(
        Column(name="my_column", column_type=ColumnType.STRING),
        # Add the column at the beginning of the list
        index=0
    )
    table.store()

## Example 4: Adding a single column (async)
    # This example shows how you may add a single column to a table and then store
    # the change back in Synapse.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    async def main():
        table = await Table(
            id="syn1234"
        ).get_async(include_columns=True)

        table.add_column(
            Column(name="my_column", column_type=ColumnType.STRING)
        )
        await table.store_async()

    asyncio.run(main())

## Example 5: Adding multiple columns (async)
    # This example shows how you may add multiple columns to a table and then store
    # the change back in Synapse.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    async def main():
        table = await Table(
            id="syn1234"
        ).get_async(include_columns=True)

        table.add_column([
            Column(name="my_column", column_type=ColumnType.STRING),
            Column(name="my_column2", column_type=ColumnType.INTEGER),
        ])
        await table.store_async()

    asyncio.run(main())

## Example 6: Adding a column at a specific index (async)
    # This example shows how you may add a column at a specific index to a table
    # and then store the change back in Synapse. If the index is out of bounds the
    # column will be added to the end of the list.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Column, ColumnType, Table

    syn = Synapse()
    syn.login()

    async def main():
        table = await Table(
            id="syn1234"
        ).get_async(include_columns=True)

        table.add_column(
            Column(name="my_column", column_type=ColumnType.STRING),
            # Add the column at the beginning of the list
            index=0
        )
        await table.store_async()

    asyncio.run(main())
}
}
\keyword{Dataset}

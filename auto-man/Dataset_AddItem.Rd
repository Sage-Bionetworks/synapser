%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synAddItem}
\alias{synAddItem}
\docType{methods}
\title{
Dataset :  add_item
}
\description{
Adds an item in the form of an EntityRef to the dataset.
For Folders, children are added recursively. Effect is not seen
until the dataset is stored.
}
\usage{
synAddItem(instance, item, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{item}{(Union[EntityRef, ForwardRef('File'), ForwardRef('Folder')]) Entity to add to the dataset. Must be an EntityRef, File, or Folder.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If the item is not an EntityRef, File, or Folder
}
\examples{
\dontrun{
## Example 1: Add a file to a dataset.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset, File

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.add_item_async(File(id="syn1235"))
        await my_dataset.store_async()

    asyncio.run(main())

## Example 2: Add a folder to a dataset.
    # All child files are recursively added to the dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset, Folder

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.add_item_async(Folder(id="syn1236"))
        await my_dataset.store_async()

    asyncio.run(main())

## Example 3: Add an entity reference to a dataset.

    from synapseclient import Synapse
    from synapseclient.models import Dataset, EntityRef

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.add_item_async(EntityRef(id="syn1237", version=1))
        await my_dataset.store_async()

    asyncio.run(main())
}
}
\keyword{Dataset}

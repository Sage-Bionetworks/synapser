%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRemoveItem}
\alias{synRemoveItem}
\docType{methods}
\title{
Dataset :  remove_item
}
\description{
Removes an item from the dataset. For Folders, all
children of the folder are removed recursively.
Effect is not seen until the dataset is stored.
}
\usage{
synRemoveItem(instance, item, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{item}{(Union[EntityRef, ForwardRef('File'), ForwardRef('Folder')]) The Synapse ID or Entity to remove from the dataset}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None
}
\section{Errors}{
ValueError: If the item is not a valid type
}
\examples{
\dontrun{
## Example 1: Remove a file from a dataset.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset, File

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.remove_item_async(File(id="syn1235"))
        await my_dataset.store_async()

    asyncio.run(main())

## Example 2: Remove a folder from a dataset.
    # All child files are recursively removed from the dataset.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset, Folder

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.remove_item_async(Folder(id="syn1236"))
        await my_dataset.store_async()

    asyncio.run(main())

## Example 3: Remove an entity reference from a dataset.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset, EntityRef

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.remove_item_async(EntityRef(id="syn1237", version=1))
        await my_dataset.store_async()

    asyncio.run(main())
}
}
\keyword{Dataset}

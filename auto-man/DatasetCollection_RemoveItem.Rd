%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRemoveItem}
\alias{synRemoveItem}
\docType{methods}
\title{
DatasetCollection :  remove_item
}
\description{
Removes an entity from the dataset collection. Must be a Dataset or EntityRef.
Effect is not seen until the dataset collection is stored.
Unless the version is specified, all entities with the same ID will be removed.
}
\usage{
synRemoveItem(instance, item)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{item}{(Union[ForwardRef('Dataset'), ForwardRef('EntityRef')]) The Dataset to remove from the collection}
}
\value{
None
}
\section{Errors}{
ValueError: If the item is not a Dataset
}
\examples{
\dontrun{
## Example 1: Remove a Dataset from a Dataset Collection.

    from synapseclient import Synapse
    from synapseclient.models import DatasetCollection, Dataset

    syn = Synapse()
    syn.login()

    my_collection = DatasetCollection(id="syn1234").get()
    my_collection.remove_item(Dataset(id="syn1235", version_number=1))
    my_collection.store()

## Example 2: Remove all versions of a Dataset from a Dataset Collection.

    from synapseclient import Synapse
    from synapseclient.models import DatasetCollection, Dataset

    syn = Synapse()
    syn.login()

    my_collection = DatasetCollection(id="syn1234").get()
    my_collection.remove_item(Dataset(id="syn1235"))
    my_collection.store()
}
}
\keyword{DatasetCollection}

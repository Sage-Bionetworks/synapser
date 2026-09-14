%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synAddItem}
\alias{synAddItem}
\docType{methods}
\title{
DatasetCollection :  add_item
}
\description{
Adds a dataset to the dataset collection.
Effect is not seen until the dataset collection is stored.
}
\usage{
synAddItem(instance, item)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{item}{(Union[ForwardRef('Dataset'), ForwardRef('EntityRef')]) Dataset to add to the collection. Must be a Dataset.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If the item is not a Dataset
}
\examples{
\dontrun{
## Add a Dataset to a Dataset Collection.

    from synapseclient import Synapse
    from synapseclient.models import DatasetCollection, Dataset

    syn = Synapse()
    syn.login()

    my_collection = DatasetCollection(id="syn1234").get()
    my_collection.add_item(Dataset(id="syn1235"))
    my_collection.store()
}
}
\keyword{DatasetCollection}

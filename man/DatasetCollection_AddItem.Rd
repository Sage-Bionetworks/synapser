\name{synAddItem}
\alias{DatasetCollection_synAddItem}
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
\item{item}{(Dataset or EntityRef) Dataset to add to the collection. Must be a Dataset or an \code{\link{EntityRef}} pointing to one.}
}
\value{
NULL
}
\section{Errors}{
Raises an error if the item is not a Dataset or EntityRef.
}
\examples{
\dontrun{
## Add a Dataset to a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synAddItem(Dataset(id = "syn1235"))
    my_collection |> synStore()
}
}
\keyword{DatasetCollection}

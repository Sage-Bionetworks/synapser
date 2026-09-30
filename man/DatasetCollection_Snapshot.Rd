\name{synSnapshot}
\alias{DatasetCollection_synSnapshot}
\docType{methods}
\title{
DatasetCollection :  snapshot
}
\description{
Creates a snapshot of the dataset collection. A snapshot is a saved, read-only version of the dataset collection
at the time it was created. Dataset collection snapshots are created using the asynchronous job API.
}
\usage{
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{comment}{(Optional[character]) A unique comment to associate with the snapshot.}
\item{label}{(Optional[character]) A unique label to associate with the snapshot.}
\item{include_activity}{(logical) If TRUE the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{$activity} attribute on the Dataset Collection and calling the \code{\link[=synStore]{synStore}()} function on the Dataset Collection instance. Adding an activity to a snapshot of a dataset collection is meant to capture the provenance of the data at the time of the snapshot. Defaults to TRUE.}
\item{associate_activity_to_new_version}{(logical) If TRUE the activity will be associated with the new version of the dataset collection. If FALSE the activity will not be associated with the new version of the dataset collection. Defaults to TRUE.}
\item{timeout}{(integer) The number of seconds to wait for the async job to complete. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{TableUpdateTransaction} object which includes the version number of the snapshot.
}
\examples{
\dontrun{
## Save a snapshot of a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synSnapshot(comment = "My first snapshot", label = "My first snapshot")
}
}
\keyword{DatasetCollection}

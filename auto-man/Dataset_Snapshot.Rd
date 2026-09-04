%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSnapshot}
\alias{synSnapshot}
\docType{methods}
\title{
Dataset :  snapshot
}
\description{
Creates a snapshot of the dataset. A snapshot is a saved, read-only version of the dataset
at the time it was created. Dataset snapshots are created using the asyncronous job API.
}
\usage{
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{comment}{(Optional[str]) A unique comment to associate with the snapshot.}
\item{label}{(Optional[str]) A unique label to associate with the snapshot.}
\item{include_activity}{(bool) If True the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{activity} attribute on the Dataset and calling the \code{store()} method on the Dataset instance. Adding an activity to a snapshot of a dataset is meant to capture the provenance of the data at the time of the snapshot. Defaults to True.}
\item{associate_activity_to_new_version}{(bool) If True the activity will be associated with the new version of the dataset. If False the activity will not be associated with the new version of the dataset. Defaults to True.}
\item{timeout}{(int) The number of seconds to wait for the async job to complete. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A \code{TableUpdateTransaction} object which includes the version number of the snapshot.
}
\examples{
\dontrun{
## Save a snapshot of a dataset.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Dataset

    syn = Synapse()
    syn.login()

    async def main():
        my_dataset = await Dataset(id="syn1234").get_async()
        await my_dataset.snapshot_async(comment="My first snapshot", label="My first snapshot")

    asyncio.run(main())
}
}
\keyword{Dataset}

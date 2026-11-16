%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{StorageLocation_synStore}
\docType{methods}
\title{
StorageLocation :  store
}
\description{
Create this storage location in Synapse. Storage locations are immutable;
this always creates a new one. If a storage location with identical properties
already exists for this user, the existing one is returned (idempotent).
}
\usage{
synStore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(StorageLocation) The StorageLocation instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The StorageLocation object with server-assigned fields populated.
}
\section{Errors}{
ValueError: If \code{storage_type} is not set.
}
\examples{
\dontrun{
## Using this function
    Create an external S3 storage location:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import StorageLocation, StorageLocationType

        syn = Synapse()
        syn.login()

        async def main():
            storage = await StorageLocation(
                storage_type=StorageLocationType.EXTERNAL_S3,
                bucket="my-bucket",
                base_key="my/prefix",
            ).store_async()
            print(f"Created storage location: {storage.storage_location_id}")

        asyncio.run(main())
}
}
\keyword{StorageLocation}

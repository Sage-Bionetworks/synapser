%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{StorageLocation_synGet}
\docType{methods}
\title{
StorageLocation :  get
}
\description{
Retrieve this storage location from Synapse by its ID. Only the creator of
a StorageLocationSetting can retrieve it by its id.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(StorageLocation) The StorageLocation instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The StorageLocation object populated with data from Synapse.
}
\section{Errors}{
ValueError: If \code{storage_location_id} is not set.
}
\examples{
\dontrun{
## Using this function
    Retrieve a storage location by ID:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import StorageLocation

        syn = Synapse()
        syn.login()

        async def main():
            storage = await StorageLocation(storage_location_id=12345).get_async()
            print(f"Type: {storage.storage_type}, Bucket: {storage.bucket}")

        asyncio.run(main())
}
}
\keyword{StorageLocation}

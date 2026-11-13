%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSetStorageLocation}
\alias{Project_synSetStorageLocation}
\docType{methods}
\title{
Project :  set_storage_location
}
\description{
Set the upload storage location for this entity. This configures where
files uploaded to this entity will be stored.

**This is a destructive update.** The provided \code{storage_location_id} value(s)
will **replace** any storage locations previously configured on this entity.
To add a storage location without removing existing ones, first retrieve the
current setting via \code{get_project_setting_async}, append to its \code{locations}
list, and call \code{store_async} on the returned \code{ProjectSetting} directly.
The first ID in the list is the default upload destination.
To obtain a storage location ID, create a
[StorageLocation][synapseclient.models.StorageLocation] and use its
\code{storage_location_id}. See
[StorageLocationType][synapseclient.models.StorageLocationType] for the
available storage backend types.
}
\usage{
synSetStorageLocation(instance, storage_location_id=1L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{storage_location_id}{(Optional[Union[int, list[int]]]) The storage location ID(s) to set. Can be a single ID, a list of IDs (first is default, max 10). By default, the default Synapse S3 storage location is used.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The ProjectSetting object reflecting the current state after the operation.
}
\section{Errors}{
ValueError: If the entity does not have an id set.
}
\examples{
\dontrun{
## Example 1: Replace all storage locations
    Fully replace the storage location on a folder with a single location:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Folder

        syn = Synapse()
        syn.login()

        async def main():
            folder = await Folder(id="syn123").get_async()
            setting = await folder.set_storage_location_async(
                storage_location_id=12345
            )
            print(setting)

        asyncio.run(main())

## Example 2: Partial update — add a storage location without removing existing ones
    Retrieve the current setting and append a new location:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Folder

        syn = Synapse()
        syn.login()

        async def main():
            folder = await Folder(id="syn123").get_async()
            setting = await folder.get_project_setting_async(setting_type="upload")
            if setting:
                setting.locations.append(67890)
                await setting.store_async()

        asyncio.run(main())
}
}
\keyword{Project}

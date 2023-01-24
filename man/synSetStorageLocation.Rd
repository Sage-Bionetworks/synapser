\name{synSetStorageLocation}
\alias{synSetStorageLocation}
\docType{methods}
\title{
synSetStorageLocation
}
\description{
Sets the storage location for a Project or Folder
}
\usage{
synSetStorageLocation(entity, storage_location_id)
}
\arguments{
\item{entity}{ a Project or Folder to which the StorageLocationSetting is set\cr
}
\item{storage_location_id}{ a StorageLocation id or a list of StorageLocation ids. Pass in NULL for the default Synapse storage.}
}
\value{
 The created or updated settings as a named list.
}





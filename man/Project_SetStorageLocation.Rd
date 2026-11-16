\name{synSetStorageLocation}
\alias{Project_synSetStorageLocation}
\docType{methods}
\title{
Project :  set_storage_location
}
\description{
Set the upload storage location for this entity. This configures where
files uploaded to this entity will be stored.

\strong{This is a destructive update.} The provided \code{storage_location_id} value(s)
will \strong{replace} any storage locations previously configured on this entity.
To add a storage location without removing existing ones, first retrieve the
current setting with \code{\link[=Project_synGetProjectSetting]{synGetProjectSetting}()}, then pass its existing
\code{locations} together with the new ID as \code{storage_location_id}.
The first ID in the list is the default upload destination.
}
\usage{
synSetStorageLocation(instance, storage_location_id=1L, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{storage_location_id}{(Optional[integer or list of integer]) The storage location ID(s) to set. Can be a single ID, a list of IDs (first is default, max 10). By default, the default Synapse S3 storage location is used.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The ProjectSetting object reflecting the current state after the operation.
}
\section{Errors}{
Raises an error if the entity does not have an id set.
}
\examples{
\dontrun{
## Example 1: Replace all storage locations
    # Fully replace the storage location on a project with a single location:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synSetStorageLocation(storage_location_id = 12345L)
    print(setting)

## Example 2: Partial update — add a storage location without removing existing ones
    # Retrieve the current setting and set the existing locations plus a new one:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        locations = c(unlist(setting$locations), 67890L)
        project |> synSetStorageLocation(storage_location_id = as.list(locations))
    }
}
}
\keyword{Project}

\name{synDeleteProjectSetting}
\alias{Folder_synDeleteProjectSetting}
\docType{methods}
\title{
Folder :  delete_project_setting
}
\description{
Delete a project setting by its setting ID.
}
\usage{
synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{setting_id}{(character) The ID of the project setting to delete.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\section{Errors}{
Raises an error if the entity does not have an id set.
}
\examples{
\dontrun{
## Using this function
    # Delete the upload settings for a folder:
    library(synapser)
    synLogin()

    folder = Folder(id = "syn123") |> synGet()
    setting = folder |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        folder |> synDeleteProjectSetting(setting_id = setting$id)
    }
}
}
\keyword{Folder}

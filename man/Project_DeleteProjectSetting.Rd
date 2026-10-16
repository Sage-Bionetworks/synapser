\name{synDeleteProjectSetting}
\alias{Project_synDeleteProjectSetting}
\docType{methods}
\title{
Project :  delete_project_setting
}
\description{
Delete a project setting by its setting ID.
}
\usage{
synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
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
    # Delete the upload settings for a project:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        project |> synDeleteProjectSetting(setting_id = setting$id)
    }
}
}
\keyword{Project}

\name{synGetProjectSetting}
\alias{Project_synGetProjectSetting}
\docType{methods}
\title{
Project :  get_project_setting
}
\description{
Get the project setting for this entity.
}
\usage{
synGetProjectSetting(instance, setting_type="upload", synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{setting_type}{(character) The type of setting to retrieve. Currently only 'upload' is supported.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The ProjectSetting object, or NULL if no setting exists.
}
\section{Errors}{
Raises an error if the entity does not have an id set.
}
\examples{
\dontrun{
## Using this function
    # Get the upload settings for a project:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        print(sprintf("Storage locations: \%s", paste(unlist(setting$locations), collapse = ", ")))
    }
}
}
\keyword{Project}

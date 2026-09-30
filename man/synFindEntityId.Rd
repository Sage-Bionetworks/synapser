\name{synFindEntityId}
\alias{synFindEntityId}
\docType{methods}
\title{
synFindEntityId
}
\description{
Find an Entity given its name and parent.
}
\usage{
synFindEntityId(name, parent=NULL, synapse_client=NULL)
}
\arguments{
\item{name}{(str) Name of the entity to find.}
\item{parent}{(Optional[Union[str, Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable]]) An Entity object (Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable) or the Id of an entity as a string. Omit if searching for a Project by name.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The Entity ID or NULL if not found.
}
\examples{
\dontrun{
## Example 1: Finding a project by name
    # Find a project using only its name:
    library(synapser)
    synLogin()

    project_id = synFindEntityId(name = "My Project")
    if (!is.null(project_id)) {
        print(sprintf("Found project: \%s", project_id))
    } else {
        print("Project not found")
    }

## Example 2: Finding an entity within a parent
    # Find a file within a specific folder:
    library(synapser)
    synLogin()

    file_id = synFindEntityId(
        name = "my_data.csv",
        parent = "syn123456" # Parent folder ID
    )
    if (!is.null(file_id)) {
        print(sprintf("Found file: \%s", file_id))
    } else {
        print("File not found in folder")
    }

## Example 3: Using with entity objects
    # Find an entity using an entity object as the parent:
    library(synapser)
    synLogin()

    parent_folder = Folder(id = "syn123456")
    entity_id = synFindEntityId(
        name = "analysis_results.txt",
        parent = parent_folder
    )
    print(sprintf("Entity ID: \%s", entity_id))
}
}

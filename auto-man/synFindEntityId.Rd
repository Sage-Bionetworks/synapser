%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{parent}{(Optional[Union[str, ForwardRef('Dataset'), ForwardRef('DatasetCollection'), ForwardRef('EntityView'), ForwardRef('File'), ForwardRef('Folder'), ForwardRef('Link'), ForwardRef('MaterializedView'), ForwardRef('Project'), ForwardRef('RecordSet'), ForwardRef('SubmissionView'), ForwardRef('Table'), ForwardRef('VirtualTable')]]) An Entity object (Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable) or the Id of an entity as a string. Omit if searching for a Project by name.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The Entity ID or None if not found.
}
\examples{
\dontrun{
## Example 1: Finding a project by name
    # Find a project using only its name:

    from synapseclient import Synapse
    from synapseclient.operations import find_entity_id

    syn = Synapse()
    syn.login()

    project_id = find_entity_id(name="My Project")
    if project_id:
        print(f"Found project: {project_id}")
    else:
        print("Project not found")

## Example 2: Finding an entity within a parent
    # Find a file within a specific folder:

    from synapseclient import Synapse
    from synapseclient.operations import find_entity_id

    syn = Synapse()
    syn.login()

    file_id = find_entity_id(
        name="my_data.csv",
        parent="syn123456"  # Parent folder ID
    )
    if file_id:
        print(f"Found file: {file_id}")
    else:
        print("File not found in folder")

## Example 3: Using with entity objects
    # Find an entity using an entity object as the parent:

    from synapseclient import Synapse
    from synapseclient.models import Folder
    from synapseclient.operations import find_entity_id

    syn = Synapse()
    syn.login()

    parent_folder = Folder(id="syn123456")
    entity_id = find_entity_id(
        name="analysis_results.txt",
        parent=parent_folder
    )
    print(f"Entity ID: {entity_id}")
}
}
\keyword{}

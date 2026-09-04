%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{
Factory method to store any Synapse entity.

This method serves as a unified interface for storing any type of Synapse entity.
It automatically applies the appropriate store logic based on the entity type and
the options provided.
}
\usage{
synStore(entity, parent=NULL, file_options=NULL, container_options=NULL, table_options=NULL, json_schema_options=NULL, grid_options=NULL, synapse_client=NULL)
}
\arguments{
\item{entity}{(Union[ForwardRef('AgentSession'), ForwardRef('CurationTask'), ForwardRef('Dataset'), ForwardRef('DatasetCollection'), ForwardRef('EntityView'), ForwardRef('Evaluation'), ForwardRef('File'), ForwardRef('Folder'), ForwardRef('FormData'), ForwardRef('FormGroup'), ForwardRef('Grid'), ForwardRef('JSONSchema'), ForwardRef('Link'), ForwardRef('MaterializedView'), ForwardRef('Project'), ForwardRef('RecordSet'), ForwardRef('SchemaOrganization'), ForwardRef('SubmissionView'), ForwardRef('Table'), ForwardRef('Team'), ForwardRef('VirtualTable')]) The entity instance to store. Must be one of the supported entity types.}
\item{parent}{(Optional[Union[ForwardRef('Folder'), ForwardRef('Project')]]) The parent folder or project to store the entity in. Only applicable for File, Folder, Link, and RecordSet entities. Ignored for other entity types.}
\item{file_options}{(Optional[StoreFileOptions]) File-specific configuration options. Only applies to File and RecordSet entities. Ignored for other entity types.}
\item{container_options}{(Optional[StoreContainerOptions]) Container-specific configuration options. Only applies to Project and Folder entities. Ignored for other entity types.}
\item{table_options}{(Optional[StoreTableOptions]) Table-specific configuration options. Only applies to Table-like entities (Table, Dataset, EntityView, MaterializedView, SubmissionView, VirtualTable, DatasetCollection). Ignored for other entity types.}
\item{json_schema_options}{(Optional[StoreJSONSchemaOptions]) JSONSchema-specific configuration options. Only applies to JSONSchema entities. Required for JSONSchema. Ignored for other entity types.}
\item{grid_options}{(Optional[StoreGridOptions]) Grid-specific configuration options. Only applies to Grid entities. Ignored for other entity types.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The stored Synapse entity model instance.
}
\section{Errors}{
ValueError: If the entity is not a supported type.
}
\examples{
\dontrun{
## Example 1: Storing a file
    # Store a file to Synapse:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    file = File(path="/path/to/file.txt", parent_id="syn123456")
    stored_file = store(file)
    print(f"Stored file: {stored_file.name} (ID: {stored_file.id})")

## Example 2: Storing a file with custom options
    # Store a file with custom options:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import store, StoreFileOptions

    syn = Synapse()
    syn.login()

    file = File(path="/path/to/file.txt", parent_id="syn123456")
    stored_file = store(
        file,
        file_options=StoreFileOptions(
            synapse_store=True,
            content_type="text/plain",
            merge_existing_annotations=True
        )
    )
    print(f"Stored file: {stored_file.name}")

## Example 3: Storing a folder
    # Store a folder to Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Folder
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    folder = Folder(name="My Folder", parent_id="syn123456")
    stored_folder = store(folder)
    print(f"Stored folder: {stored_folder.name} (ID: {stored_folder.id})")

## Example 4: Storing a project
    # Store a project to Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Project
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    project = Project(name="My Project")
    stored_project = store(project)
    print(f"Stored project: {stored_project.name} (ID: {stored_project.id})")

## Example 5: Storing a table
    # Store a table to Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Table, Column, ColumnType
    from synapseclient.operations import store, StoreTableOptions

    syn = Synapse()
    syn.login()

    table = Table(
        name="My Table",
        parent_id="syn123456",
        columns=[Column(name="col1", column_type=ColumnType.STRING, maximum_size=50)]
    )
    stored_table = store(
        table,
        table_options=StoreTableOptions(dry_run=False, job_timeout=600)
    )
    print(f"Stored table: {stored_table.name} (ID: {stored_table.id})")

## Example 6: Storing a link
    # Store a link to Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Link
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    link = Link(name="My Link", parent_id="syn123456", target_id="syn789")
    stored_link = store(link)
    print(f"Stored link: {stored_link.name} (ID: {stored_link.id})")

## Example 7: Storing with parent parameter
    # Store an entity by passing the parent as a parameter:

    from synapseclient import Synapse
    from synapseclient.models import File, Folder
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    parent_folder = Folder(id="syn123456")
    file = File(path="/path/to/file.txt")
    stored_file = store(file, parent=parent_folder)
    print(f"Stored file: {stored_file.name} in folder {parent_folder.id}")

## Example 8: Storing an Evaluation
    # Store an evaluation (challenge queue):

    from synapseclient import Synapse
    from synapseclient.models import Evaluation
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    evaluation = Evaluation(
        name="My Challenge Evaluation",
        description="Evaluation for my data challenge",
        content_source="syn123456"
    )
    stored_evaluation = store(evaluation)
    print(f"Stored evaluation: {stored_evaluation.name} (ID: {stored_evaluation.id})")

## Example 9: Creating a Team
    # Create a new team (note: Teams use create, not update):

    from synapseclient import Synapse
    from synapseclient.models import Team
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    team = Team(
        name="My Research Team",
        description="A team for collaborative research"
    )
    created_team = store(team)
    print(f"Created team: {created_team.name} (ID: {created_team.id})")

## Example 10: Storing a CurationTask
    # Store a curation task:

    from synapseclient import Synapse
    from synapseclient.models import CurationTask, FileBasedMetadataTaskProperties
    from synapseclient.operations import store

    syn = Synapse()
    syn.login()

    file_properties = FileBasedMetadataTaskProperties(
        upload_folder_id="syn1234567",
        file_view_id="syn2345678"
    )
    task = CurationTask(
        project_id="syn9876543",
        data_type="genomics_data",
        instructions="Upload your genomics files",
        task_properties=file_properties
    )
    stored_task = store(task)
    print(f"Stored curation task: {stored_task.task_id}")
}
}
\keyword{}

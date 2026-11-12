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
\item{entity}{(Union[AgentSession, CurationTask, Dataset, DatasetCollection, EntityView, Evaluation, File, Folder, FormData, FormGroup, Grid, JSONSchema, Link, MaterializedView, Project, RecordSet, Organization, SearchIndex, SubmissionView, Table, Team, VirtualTable]) The entity instance to store. Must be one of the supported entity types.}
\item{parent}{(Optional[Union[Folder, Project]]) The parent folder or project to store the entity in. Only applicable for File, Folder, Link, and RecordSet entities. Ignored for other entity types.}
\item{file_options}{(Optional[StoreFileOptions]) \code{\link{StoreFileOptions}} to apply. Only applies to File and RecordSet entities. Ignored for other entity types.}
\item{container_options}{(Optional[StoreContainerOptions]) \code{\link{StoreContainerOptions}} to apply. Only applies to Project and Folder entities. Ignored for other entity types.}
\item{table_options}{(Optional[StoreTableOptions]) \code{\link{StoreTableOptions}} to apply. Only applies to Table-like entities (Table, Dataset, EntityView, MaterializedView, SubmissionView, VirtualTable, DatasetCollection). Ignored for other entity types.}
\item{json_schema_options}{(Optional[StoreJSONSchemaOptions]) \code{\link{StoreJSONSchemaOptions}} to apply. Only applies to JSONSchema entities. Required for JSONSchema. Ignored for other entity types.}
\item{grid_options}{(Optional[StoreGridOptions]) \code{\link{StoreGridOptions}} to apply. Only applies to Grid entities. Ignored for other entity types.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\details{
For these model classes synStore calls the class's own \code{store} method instead of the factory, because the factory does not support them. Pass an instance as the first argument: Activity (with \code{parent}), StorageLocation, Submission, SubmissionStatus, WikiOrderHint, WikiPage.
}
\value{
The stored Synapse entity model instance.
}
\section{Errors}{
- An error is raised if the entity is not a supported type.
}
\examples{
\dontrun{
## Example 1: Storing a file
    # Store a file to Synapse:
    library(synapser)
    synLogin()

    file = File(path = "/path/to/file.txt", parent_id = "syn123456")
    stored_file = file |> synStore()
    print(sprintf("Stored file: \%s (ID: \%s)", stored_file$name, stored_file$id))

## Example 2: Storing a file with custom options
    # Store a file with custom options:
    library(synapser)
    synLogin()

    file = File(path = "/path/to/file.txt", parent_id = "syn123456")
    stored_file = file |> synStore(
        file_options = StoreFileOptions(
            synapse_store = TRUE,
            content_type = "text/plain",
            merge_existing_annotations = TRUE
        )
    )
    print(sprintf("Stored file: \%s", stored_file$name))

## Example 3: Storing a folder
    # Store a folder to Synapse:
    library(synapser)
    synLogin()

    folder = Folder(name = "My Folder", parent_id = "syn123456")
    stored_folder = folder |> synStore()
    print(sprintf("Stored folder: \%s (ID: \%s)", stored_folder$name, stored_folder$id))

## Example 4: Storing a project
    # Store a project to Synapse:
    library(synapser)
    synLogin()

    project = Project(name = "My Project")
    stored_project = project |> synStore()
    print(sprintf("Stored project: \%s (ID: \%s)", stored_project$name, stored_project$id))

## Example 5: Storing a table
    # Store a table to Synapse:
    library(synapser)
    synLogin()

    table = Table(
        name = "My Table",
        parent_id = "syn123456",
        columns = list(Column(name = "col1", column_type = "STRING", maximum_size = 50L))
    )
    stored_table = table |> synStore(
        table_options = StoreTableOptions(dry_run = FALSE, job_timeout = 600L)
    )
    print(sprintf("Stored table: \%s (ID: \%s)", stored_table$name, stored_table$id))

## Example 6: Storing a link
    # Store a link to Synapse:
    library(synapser)
    synLogin()

    link = Link(name = "My Link", parent_id = "syn123456", target_id = "syn789")
    stored_link = link |> synStore()
    print(sprintf("Stored link: \%s (ID: \%s)", stored_link$name, stored_link$id))

## Example 7: Storing with parent parameter
    # Store an entity by passing the parent as a parameter:
    library(synapser)
    synLogin()

    parent_folder = Folder(id = "syn123456")
    file = File(path = "/path/to/file.txt")
    stored_file = file |> synStore(parent = parent_folder)
    print(sprintf("Stored file: \%s in folder \%s", stored_file$name, parent_folder$id))

## Example 8: Storing an Evaluation
    # Store an evaluation (challenge queue):
    library(synapser)
    synLogin()

    evaluation = Evaluation(
        name = "My Challenge Evaluation",
        description = "Evaluation for my data challenge",
        content_source = "syn123456"
    )
    stored_evaluation = evaluation |> synStore()
    print(sprintf("Stored evaluation: \%s (ID: \%s)", stored_evaluation$name, stored_evaluation$id))

## Example 9: Creating a Team
    # Create a new team (note: Teams use create, not update):
    library(synapser)
    synLogin()

    team = Team(
        name = "My Research Team",
        description = "A team for collaborative research"
    )
    created_team = team |> synStore()
    print(sprintf("Created team: \%s (ID: \%s)", created_team$name, created_team$id))

## Example 10: Storing an Activity
    # Record the provenance of a file. Storing the Activity with a parent
    # associates it with that entity:
    library(synapser)
    synLogin()

    file = synGet("syn123", file_options = FileOptions(download_file = FALSE))

    activity = Activity(
        name = "Normalization",
        description = "Normalized the raw counts",
        used = list(
            UsedEntity(target_id = "syn456", target_version_number = 1L),
            UsedURL(name = "Reference genome", url = "https://www.ncbi.nlm.nih.gov/grc/human")
        ),
        executed = list(
            UsedURL(name = "Analysis code", url = "https://github.com/my-org/my-analysis")
        )
    )
    stored_activity = activity |> synStore(parent = file)
    print(sprintf("Stored activity: \%s (ID: \%s)", stored_activity$name, stored_activity$id))

## Example 11: Storing a StorageLocation
    # Create a storage location backed by your own S3 bucket. Storage locations
    # are immutable, so this always creates a new one (or returns an identical
    # existing one):
    library(synapser)
    synLogin()

    storage = StorageLocation(
        storage_type = StorageLocationType(
            name = "EXTERNAL_S3",
            concrete_type = "ExternalS3StorageLocationSetting"
        ),
        bucket = "my-external-synapse-bucket",
        base_key = "path/within/bucket"
    ) |> synStore()
    print(sprintf("Storage location ID: \%s", storage$storage_location_id))

## Example 12: Storing a Submission
    # Submit an entity to an evaluation queue:
    library(synapser)
    synLogin()

    submission = Submission(
        entity_id = "syn123456",
        evaluation_id = "9999999",
        name = "My Submission"
    )
    stored_submission = submission |> synStore()
    print(sprintf("Created submission with ID: \%s", stored_submission$id))

## Example 13: Storing a SubmissionStatus
    # Retrieve an existing submission status, update its fields, and store the changes:
    library(synapser)
    synLogin()

    status = SubmissionStatus(id = "9999999") |> synGet()
    status$status = "SCORED"
    status$submission_annotations = list(score = list(85.5))
    status = status |> synStore()
    print(sprintf("Updated status: \%s", status$status))

## Example 14: Storing a WikiPage
    # Create a wiki page on a project. Pass parent_id to create a subwiki page
    # under an existing wiki page:
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    wiki_page = WikiPage(owner_id = project$id, title = "My wiki page", markdown = "## My wiki page") |> synStore()
    print(sprintf("Stored wiki page: \%s (ID: \%s)", wiki_page$title, wiki_page$id))

    sub_wiki_page = WikiPage(
        owner_id = project$id,
        title = "My subwiki page",
        parent_id = wiki_page$id,
        markdown = "## My subwiki page"
    ) |> synStore()
}
}

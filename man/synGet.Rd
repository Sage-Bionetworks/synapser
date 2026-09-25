\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{
Factory method to retrieve any Synapse entity by its ID or by name and parent ID.

This method serves as a unified interface for retrieving any type of Synapse entity
without needing to know the specific entity type beforehand. It automatically
determines the entity type and returns the appropriate model instance.

You can retrieve entities in two ways:

1. By providing a synapse_id directly\cr
2. By providing entity_name and optionally parent_id for lookup
}
\usage{
synGet(synapse_id=NULL, entity_name=NULL, parent_id=NULL, version_number=NULL, activity_options=NULL, file_options=NULL, table_options=NULL, link_options=NULL, synapse_client=NULL)
}
\arguments{
\item{synapse_id}{(Optional[str]) The Synapse ID of the entity to retrieve (e.g., 'syn123456'). Mutually exclusive with entity_name.}
\item{entity_name}{(Optional[str]) The name of the entity to find. Must be used with this approach instead of synapse_id. When looking up projects, parent_id should be NULL.}
\item{parent_id}{(Optional[str]) The parent entity ID when looking up by name. Set to NULL when looking up projects by name. Only used with entity_name.}
\item{version_number}{(Optional[int]) The specific version number of the entity to retrieve. Only applies to versionable entities (File, Table, Dataset). If not specified, the most recent version will be retrieved. Ignored for other entity types.}
\item{activity_options}{(Optional[ActivityOptions]) Activity-specific configuration options. Can be applied to any entity type to include activity information.}
\item{file_options}{(Optional[FileOptions]) File-specific configuration options. Only applies to File entities. Ignored for other entity types.}
\item{table_options}{(Optional[TableOptions]) Table-specific configuration options. Only applies to Table-like entities (Table, Dataset, EntityView, MaterializedView, SubmissionView, VirtualTable, DatasetCollection). Ignored for other entity types.}
\item{link_options}{(Optional[LinkOptions]) Link-specific configuration options. Only applies when the entity is a Link. Ignored for other entity types.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The appropriate Synapse entity model instance based on the entity type.
}
\section{Errors}{
- An error is raised if both synapse_id and entity_name are provided, or if neither is provided.\cr
- An error is raised if entity_name is provided without this being a valid lookup scenario.\cr
- An error is raised if the synapse_id is not a valid Synapse ID format.
}
\note{
When using entity_name lookup:

- For projects: leave parent_id = NULL.\cr
- For all other entities: provide the parent_id of the containing folder/project.
}
\examples{
\dontrun{
## Example 1: Retrieving entities by ID
    # Get any entity by Synapse ID:
    library(synapser)
    synLogin()

    # Works for any entity type
    entity = synGet(synapse_id = "syn123456")

    # The returned object will be the appropriate type
    if (inherits(entity, "File")) {
        print(sprintf("File: \%s", entity$name))
    } else if (inherits(entity, "Project")) {
        print(sprintf("Project: \%s", entity$name))
    }

## Example 2: Retrieving entities by name
    # Get an entity by name and parent:
    library(synapser)
    synLogin()

    # Get a file by name within a folder
    entity = synGet(
        entity_name = "my_file.txt",
        parent_id = "syn123456"
    )

    # Get a project by name (parent_id = NULL)
    project = synGet(
        entity_name = "My Project",
        parent_id = NULL
    )

## Example 3: Retrieving a specific version
    # Get a specific version of a versionable entity:
    library(synapser)
    synLogin()

    entity = synGet(synapse_id = "syn123456", version_number = 2L)

## Example 4: Retrieving a file with custom options
    # Get file metadata with specific download options:
    library(synapser)
    synLogin()

    file_entity = synGet(
        synapse_id = "syn123456",
        activity_options = ActivityOptions(include_activity = TRUE),
        file_options = FileOptions(
            download_file = FALSE
        )
    )

## Example 5: Retrieving a table with activity and columns
    # Get table with activity and column information:
    library(synapser)
    synLogin()

    table_entity = synGet(
        synapse_id = "syn123456",
        activity_options = ActivityOptions(include_activity = TRUE),
        table_options = TableOptions(include_columns = TRUE)
    )

## Example 6: Following links
    # Get the target of a link entity:
    library(synapser)
    synLogin()

    target_entity = synGet(
        synapse_id = "syn123456",
        link_options = LinkOptions(follow_link = TRUE)
    )

## Example 7: Working with Link entities
    # Get a Link entity without following it:
    library(synapser)
    synLogin()

    # Get the link entity itself
    link_entity = synGet(
        synapse_id = "syn123456", # Example link ID
        link_options = LinkOptions(follow_link = FALSE)
    )
    print(sprintf("Link: \%s -> \%s", link_entity$name, link_entity$target_id))

    # Then follow the link to get the target
    target_entity = synGet(
        synapse_id = "syn123456",
        link_options = LinkOptions(follow_link = TRUE)
    )
    print(sprintf("Target: \%s (type: \%s)", target_entity$name, class(target_entity)[1]))

## Example 8: Comprehensive File options
    # Download file with custom location and collision handling:
    library(synapser)
    synLogin()

    file_entity = synGet(
        synapse_id = "syn123456",
        file_options = FileOptions(
            download_file = TRUE,
            download_location = "/path/to/download/",
            if_collision = "overwrite.local"
        )
    )
    print(sprintf("Downloaded file: \%s to \%s", file_entity$name, file_entity$path))

## Example 9: Table options for table-like entities
    # Get table entities with column information:
    library(synapser)
    synLogin()

    # Works for Table, Dataset, EntityView, MaterializedView,
    # SubmissionView, VirtualTable, and DatasetCollection
    table_entity = synGet(
        synapse_id = "syn123456", # Example table ID
        table_options = TableOptions(include_columns = TRUE)
    )
    print(sprintf("Table: \%s with \%d columns", table_entity$name, length(table_entity$columns)))

## Example 10: Combining multiple options
    # Get a File with both activity and custom download options:
    library(synapser)
    synLogin()

    file_entity = synGet(
        synapse_id = "syn123456",
        activity_options = ActivityOptions(include_activity = TRUE),
        file_options = FileOptions(
            download_file = FALSE
        )
    )
    print(sprintf("File: \%s (activity included: \%s)", file_entity$name, !is.null(file_entity$activity)))

## Example 11: Working with entity instances
    # Pass an existing entity instance to refresh or apply new options:
    library(synapser)
    synLogin()

    # Get an entity first
    entity = synGet(synapse_id = "syn123456")
    print(sprintf("Original entity: \%s", entity$name))

    # Then use the entity instance to get it again with different options
    refreshed_entity = entity |> synGet(file_options = FileOptions(download_file = FALSE))
    print(sprintf("Refreshed entity: \%s (download_file: \%s)", refreshed_entity$name, refreshed_entity$download_file))
}
}

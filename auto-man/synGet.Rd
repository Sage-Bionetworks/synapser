%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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

1. By providing a synapse_id directly
2. By providing entity_name and optionally parent_id for lookup
}
\usage{
synGet(synapse_id=NULL, entity_name=NULL, parent_id=NULL, version_number=NULL, activity_options=NULL, file_options=NULL, table_options=NULL, link_options=NULL, synapse_client=NULL)
}
\arguments{
\item{synapse_id}{(Optional[str]) The Synapse ID of the entity to retrieve (e.g., 'syn123456'). Mutually exclusive with entity_name.}
\item{entity_name}{(Optional[str]) The name of the entity to find. Must be used with this approach instead of synapse_id. When looking up projects, parent_id should be None.}
\item{parent_id}{(Optional[str]) The parent entity ID when looking up by name. Set to None when looking up projects by name. Only used with entity_name.}
\item{version_number}{(Optional[int]) The specific version number of the entity to retrieve. Only applies to versionable entities (File, Table, Dataset). If not specified, the most recent version will be retrieved. Ignored for other entity types.}
\item{activity_options}{(Optional[ActivityOptions]) Activity-specific configuration options. Can be applied to any entity type to include activity information.}
\item{file_options}{(Optional[FileOptions]) File-specific configuration options. Only applies to File entities. Ignored for other entity types.}
\item{table_options}{(Optional[TableOptions]) Table-specific configuration options. Only applies to Table-like entities (Table, Dataset, EntityView, MaterializedView, SubmissionView, VirtualTable, DatasetCollection). Ignored for other entity types.}
\item{link_options}{(Optional[LinkOptions]) Link-specific configuration options. Only applies when the entity is a Link. Ignored for other entity types.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The appropriate Synapse entity model instance based on the entity type.
}
\section{Errors}{
ValueError: If both synapse_id and entity_name are provided, or if neither is provided.
    ValueError: If entity_name is provided without this being a valid lookup scenario.
    ValueError: If the synapse_id is not a valid Synapse ID format.
}
\note{
When using entity_name lookup:

    - For projects: leave parent_id=None
    - For all other entities: provide the parent_id of the containing folder/project
}
\examples{
\dontrun{
## Example 1: Retrieving entities by ID
    # Get any entity by Synapse ID:

    from synapseclient import Synapse
    from synapseclient.models import File, Project
    from synapseclient.operations import get

    syn = Synapse()
    syn.login()

    # Works for any entity type
    entity = get(synapse_id="syn123456")

    # The returned object will be the appropriate type
    if isinstance(entity, File):
        print(f"File: {entity.name}")
    elif isinstance(entity, Project):
        print(f"Project: {entity.name}")

## Example 2: Retrieving entities by name
    # Get an entity by name and parent:

    from synapseclient import Synapse
    from synapseclient.operations import get

    syn = Synapse()
    syn.login()

    # Get a file by name within a folder
    entity = get(
        entity_name="my_file.txt",
        parent_id="syn123456"
    )

    # Get a project by name (parent_id=None)
    project = get(
        entity_name="My Project",
        parent_id=None
    )

## Example 3: Retrieving a specific version
    # Get a specific version of a versionable entity:

    from synapseclient import Synapse
    from synapseclient.operations import get

    syn = Synapse()
    syn.login()

    entity = get(synapse_id="syn123456", version_number=2)

## Example 4: Retrieving a file with custom options
    # Get file metadata with specific download options:

    from synapseclient import Synapse
    from synapseclient.operations import get, FileOptions, ActivityOptions

    syn = Synapse()
    syn.login()

    file_entity = get(
        synapse_id="syn123456",
        activity_options=ActivityOptions(include_activity=True),
        file_options=FileOptions(
            download_file=False
        )
    )

## Example 5: Retrieving a table with activity and columns
    # Get table with activity and column information:

    from synapseclient import Synapse
    from synapseclient.operations import get, ActivityOptions, TableOptions

    syn = Synapse()
    syn.login()

    table_entity = get(
        synapse_id="syn123456",
        activity_options=ActivityOptions(include_activity=True),
        table_options=TableOptions(include_columns=True)
    )

## Example 6: Following links
    # Get the target of a link entity:

    from synapseclient import Synapse
    from synapseclient.operations import get, LinkOptions

    syn = Synapse()
    syn.login()

    target_entity = get(
        synapse_id="syn123456",
        link_options=LinkOptions(follow_link=True)
    )

## Example 7: Working with Link entities
    # Get a Link entity without following it:

    from synapseclient import Synapse
    from synapseclient.operations import get, LinkOptions

    syn = Synapse()
    syn.login()

    # Get the link entity itself
    link_entity = get(
        synapse_id="syn123456",  # Example link ID
        link_options=LinkOptions(follow_link=False)
    )
    print(f"Link: {link_entity.name} -> {link_entity.target_id}")

    # Then follow the link to get the target
    target_entity = get(
        synapse_id="syn123456",
        link_options=LinkOptions(follow_link=True)
    )
    print(f"Target: {target_entity.name} (type: {type(target_entity).__name__})")

## Example 8: Comprehensive File options
    # Download file with custom location and collision handling:

    from synapseclient import Synapse
    from synapseclient.operations import get, FileOptions

    syn = Synapse()
    syn.login()

    file_entity = get(
        synapse_id="syn123456",
        file_options=FileOptions(
            download_file=True,
            download_location="/path/to/download/",
            if_collision="overwrite.local"
        )
    )
    print(f"Downloaded file: {file_entity.name} to {file_entity.path}")

## Example 9: Table options for table-like entities
    # Get table entities with column information:

    from synapseclient import Synapse
    from synapseclient.operations import get, TableOptions

    syn = Synapse()
    syn.login()

    # Works for Table, Dataset, EntityView, MaterializedView,
    # SubmissionView, VirtualTable, and DatasetCollection
    table_entity = get(
        synapse_id="syn123456",  # Example table ID
        table_options=TableOptions(include_columns=True)
    )
    print(f"Table: {table_entity.name} with {len(table_entity.columns)} columns")

## Example 10: Combining multiple options
    # Get a File with both activity and custom download options:

    from synapseclient import Synapse
    from synapseclient.operations import get, FileOptions, ActivityOptions

    syn = Synapse()
    syn.login()

    file_entity = get(
        synapse_id="syn123456",
        activity_options=ActivityOptions(include_activity=True),
        file_options=FileOptions(
            download_file=False
        )
    )
    print(f"File: {file_entity.name} (activity included: {file_entity.activity is not None})")

## Example 11: Working with entity instances
    # Pass an existing entity instance to refresh or apply new options:

    from synapseclient import Synapse
    from synapseclient.operations import get, FileOptions

    syn = Synapse()
    syn.login()

    # Get an entity first
    entity = get(synapse_id="syn123456")
    print(f"Original entity: {entity.name}")

    # Then use the entity instance to get it again with different options
    refreshed_entity = get(
        entity,
        file_options=FileOptions(download_file=False)
    )
    print(f"Refreshed entity: {refreshed_entity.name} (download_file: {refreshed_entity.download_file})")
}
}
\keyword{}

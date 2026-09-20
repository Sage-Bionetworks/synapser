%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSyncFromSynapse}
\alias{Folder_synSyncFromSynapse}
\docType{methods}
\title{
Folder :  sync_from_synapse
}
\description{
Sync this container and all possible sub-folders from Synapse. By default this
will download the files that are found and it will populate the
\code{files} and \code{folders} attributes with the found files and folders, along with
all other entity types (tables, entityviews, etc.) present in the container.
If you only want to retrieve the full tree of metadata about your
container specify \code{download_file} as False.

This works similar to \code{\link[=synSyncFromSynapse]{synSyncFromSynapse}}, however, this does not
currently support the writing of data to a manifest TSV file. This will be a
future enhancement.

Supports syncing Files, Folders, Tables, EntityViews, SubmissionViews, Datasets,
DatasetCollections, MaterializedViews, and VirtualTables from Synapse. The
metadata for these entity types will be populated in their respective
attributes (\code{files}, \code{folders}, \code{tables}, \code{entityviews}, \code{submissionviews},
\code{datasets}, \code{datasetcollections}, \code{materializedviews}, \code{virtualtables}) if
they are found within the container.
}
\usage{
synSyncFromSynapse(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy=FailureStrategy.LOG_EXCEPTION, include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{path}{(Optional[str]) An optional path where the file hierarchy will be reproduced. If not specified the files will by default be placed in the synapseCache.}
\item{recursive}{(bool) Whether or not to recursively get the entire hierarchy of the folder and sub-folders.}
\item{download_file}{(bool) Whether to download the files found or not.}
\item{if_collision}{(str) Determines how to handle file collisions. May be\cr
\cr
- \code{overwrite.local} - \code{keep.local} - \code{keep.both}}
\item{failure_strategy}{(FailureStrategy) Determines how to handle failures when retrieving children under this Folder and an exception occurs.}
\item{include_activity}{(bool) Whether to include the activity of the files.}
\item{follow_link}{(bool) Whether to follow a link entity or not. Links can be used to point at other Synapse entities.}
\item{link_hops}{(int) The number of hops to follow the link. A number of 1 is used to prevent circular references. There is nothing in place to prevent infinite loops. Be careful if setting this above 1.}
\item{queue}{(Queue) An optional queue to use to download files in parallel.}
\item{include_types}{(Optional[list[str]]) Must be a list of entity types (ie. ["folder","file"]) which can be found \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html}{here}. Defaults to \code{["folder", "file", "table", "entityview", "dockerrepo", "submissionview", "dataset", "datasetcollection", "materializedview", "virtualtable"]}.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The object that was called on. This will be the same object that was called on
        to start the sync.
}
\section{Errors}{
ValueError: If the folder does not have an id set.


A sequence diagram for this method is as follows:

``\code{mermaid
sequenceDiagram
    autonumber
    participant project_or_folder
    activate project_or_folder
    project_or_folder->>sync_from_synapse: Recursive search and download files
    activate sync_from_synapse
        opt Current instance not retrieved from Synapse
            sync_from_synapse->>project_or_folder: Call }.get()\code{ method
            project_or_folder-->>sync_from_synapse: .
        end

        loop For each return of the generator
            sync_from_synapse->>client: call }.getChildren()\code{ method
            client-->>sync_from_synapse: .
            note over sync_from_synapse: Append to a running list
        end

        loop For each child
            note over sync_from_synapse: Create all }pending_tasks\code{ at current depth

            alt Child is File
                note over sync_from_synapse: Append }file.get()\code{ method
            else Child is Folder
                note over sync_from_synapse: Append }folder.get()\code{ method
                alt Recursive is True
                    note over sync_from_synapse: Append }folder.sync_from_synapse()\code{ method
                end
            else Child is Link and hops > 0
                note over sync_from_synapse: Append task to follow link
            end
        end

        loop For each task in pending_tasks
            par }file.get()\code{
                sync_from_synapse->>File: Retrieve File metadata and Optionally download
                File->>client: }.get()\code{
                client-->>File: .
                File-->>sync_from_synapse: .
            and }folder.get()\code{
                sync_from_synapse->>Folder: Retrieve Folder metadataa
                Folder->>client: }.get()\code{
                client-->>Folder: .
                Folder-->>sync_from_synapse: .
            and }folder.sync_from_synapse_async()\code{
                note over sync_from_synapse: This is a recursive call to }sync_from_synapse\code{
                sync_from_synapse->>sync_from_synapse: Recursive call to }.sync_from_synapse_async()\code{
            and }_follow_link\code{
                sync_from_synapse ->>client: call }get_entity_id_bundle2\code{ function
                client-->sync_from_synapse: .
                note over sync_from_synapse: Do nothing if not link
                note over sync_from_synapse: call }_create_task_for_child\code{ and execute
            end
        end

    deactivate sync_from_synapse
    deactivate project_or_folder
}``
}
\examples{
\dontrun{
## Using this function
    # Suppose I want to walk the immediate children of a folder without downloading the files:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Folder

    async def my_function():
        syn = Synapse()
        syn.login()

        my_folder = Folder(id="syn12345")
        await my_folder.sync_from_synapse_async(download_file=False, recursive=False)

        for folder in my_folder.folders:
            print(folder.name)

        for file in my_folder.files:
            print(file.name)

        for table in my_folder.tables:
            print(table.name)

        for dataset in my_folder.datasets:
            print(dataset.name)

    asyncio.run(my_function())

    Suppose I want to download the immediate children of a folder:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Folder

    async def my_function():
        syn = Synapse()
        syn.login()

        my_folder = Folder(id="syn12345")
        await my_folder.sync_from_synapse_async(path="/path/to/folder", recursive=False)

        for folder in my_folder.folders:
            print(folder.name)

        for file in my_folder.files:
            print(file.name)

    asyncio.run(my_function())

    Suppose I want to sync only specific entity types from a Project:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Project

    async def my_function():
        syn = Synapse()
        syn.login()

        my_project = Project(id="syn12345")
        await my_project.sync_from_synapse_async(
            path="/path/to/folder",
            include_types=["folder", "file", "table", "dataset"]
        )

        # Access different entity types
        for table in my_project.tables:
            print(f"Table: {table.name}")

        for dataset in my_project.datasets:
            print(f"Dataset: {dataset.name}")

    asyncio.run(my_function())

    Suppose I want to download all the children of a Project and all sub-folders and files:

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Project

    async def my_function():
        syn = Synapse()
        syn.login()

        my_project = Project(id="syn12345")
        await my_project.sync_from_synapse_async(path="/path/to/folder")

    asyncio.run(my_function())
}
}
\keyword{Folder}

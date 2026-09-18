%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSyncFromSynapse}
\alias{synSyncFromSynapse}
\docType{methods}
\title{
Project :  sync_from_synapse
}
\description{
Sync this container and all possible sub-folders from Synapse. By default this
will download the files that are found and it will populate the
\code{files} and \code{folders} attributes with the found files and folders, along with
all other entity types (tables, entityviews, etc.) present in the container.
If you only want to retrieve the full tree of metadata about your
container specify \code{download_file} as FALSE.

This works similarly to the legacy \href{https://python-docs.synapse.org/reference/synapse_utils/}{synapseutils.syncFromSynapse} utility function, however, this does not
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
synSyncFromSynapse(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy="LOG_EXCEPTION", include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{path}{(Optional[str]) An optional path where the file hierarchy will be reproduced. If not specified the files will by default be placed in the synapseCache.}
\item{recursive}{(bool) Whether or not to recursively get the entire hierarchy of the folder and sub-folders.}
\item{download_file}{(bool) Whether to download the files found or not.}
\item{if_collision}{(str) Determines how to handle file collisions. May be:\cr
\cr
- \code{overwrite.local}\cr
- \code{keep.local}\cr
- \code{keep.both}}
\item{failure_strategy}{(str) Determines how to handle failures when retrieving children under this Folder and an exception occurs. One of \code{"LOG_EXCEPTION"} or \code{"RAISE_EXCEPTION"}.}
\item{include_activity}{(bool) Whether to include the activity of the files.}
\item{follow_link}{(bool) Whether to follow a link entity or not. Links can be used to point at other Synapse entities.}
\item{link_hops}{(int) The number of hops to follow the link. A number of 1 is used to prevent circular references. There is nothing in place to prevent infinite loops. Be careful if setting this above 1.}
\item{queue}{(Queue) An optional queue to use to download files in parallel.}
\item{include_types}{(Optional[list[str]]) Must be a list of entity types (ie. list("folder", "file")) which can be found \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html}{here}. Defaults to \code{list("folder", "file", "table", "entityview", "dockerrepo", "submissionview", "dataset", "datasetcollection", "materializedview", "virtualtable")}.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The object that was called on. This will be the same object that was called on to start the sync.
}
\section{Errors}{
An error is raised if the folder does not have an id set.

A sequence diagram for this method is as follows:

\preformatted{
sequenceDiagram
    autonumber
    participant project_or_folder
    activate project_or_folder
    project_or_folder->>sync_from_synapse: Recursive search and download files
    activate sync_from_synapse
        opt Current instance not retrieved from Synapse
            sync_from_synapse->>project_or_folder: Call .get() method
            project_or_folder-->>sync_from_synapse: .
        end

        loop For each return of the generator
            sync_from_synapse->>client: call .getChildren() method
            client-->>sync_from_synapse: .
            note over sync_from_synapse: Append to a running list
        end

        loop For each child
            note over sync_from_synapse: Create all pending_tasks at current depth

            alt Child is File
                note over sync_from_synapse: Append file.get() method
            else Child is Folder
                note over sync_from_synapse: Append folder.get() method
                alt Recursive is True
                    note over sync_from_synapse: Append folder.sync_from_synapse() method
                end
            else Child is Link and hops > 0
                note over sync_from_synapse: Append task to follow link
            end
        end

        loop For each task in pending_tasks
            par file.get()
                sync_from_synapse->>File: Retrieve File metadata and Optionally download
                File->>client: .get()
                client-->>File: .
                File-->>sync_from_synapse: .
            and folder.get()
                sync_from_synapse->>Folder: Retrieve Folder metadata
                Folder->>client: .get()
                client-->>Folder: .
                Folder-->>sync_from_synapse: .
            and folder.sync_from_synapse_async()
                note over sync_from_synapse: This is a recursive call to sync_from_synapse
                sync_from_synapse->>sync_from_synapse: Recursive call to .sync_from_synapse_async()
            and _follow_link
                sync_from_synapse ->>client: call get_entity_id_bundle2 function
                client-->sync_from_synapse: .
                note over sync_from_synapse: Do nothing if not link
                note over sync_from_synapse: call _create_task_for_child and execute
            end
        end

    deactivate sync_from_synapse
    deactivate project_or_folder
}
}
\examples{
\dontrun{
## Using this function
    # Suppose I want to walk the immediate children of a folder without downloading the files:
    library(synapser)
    synLogin()

    my_folder = Folder(id = "syn12345")
    my_folder = my_folder |> synSyncFromSynapse(download_file = FALSE, recursive = FALSE)

    for (folder in my_folder$folders) {
        cat(folder$name, "\n")
    }

    for (file in my_folder$files) {
        cat(file$name, "\n")
    }

    for (table in my_folder$tables) {
        cat(table$name, "\n")
    }

    for (dataset in my_folder$datasets) {
        cat(dataset$name, "\n")
    }

    # Suppose I want to download the immediate children of a folder:
    my_folder = Folder(id = "syn12345")
    my_folder = my_folder |> synSyncFromSynapse(path = "/path/to/folder", recursive = FALSE)

    for (folder in my_folder$folders) {
        cat(folder$name, "\n")
    }

    for (file in my_folder$files) {
        cat(file$name, "\n")
    }

    # Suppose I want to sync only specific entity types from a Project:
    my_project = Project(id = "syn12345")
    my_project = my_project |> synSyncFromSynapse(
        path = "/path/to/folder",
        include_types = list("folder", "file", "table", "dataset")
    )

    # Access different entity types
    for (table in my_project$tables) {
        cat(sprintf("Table: \%s\n", table$name))
    }

    for (dataset in my_project$datasets) {
        cat(sprintf("Dataset: \%s\n", dataset$name))
    }

    # Suppose I want to download all the children of a Project and all sub-folders and files:
    my_project = Project(id = "syn12345")
    my_project = my_project |> synSyncFromSynapse(path = "/path/to/folder")
}
}
\keyword{Project}

\name{synWalk}
\alias{Folder_synWalk}
\docType{methods}
\title{
Folder :  walk
}
\description{
Traverse through the hierarchy of entities stored under this container.
Mimics \code{os.walk()} behavior but yields EntityHeader objects, with optional
ASCII tree display that continues printing as the walk progresses.
}
\usage{
synWalk(instance, follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{follow_link}{(bool) Whether to follow a link entity or not. Links can be used to point at other Synapse entities.}
\item{include_types}{(Optional[list[str]]) Must be a list of entity types (ie. list("folder", "file")) which can be found \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html}{here}. Defaults to \code{list("folder", "file", "table", "entityview", "dockerrepo", "submissionview", "dataset", "datasetcollection", "materializedview", "virtualtable", "searchindex")}. The "folder" type is always included so the hierarchy can be traversed.}
\item{recursive}{(bool) Whether to recursively traverse subdirectories. Defaults to TRUE.}
\item{display_ascii_tree}{(bool) If TRUE, display an ASCII tree representation as the container structure is traversed. Tree lines are printed incrementally as each container is visited. Defaults to FALSE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields a list of \code{(dirpath, dirs, nondirs)} where:\cr
- dirpath: A vector of \code{(directory_name, synapse_id)} representing the current directory\cr
- dirs: A list of EntityHeader objects for subdirectories (folders)\cr
- nondirs: A list of EntityHeader objects for non-directory entities (files, tables, etc.)

Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one result at a time.
}
\note{
Each EntityHeader contains complete metadata including id, name, type,
creation/modification dates, version information, and other Synapse properties.
The directory path is built using \code{os.path.join()} to create hierarchical paths,
like "my-container-name/bulk-upload/file_script_folder/file_script_sub_folder".

When display_ascii_tree=TRUE, the ASCII tree structure is displayed in proper
hierarchical order as the entire structure is traversed sequentially. The tree
will be printed in the correct parent-child relationships, but results will still
be yielded as expected during the traversal process. The tree is printed
progressively as each container is visited during the walk, making it suitable
for very large and deeply nested structures.
}
\examples{
\dontrun{
## Example 1: Traverse all entities in a container
    # Basic usage - traverse all entities in a container
    library(synapser)
    synLogin()

    container = Folder(id = "syn12345")
    for (entry in as.list(container |> synWalk())) {
        dirpath = entry[[1]]
        dirs = entry[[2]]
        nondirs = entry[[3]]
        cat(sprintf("Directory: \%s (\%s)\n", dirpath[[1]], dirpath[[2]]))

        # Print folders
        for (folder_entity in dirs) {
            cat(sprintf("  Folder: \%s\n", folder_entity))
        }

        # Print files and other entities
        for (entity in nondirs) {
            cat(sprintf("  File: \%s\n", entity))
        }
    }

## Example 2: Display progressive ASCII tree as walk proceeds
    library(synapser)
    synLogin()

    container = Folder(id = "syn12345")
    # Display tree structure progressively as walk proceeds
    for (entry in as.list(container |> synWalk(display_ascii_tree = TRUE))) {
        dirpath = entry[[1]]
        nondirs = entry[[3]]
        # Process each directory as usual
        cat(sprintf("Processing: \%s\n", dirpath[[1]]))
        for (file_entity in nondirs) {
            cat(sprintf("  Found file: \%s\n", file_entity$name))
        }
    }

    # Example output:
    #
    # === Container Structure ===
    # 📂  my-container-name (syn52948289) [Project]
    # ├── 📁  bulk-upload (syn68884548) [Folder]
    # │   └── 📁  file_script_folder (syn68884547) [Folder]
    # │       └── 📁  file_script_sub_folder (syn68884549) [Folder]
    # │           └── 📄 file_in_a_sub_folder.txt (syn68884556) [File]
    # ├── 📁  root (syn67590143) [Folder]
    # │   └── 📁  subdir1 (syn67590144) [Folder]
    # │       ├── 📄 file1.txt (syn67590261) [File]
    # │       └── 📄 file2.txt (syn67590287) [File]
    # └── 📁  temp-files (syn68884954) [Folder]
    #     └── 📁  root (syn68884955) [Folder]
    #         └── 📁  subdir1 (syn68884956) [Folder]
    #             ├── 📄 file1.txt (syn68884959) [File]
    #             └── 📄 file2.txt (syn68884999) [File]
    #
    # Directory: My uniquely named project about Alzheimer's Disease (syn53185532)
    #   File: EntityHeader(name = "Gene Expression Data", id = "syn66227753",
    #     type = "org.sagebionetworks.repo.model.table.TableEntity", version_number = 1,
    #     version_label = "in progress", is_latest_version = TRUE, benefactor_id = 53185532,
    #     created_on = "2025-04-11T21:24:28.913Z", modified_on = "2025-04-11T21:24:34.996Z",
    #     created_by = "3481671", modified_by = "3481671")
    #   Folder: EntityHeader(name = "Research Data", id = "syn68327923",
    #     type = "org.sagebionetworks.repo.model.Folder", version_number = 1,
    #     version_label = "1", is_latest_version = TRUE, benefactor_id = 68327923,
    #     created_on = "2025-06-16T21:51:50.460Z", modified_on = "2025-06-16T22:19:41.481Z",
    #     created_by = "3481671", modified_by = "3481671")
}
}
\keyword{Folder}

\name{synMd5Query}
\alias{synMd5Query}
\docType{methods}
\title{
synMd5Query
}
\description{
Find the Entities which have attached file(s) which have the given MD5 hash.
}
\usage{
synMd5Query(md5, synapse_client=NULL)
}
\arguments{
\item{md5}{(str) The MD5 hash to query for (hexadecimal string).}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of Entity headers matching the MD5 hash.
}
\examples{
\dontrun{
## Example 1: Finding entities by MD5 hash
    # Search for entities with a specific MD5 hash:
    library(synapser)
    synLogin()

    md5_hash = "1234567890abcdef1234567890abcdef"
    results = synMd5Query(md5_hash)

    print(sprintf("Found \%d entities with MD5: \%s", length(results), md5_hash))
    for (entity in results) {
        print(sprintf("- \%s: \%s", entity$id, entity$name))
    }

## Example 2: Checking for duplicate files
    # Use MD5 query to find duplicate files before uploading:
    library(synapser)
    synLogin()

    # Calculate MD5 of a local file
    file_path = "/path/to/file.txt"
    file_md5 = unname(tools::md5sum(file_path))

    # Check if file already exists in Synapse
    existing_entities = synMd5Query(file_md5)
    if (length(existing_entities) > 0) {
        print("File already exists in Synapse:")
        for (entity in existing_entities) {
            print(sprintf("- \%s: \%s", entity$id, entity$name))
        }
    } else {
        print("File is unique, safe to upload")
    }

## Example 3: Finding all versions of a file
    # Find all entities that share the same content (MD5):
    library(synapser)
    synLogin()

    # Get MD5 from a known file
    file = synGet(synapse_id = "syn123456")
    if (!is.null(file$file_handle)) {
        file_md5 = file$file_handle$content_md5

        # Find all entities with the same MD5
        matching_entities = synMd5Query(file_md5)
        print(sprintf("Found \%d entities with same content:", length(matching_entities)))
        for (entity in matching_entities) {
            parent_id = if (!is.null(entity$parentId)) entity$parentId else "unknown"
            print(sprintf("- \%s: \%s in \%s", entity$id, entity$name, parent_id))
        }
    }
}
}

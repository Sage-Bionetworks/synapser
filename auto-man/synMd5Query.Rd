%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A list of Entity headers matching the MD5 hash.
}
\examples{
\dontrun{
## Example 1: Finding entities by MD5 hash
    # Search for entities with a specific MD5 hash:

    from synapseclient import Synapse
    from synapseclient.operations import md5_query

    syn = Synapse()
    syn.login()

    md5_hash = "1234567890abcdef1234567890abcdef"
    results = md5_query(md5_hash)

    print(f"Found {len(results)} entities with MD5: {md5_hash}")
    for entity in results:
        print(f"- {entity['id']}: {entity['name']}")

## Example 2: Checking for duplicate files
    # Use MD5 query to find duplicate files before uploading:

    from synapseclient import Synapse
    from synapseclient.operations import md5_query
    import hashlib

    syn = Synapse()
    syn.login()

    # Calculate MD5 of a local file
    def calculate_md5(file_path):
        hash_md5 = hashlib.md5()
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()

    file_path = "/path/to/file.txt"
    file_md5 = calculate_md5(file_path)

    # Check if file already exists in Synapse
    existing_entities = md5_query(file_md5)
    if existing_entities:
        print(f"File already exists in Synapse:")
        for entity in existing_entities:
            print(f"- {entity['id']}: {entity['name']}")
    else:
        print("File is unique, safe to upload")

## Example 3: Finding all versions of a file
    # Find all entities that share the same content (MD5):

    from synapseclient import Synapse
    from synapseclient.operations import md5_query, get

    syn = Synapse()
    syn.login()

    # Get MD5 from a known file
    file = get(synapse_id="syn123456")
    if hasattr(file, 'file_handle') and file.file_handle:
        file_md5 = file.file_handle.content_md5

        # Find all entities with the same MD5
        matching_entities = md5_query(file_md5)
        print(f"Found {len(matching_entities)} entities with same content:")
        for entity in matching_entities:
            print(f"- {entity['id']}: {entity['name']} in {entity.get('parentId', 'unknown')}")
}
}
\keyword{}

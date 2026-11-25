# DownloadListItem

A single item for a user's download list.

<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/download/DownloadListItem.html>

## Usage

``` r
DownloadListItem(file_entity_id, version_number=NULL)
```

## Format

An S3-style class object.

## Arguments

- file_entity_id:

  (character) Synapse ID of the file entity (e.g. "syn123").

- version_number:

  (Optional\[integer\]) Version of the file to target.

## Value

NULL

## Methods

- `DownloadListItem(file_entity_id, version_number=NULL)`: Constructor
  for `DownloadListItem`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    # Identify files (and optionally their versions) on your download list
    library(synapser)
    synLogin()

    items = list(
        DownloadListItem(file_entity_id = "syn123"),
        DownloadListItem(file_entity_id = "syn456", version_number = 2L)
    )
    # Add files to the cart
    count = synDownloadListAdd(items)
    print(count)

    # Download all files in the cart to a local directory.
    items = synDownloadListFiles()
    print(items)
    
    # Remove files from the cart
    count = synDownloadListRemove(items)
    print(count)

    
} # }
```

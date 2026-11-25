# synDownloadListAdd

Add files to the Synapse download list.

If a file is added with no version specified, the latest version will be
downloaded.

## Usage

``` r
synDownloadListAdd(files, synapse_client=NULL)
```

## Arguments

- files:

  (list\[DownloadListItem\]) List of
  [`DownloadListItem`](https://r-docs.synapse.org/v3.0.0/reference/DownloadListItem.md)
  objects identifying the file versions to add.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The number of files added.

## Examples

``` r
if (FALSE) { # \dontrun{
## Add files to the download list
    # Add specific file versions to the cart.
    library(synapser)
    synLogin()

    count = synDownloadListAdd(list(
        DownloadListItem(file_entity_id = "syn123", version_number = 1L),
        DownloadListItem(file_entity_id = "syn456", version_number = 2L)
    ))
} # }
```

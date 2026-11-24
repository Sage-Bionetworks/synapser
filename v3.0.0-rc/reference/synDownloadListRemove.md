# synDownloadListRemove

Remove files from the Synapse download list.

If a file was added with a version specified, then that version must be
specified to remove it. If a file was added with no version specified,
then no version must be specified to remove it.

## Usage

``` r
synDownloadListRemove(files, synapse_client=NULL)
```

## Arguments

- files:

  (list\[DownloadListItem\]) List of
  [`DownloadListItem`](https://r-docs.synapse.org/v3.0.0-rc/reference/DownloadListItem.md)
  objects identifying the file versions to remove.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The number of files removed.

## Examples

``` r
if (FALSE) { # \dontrun{
## Remove files from the download list
    # Remove specific file versions from the cart.
    library(synapser)
    synLogin()

    count = synDownloadListRemove(list(
        DownloadListItem(file_entity_id = "syn123", version_number = 1L)
    ))
} # }
```

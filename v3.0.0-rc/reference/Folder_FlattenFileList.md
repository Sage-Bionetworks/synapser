# Folder : flatten_file_list

Recursively loop over all of the already retrieved files and folders and
return a list of all files in the container.

## Usage

``` r
synFlattenFileList(instance)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

## Value

A list of all files in the container.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # synFlattenFileList only looks at files and folders that have already been
    # retrieved, so sync the folder from Synapse first.
    library(synapser)
    synLogin()

    my_folder = Folder(id = "syn123") |> synSyncFromSynapse(download_file = FALSE)

    all_files = my_folder |> synFlattenFileList()
    for (file in all_files) {
        print(sprintf("%s (%s)", file$name, file$id))
    }
} # }
```

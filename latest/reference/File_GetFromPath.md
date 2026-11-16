# File : from_path

Get the file from Synapse. If the path of the file matches multiple
files within Synapse the first one found will be returned. The other
matching files will be printed to the console.

Wrapper for
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md).

## Usage

``` r
synGetFromPath(cls, path, synapse_client=NULL)
```

## Arguments

- cls:

  (File) The File class (or an existing File instance) to dispatch this
  call to.

- path:

  (str) The path to the file on disk.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The file object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you have a file at the path "path/to/file.txt":
    file_instance = File |> synGetFromPath(path = "path/to/file.txt")
} # }
```

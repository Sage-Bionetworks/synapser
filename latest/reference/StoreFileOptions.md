# StoreFileOptions

Options for storing File entities.

## Usage

``` r
StoreFileOptions(synapse_store=NULL, content_type=NULL, merge_existing_annotations=NULL, associate_activity_to_new_version=NULL)
```

## Format

An S3-style class object.

## Arguments

- synapse_store:

  (Optional\[bool\]) Whether to store the file in Synapse or use an
  external URL.

- content_type:

  (Optional\[str\]) The content type of the file.

- merge_existing_annotations:

  (Optional\[bool\]) If TRUE, merge existing annotations with new ones.
  If FALSE, replace all annotations.

- associate_activity_to_new_version:

  (Optional\[bool\]) If TRUE, associate activity with new version. If
  FALSE, do not associate activity.

## Value

NULL

## Methods

- `StoreFileOptions(synapse_store=NULL, content_type=NULL, merge_existing_annotations=NULL, associate_activity_to_new_version=NULL)`:
  Constructor for `StoreFileOptions`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    library(synapser)
    synLogin()

    file = File(path = "/path/to/file.txt", parent_id = "syn123")
    file = file |> synStore(
        file_options = StoreFileOptions(
            content_type = "text/plain",
            merge_existing_annotations = TRUE
        )
    )
} # }
```

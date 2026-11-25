# StoreContainerOptions

Options for storing container entities (Project, Folder).

## Usage

``` r
StoreContainerOptions(failure_strategy=NULL)
```

## Format

An S3-style class object.

## Arguments

- failure_strategy:

  (Optional\[str\]) Strategy for handling failures when storing child
  entities. One of `"LOG_EXCEPTION"` or `"RAISE_EXCEPTION"`.

## Value

NULL

## Methods

- `StoreContainerOptions(failure_strategy=NULL)`: Constructor for
  `StoreContainerOptions`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    # Stop storing a folder's children as soon as one of them fails
    library(synapser)
    synLogin()

    folder = Folder(id = "syn123") |> synGet()
    folder = folder |> synStore(
        container_options = StoreContainerOptions(failure_strategy = "RAISE_EXCEPTION")
    )
} # }
```

# EntityRef

Represents a reference to the id and version of an entity to be used in
`Dataset` and `DatasetCollection` objects.

## Usage

``` r
EntityRef(id, version)
```

## Format

An S3-style class object.

## Arguments

- id:

  (character) The Synapse ID of the entity.

- version:

  (integer) Indicates a specific version of the entity.

## Value

NULL

## Methods

- `EntityRef(id, version)`: Constructor for `EntityRef`

## Examples

``` r
if (FALSE) { # \dontrun{
## Adding a specific entity version to a Dataset
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn123") |> synGet()
    my_dataset |> synAddItem(EntityRef(id = "syn456", version = 1L))
    my_dataset = my_dataset |> synStore()
} # }
```

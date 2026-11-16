# UsedEntity

Reference to a Synapse entity that was used or executed by an Activity.

## Usage

``` r
UsedEntity(target_id=NULL, target_version_number=NULL)
```

## Format

An S3-style class object.

## Arguments

- target_id:

  (Optional\[str\]) The ID of the entity to which this reference refers.

- target_version_number:

  (Optional\[int\]) The version number of the entity to which this
  reference refers.

## Value

NULL

## Methods

- `UsedEntity(target_id=NULL, target_version_number=NULL)`: Constructor
  for `UsedEntity`

## Examples

``` r
if (FALSE) { # \dontrun{
## Recording an entity used to produce a file
    library(synapser)
    synLogin()

    activity = Activity(
        name = "Analysis",
        used = list(UsedEntity(target_id = "syn456", target_version_number = 1L))
    )
    activity = activity |> synStore(parent = "syn123")
} # }
```

# Dataset : delete_column

Mark a column for deletion. Note that this does not delete the column
from Synapse. You must call the
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
function on this Dataset instance to delete the column from Synapse.
This is a convenience function to eliminate the need to manually delete
the column from the named list and add it to the `$_columns_to_delete`
attribute.

## Usage

``` r
synDeleteColumn(instance, name)
```

## Arguments

- instance:

  (Dataset) The Dataset instance to operate on.

- name:

  (character) The name of the column to delete.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Deleting a column
    # This example shows how you may delete a column from a dataset and then
    # store the change back in Synapse.
    library(synapser)
    synLogin()

    dataset = Dataset(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    dataset |> synDeleteColumn(name = "my_column")
    dataset |> synStore()
} # }
```

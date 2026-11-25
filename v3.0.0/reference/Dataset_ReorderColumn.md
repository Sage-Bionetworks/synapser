# Dataset : reorder_column

Reorder a column in the table. Note that this does not store the column
in Synapse. You must call the
[`synStore()`](https://r-docs.synapse.org/v3.0.0/reference/synStore.md)
function on this Dataset instance to store the column in Synapse. This
is a convenience function to eliminate the need to manually reorder the
named list stored in the `$columns` attribute.

You must ensure that the index is within the bounds of the number of
columns in the table. If you pass in an index that is out of bounds the
column will be added to the end of the list.

## Usage

``` r
synReorderColumn(instance, name, index)
```

## Arguments

- instance:

  (Dataset) The Dataset instance to operate on.

- name:

  (character) The name of the column to reorder.

- index:

  (integer) The index to move the column to starting with 0.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Reordering a column
    # This example shows how you may reorder a column in a dataset and then
    # store the change back in Synapse.
    library(synapser)
    synLogin()

    dataset = Dataset(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    # Move the column to the beginning of the list
    dataset |> synReorderColumn(name = "my_column", index = 0L)
    dataset |> synStore()
} # }
```

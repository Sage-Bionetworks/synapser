# EntityView : delete_column

Mark a column for deletion. Note that this does not delete the column
from Synapse. You must call the
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
function on this EntityView instance to delete the column from Synapse.
This is a convenience function to eliminate the need to manually delete
the column from the named list and add it to the `$_columns_to_delete`
attribute.

## Usage

``` r
synDeleteColumn(instance, name)
```

## Arguments

- instance:

  (EntityView) The EntityView instance to operate on.

- name:

  (str) The name of the column to delete.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Deleting a column
    # This example shows how you may delete a column from an EntityView and then store
    # the change back in Synapse.

    library(synapser)
    synLogin()

    entityview = EntityView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    entityview |> synDeleteColumn(name = "my_column")
    entityview |> synStore()
} # }
```

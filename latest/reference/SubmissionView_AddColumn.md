# SubmissionView : add_column

Add column(s) to the table. Note that this does not store the column(s)
in Synapse. You must call the
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
function on this SubmissionView instance to store the column(s) in
Synapse. This is a convenience function to eliminate the need to
manually add the column(s) to the `$columns` list.

This function will add an item to the `$columns` attribute of the
SubmissionView instance. `$columns` is a named list where the key is the
name of the column and the value is the Column object.

## Usage

``` r
synAddColumn(instance, column, index=NULL)
```

## Arguments

- instance:

  (SubmissionView) The SubmissionView instance to operate on.

- column:

  (Column or list of Column) The column(s) to add, may be a single
  Column object or a list of Column objects.

- index:

  (int) The index to insert the column at. If not passed in the column
  will be added to the end of the list.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Adding a single column
    # This example shows how you may add a single column to a submission view and
    # then store the change back in Synapse.
    library(synapser)
    synLogin()

    view = SubmissionView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    view |> synAddColumn(
        Column(name = "my_column", column_type = "STRING")
    )
    view |> synStore()

## Example 2: Adding multiple columns
    # This example shows how you may add multiple columns to a submission view and
    # then store the change back in Synapse.

    library(synapser)
    synLogin()

    view = SubmissionView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    view |> synAddColumn(list(
        Column(name = "my_column2", column_type = "STRING"),
        Column(name = "my_column3", column_type = "INTEGER")
    ))
    view |> synStore()

## Example 3: Adding a column at a specific index
    # This example shows how you may add a column at a specific index to a
    # submission view and then store the change back in Synapse. If the index
    # is out of bounds the column will be added to the end of the list.

    library(synapser)
    synLogin()

    view = SubmissionView(id = "syn1234") |> synGet(table_options = TableOptions(include_columns = TRUE))

    view |> synAddColumn(
        Column(name = "my_column4", column_type = "STRING"),
        # Add the column at the beginning of the list
        index = 0L
    )
    view |> synStore()
} # }
```

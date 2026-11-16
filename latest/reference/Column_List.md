# Column : list

List columns with optional prefix filtering.

## Usage

``` r
synList(prefix=NULL, limit=100L, offset=0L, synapse_client=NULL)
```

## Arguments

- prefix:

  (Optional\[str\]) Optional prefix to filter columns by name.

- limit:

  (int) Number of columns to retrieve per request to Synapse (pagination
  parameter). The function will continue retrieving results until all
  matching columns are returned.

- offset:

  (int) The index of the first column to return (pagination parameter).

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields
[`Column`](https://r-docs.synapse.org/latest/reference/Column.md)
instances. Use [`as.list()`](https://rdrr.io/r/base/list.html) to
materialize all results into a list, or `nextElem()` to retrieve one
[`Column`](https://r-docs.synapse.org/latest/reference/Column.md)
instance at a time.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Getting all columns
    # This example shows how you may list all columns.
    library(synapser)
    synLogin()

    columns = synList()
    for (column in as.list(columns)) {
        print(column$name)
    }

## Example 2: Getting columns with a prefix
    # This example shows how you may list columns filtered by a name prefix.
    library(synapser)
    synLogin()

    columns = synList(prefix = "my_prefix")
    for (column in as.list(columns)) {
        print(column$name)
    }
} # }
```

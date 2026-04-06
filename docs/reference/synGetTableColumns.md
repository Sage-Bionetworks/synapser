# synGetTableColumns

Retrieve the column models used in the given table schema.

## Usage

``` r
synGetTableColumns(table)
```

## Arguments

- table:

  the schema of the Table whose columns are to be retrieved

## Value

a Generator over the Table's columns. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
schema<-synGet("syn1234567")
columns<-synGetTableColumns(schema)
} # }
```

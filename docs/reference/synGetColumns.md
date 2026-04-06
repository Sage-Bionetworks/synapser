# synGetColumns

Get the columns defined in Synapse either (1) corresponding to a set of
column headers, (2) those for a given schema, or (3) those whose names
start with a given prefix.

## Usage

``` r
synGetColumns(x, limit=100, offset=0)
```

## Arguments

- x:

  a list of column headers, a Table Entity object
  (Schem/EntityViewSchema), a Table's Synapse ID, or a string prefix  

- limit:

  maximum number of columns to return (pagination parameter)  

- offset:

  the index of the first column to return (pagination parameter)

## Value

a generator of Column objects. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
columns<-as.list(synGetColumns("syn1234567", limit=100, offset=0))
} # }
```

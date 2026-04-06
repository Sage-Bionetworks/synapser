# Constructor for objects of type PartialRowset

A set of Partial Rows used for updating cells of a table. PartialRowsets
allow you to push only the individual cells you wish to change instead
of pushing entire rows with many unchanged cells.

## Usage

``` r
PartialRowset(schema, rows)
```

## Arguments

- schema:

  The Schema of the table to update or its tableId as a string  

- rows:

  A list of PartialRows

## Value

An object of type PartialRowset

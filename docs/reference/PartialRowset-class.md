# PartialRowset

A set of Partial Rows used for updating cells of a table. PartialRowsets
allow you to push only the individual cells you wish to change instead
of pushing entire rows with many unchanged cells.

## Format

An R6 class object.

## Methods

- `PartialRowset(schema, rows)`: Constructor for
  [`PartialRowset`](https://r-docs.synapse.org/reference/PartialRowset.md)

# Schema

A Schema is an Entity that defines a set of columns in a table.

## Format

An R6 class object.

## Methods

- `Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, description=NULL)`:
  Constructor for
  [`Schema`](https://r-docs.synapse.org/reference/Schema.md)

- `addColumn(column)`: Adds a
  [`Column`](https://r-docs.synapse.org/reference/Column.md) to the
  schema

- `addColumns(columns)`: Adds a list of
  [`Column`](https://r-docs.synapse.org/reference/Column.md)s to the
  schema

- `has_columns()`: Are there any
  [`Column`](https://r-docs.synapse.org/reference/Column.md)s specified
  in the schema?

- `removeColumn(column)`: Removes a
  [`Column`](https://r-docs.synapse.org/reference/Column.md) from the
  schema

## Examples

``` r
if (FALSE) { # \dontrun{
schema <- Schema(name='MyTable', parent=project)
schema$addColumn(Column(name='Isotope', columnType='STRING'))
cols <- c(Column(name='Atomic Mass', columnType='INTEGER'),
  Column(name='Halflife', columnType='DOUBLE'),
  Column(name='Discovered', columnType='DATE'))
schema$addColumns(cols)
schema$has_columns()
schema$removeColumn(Column(name='Discovered', columnType='DATE'))
schema <- synStore(schema)
} # }
```

# MaterializedViewSchema

A MaterializedViewSchema is an Entity that defines a set of columns in a
materialized view along with the SQL statement.

## Format

An R6 class object.

## Methods

- `MaterializedViewSchema(name=NULL, columns=NULL, parent=NULL, definingSQL=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)`:
  Constructor for
  [`MaterializedViewSchema`](https://r-docs.synapse.org/reference/MaterializedViewSchema.md)

- `addColumn(column)`:

- `addColumns(columns)`:

- `has_columns()`: Does this schema have columns specified?

- `removeColumn(column)`:

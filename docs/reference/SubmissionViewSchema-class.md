# SubmissionViewSchema

A SubmissionViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes

## Format

An R6 class object.

## Methods

- `SubmissionViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)`:
  Constructor for
  [`SubmissionViewSchema`](https://r-docs.synapse.org/reference/SubmissionViewSchema.md)

- `addColumn(column)`:

- `addColumns(columns)`:

- `add_scope(entities)`:

- `has_columns()`: Does this schema have columns specified?

- `removeColumn(column)`:

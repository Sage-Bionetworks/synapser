# EntityViewSchema

A EntityViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes

## Format

An R6 class object.

## Methods

- `EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, includeEntityTypes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL)`:
  Constructor for
  [`EntityViewSchema`](https://r-docs.synapse.org/reference/EntityViewSchema.md)

- `addColumn(column)`: Adds a
  [`Column`](https://r-docs.synapse.org/reference/Column.md) to the
  schema

- `addColumns(columns)`: Adds a list of
  [`Column`](https://r-docs.synapse.org/reference/Column.md)s to the
  schema

- `add_scope(entities)`: Adds a list of entities (usually
  [`Project`](https://r-docs.synapse.org/reference/Project.md)s) to the
  view

- `has_columns()`: Are there any
  [`Column`](https://r-docs.synapse.org/reference/Column.md)s specified
  in the schema?

- `removeColumn(column)`: Removes a
  [`Column`](https://r-docs.synapse.org/reference/Column.md) from the
  schema

- `set_entity_types(includeEntityTypes)`: Replaces the types of entity
  that will appear in the view

## Examples

``` r
if (FALSE) { # \dontrun{
project_or_folder <- synGet("syn123")  
schema <- EntityViewSchema(name='MyFileView', parent=project, scopes=c(project_or_folder_id, 'syn456'), includeEntityTypes=c(EntityViewType$FILE, EntityViewType$FOLDER))
schema <- synStore(schema)
schema$has_columns()
schema$removeColumn(Column(name="modifiedOn", columnType="DATE"))
another_project<-synGet("syn789")
schema$add_scope(another_project)
schema<-synStore(schema)
} # }
```

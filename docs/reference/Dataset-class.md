# Dataset

A Dataset is an Entity that defines a flat list of entities as a
tableview (a.k.a. a "dataset").

## Format

An R6 class object.

## Methods

- `Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE, description=NULL, folder=NULL)`:
  Constructor for
  [`Dataset`](https://r-docs.synapse.org/reference/Dataset.md)

- `addColumn(column)`:

- `addColumns(columns)`:

- `add_folder(folder, force=TRUE)`:

- `add_folders(folders, force=TRUE)`:

- `add_item(dataset_item, force=TRUE)`:

- `add_items(dataset_items, force=TRUE)`:

- `add_scope(entities)`:

- `empty()`:

- `has_columns()`: Does this schema have columns specified?

- `has_item(item_id)`:

- `removeColumn(column)`:

- `remove_item(item_id)`:

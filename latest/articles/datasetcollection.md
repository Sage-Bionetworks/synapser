# Dataset Collections

## Dataset Collections

Dataset Collections are a way to organize, annotate, and publish sets of
datasets for others to use. Dataset Collections behave similarly to
Tables and EntityViews, but provide some default behavior that makes it
easy to put a group of datasets together.

This tutorial will walk through basics of working with Dataset
Collections using synapser.

### Tutorial Purpose

In this tutorial, you will:

- Create a Dataset Collection
- Add datasets to the collection
- Add a custom column to the collection
- Update the collection with new annotations
- Query the collection
- Save a snapshot of the collection

### Prerequisites

- This tutorial assumes that you have a project in Synapse and have
  already created datasets that you would like to add to a Dataset
  Collection.
- If you need help creating datasets, you can refer to the
  [Dataset](https://r-docs.synapse.org/latest/articles/dataset.md)
  tutorial.

## 1. Get the ID of your Synapse project

Let’s get started by authenticating with Synapse and retrieving the ID
of your project.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
\
`# First, let's get the project that we want to create the DatasetCollection in`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(`\
`  name ``=`` ``"My uniquely named project about Alzheimer's Disease"`\
`)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`` ``# Replace with your project name`\
`project_id`` ``<-`` ``project``$``id`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My project ID is %s"``, ``project_id``)``)`

## 2. Create your Dataset Collection

Next, we will create the Dataset Collection using the project ID to tell
Synapse where we want the Dataset Collection to be created. After this
step, we will have a Dataset Collection object with all of the necessary
information to start building the collection.

\
`DATASET_IDS`` ``<-`` `[`c`](https://rdrr.io/r/base/c.html)`(`\
`  ``"syn65987017"``,`\
`  ``"syn65987019"``,`\
`  ``"syn65987020"`\
`)`` ``# Replace with your dataset IDs`\
`test_dataset_collection`` ``<-`` `[`DatasetCollection`](https://r-docs.synapse.org/latest/reference/DatasetCollection.md)`(`\
`  parent_id ``=`` ``project_id``, name ``=`` ``"test_dataset_collection"`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My DatasetCollection's ID is %s"``, ``test_dataset_collection``$``id``)``)`

Because we haven’t added any datasets to the collection yet, it will be
empty, but if you view the Dataset Collection’s schema in the UI, you
will notice that Dataset Collections come with default columns.

![Dataset Collection Default
Schema](dataset_collection_default_schema.png)

Dataset Collection Default Schema

## 3. Add Datasets to the Dataset Collection

Now, let’s add some datasets to the collection. We will loop through our
dataset ids and add each dataset to the collection using the
`synAddItem()` function.

\
`for`` ``(``dataset_id`` ``in`` ``DATASET_IDS``)`` ``{`\
`  ``test_dataset_collection`` ``|>`` ``synAddItem``(`[`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md)`(``id ``=`` ``dataset_id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)``)`\
`}`

Whenever we make changes to the Dataset Collection, we need to call the
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
function to save the changes to Synapse.

\
`test_dataset_collection`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

And now we are able to see our Dataset Collection with all of the
datasets that we added to it.

![Dataset Collection with
Datasets](dataset_collection_with_datasets.png)

Dataset Collection with Datasets

## 4. Retrieve the Dataset Collection

Now that our Dataset Collection has been created and we have added some
Datasets to it, we can retrieve the Dataset Collection from Synapse the
next time we need to use it.

\
`my_retrieved_dataset_collection`` ``<-`` `[`DatasetCollection`](https://r-docs.synapse.org/latest/reference/DatasetCollection.md)`(``id ``=`` ``test_dataset_collection``$``id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My DatasetCollection's ID is still %s"``, ``my_retrieved_dataset_collection``$``id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My DatasetCollection has %d items"``, `[`length`](https://rdrr.io/r/base/length.html)`(``my_retrieved_dataset_collection``$``items``)``)``)`

## 5. Add a custom column to the Dataset Collection

In addition to the default columns, you may want to annotate items in
your DatasetCollection using custom columns.

\
`my_retrieved_dataset_collection`` ``|>`` ``synAddColumn``(`\
`  column ``=`` `[`Column`](https://r-docs.synapse.org/latest/reference/Column.md)`(`\
`    name ``=`` ``"my_annotation"``,`\
`    column_type ``=`` ``"STRING"`\
`  ``)`\
`)`\
`my_retrieved_dataset_collection`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

Our custom column isn’t all that useful empty, so let’s update the
Dataset Collection with some values.

\
`modified_data`` ``<-`` `[`data.frame`](https://rdrr.io/r/base/data.frame.html)`(`\
`  id ``=`` ``DATASET_IDS``,`\
`  my_annotation ``=`` `[`rep`](https://rdrr.io/r/base/rep.html)`(``"good dataset"``, `[`length`](https://rdrr.io/r/base/length.html)`(``DATASET_IDS``)``)`\
`)`\
`my_retrieved_dataset_collection`` ``|>`` ``synUpdateRows``(`\
`  values ``=`` ``modified_data``, primary_keys ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"id"``)``, dry_run ``=`` ``FALSE`\
`)`

## 6. Query the Dataset Collection

If you want to query your DatasetCollection for items that match certain
criteria, you can do so using the `synQuery()` function.

\
`rows`` ``<-`` ``synQuery``(`\
`  query ``=`` `[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(`\
`    ``"SELECT id, my_annotation FROM %s WHERE my_annotation = 'good dataset'"``,`\
`    ``my_retrieved_dataset_collection``$``id`\
`  ``)`\
`)`\
[`print`](https://rdrr.io/r/base/print.html)`(``rows``)`

## 7. Save a snapshot of the Dataset Collection

Finally, let’s save a snapshot of the Dataset Collection. This creates a
read-only version of the Dataset Collection that captures the current
state of the Dataset Collection and can be referenced later.

\
`my_retrieved_dataset_collection`` ``|>`` ``synSnapshot``(``comment ``=`` ``"test snapshot"``)`

## References

- [`DatasetCollection`](https://r-docs.synapse.org/latest/reference/DatasetCollection.md)
- [`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md)
- [`Project`](https://r-docs.synapse.org/latest/reference/Project.md)
- [`Column`](https://r-docs.synapse.org/latest/reference/Column.md)
- [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)

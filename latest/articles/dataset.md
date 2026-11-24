# Datasets

## Datasets

Datasets in Synapse are a way to organize, annotate, and publish sets of
files for others to use. Datasets behave similarly to Tables and
EntityViews, but provide some default behavior that makes it easy to put
a group of files together.

This tutorial will walk through basics of working with datasets using
synapser.

### Tutorial Purpose

In this tutorial, you will:

- Create a dataset
- Add files to the dataset
- Query the dataset
- Add a custom column to the dataset
- Save a snapshot of the dataset

### Prerequisites

- This tutorial assumes that you have a project in Synapse with one or
  more files in it. To test all of the ways to add files to a dataset,
  you will need to have at least 3 files in your project. A structure
  like this is recommended:

      Project
      ├── File 1
      ├── File 2
      ├── Folder 1
      │   ├── File 4
      │   ├── ...

## 1. Get the ID of your Synapse project

Let’s get started by authenticating with Synapse and retrieving the ID
of your project.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
\
`# First, let's get the project that we want to create the dataset in`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(`\
`  name ``=`` ``"My uniquely named project about Alzheimer's Disease"`\
`)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`` ``# Replace with your project name`\
`project_id`` ``<-`` ``project``$``id`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My project ID is %s"``, ``project_id``)``)`

## 2. Create your Dataset

Next, we will create the dataset. We will use the project ID to tell
Synapse where we want the dataset to be created. After this step, we
will have a Dataset object with all of the needed information to start
building the dataset.

\
`my_new_dataset`` ``<-`` `[`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md)`(``parent_id ``=`` ``project_id``, name ``=`` ``"My New Dataset"``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My Dataset's ID is %s"``, ``my_new_dataset``$``id``)``)`

Because we haven’t added any files to the dataset yet, it will be empty,
but if you view the dataset’s schema in the UI, you will notice that
datasets come with default columns that help to describe each file that
we add to the dataset.

![Dataset Default Schema](dataset_default_schema.png)

Dataset Default Schema

## 3. Add files to the dataset

Let’s add some files to the dataset now. There are three ways to add
files to a dataset:

1.  Add an Entity Reference to a file with its ID and version

\
`my_new_dataset`` ``|>`` ``synAddItem``(`\
`  `[`EntityRef`](https://r-docs.synapse.org/latest/reference/EntityRef.md)`(``id ``=`` ``"syn51790029"``, version ``=`` ``1L``)`\
`)`` ``# Replace with the ID of the file you want to add`

2.  Add a File with its ID and version

\
`my_new_dataset`` ``|>`` ``synAddItem``(`\
`  `[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``id ``=`` ``"syn51790028"``, version_number ``=`` ``1L``)`\
`)`` ``# Replace with the ID of the file you want to add`

3.  Add a Folder. When adding a folder, all child files inside of the
    folder are added to the dataset recursively.

\
`my_new_dataset`` ``|>`` ``synAddItem``(`\
`  `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn64893446"``)`\
`)`` ``# Replace with the ID of the folder you want to add`

Whenever we make changes to the dataset, we need to call the
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
function to save the changes to Synapse.

\
`my_new_dataset`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

And now we are able to see our dataset with all of the files that we
added to it.

![Dataset with Files](dataset_with_files.png)

Dataset with Files

## 4. Retrieve the dataset

Now that we have a dataset with some files in it, we can retrieve the
dataset from Synapse the next time we need to use it.

\
`my_retrieved_dataset`` ``<-`` `[`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md)`(``id ``=`` ``my_new_dataset``$``id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"My Dataset's ID is %s"``, ``my_retrieved_dataset``$``id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`length`](https://rdrr.io/r/base/length.html)`(``my_retrieved_dataset``$``items``)``)`

## 5. Query the dataset

Now that we have a dataset with some files in it, we can query the
dataset to find files that match certain criteria.

\
`rows`` ``<-`` ``synQuery``(`\
`  query ``=`` `[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(`\
`    ``"SELECT * FROM %s WHERE name like '%%test%%'"``,`\
`    ``my_retrieved_dataset``$``id`\
`  ``)`\
`)`\
[`print`](https://rdrr.io/r/base/print.html)`(``rows``)`

## 6. Add a custom column to the dataset

We can also add a custom column to the dataset. This will allow us to
annotate files in the dataset with additional information.

\
`my_retrieved_dataset`` ``|>`` ``synAddColumn``(`\
`  column ``=`` `[`Column`](https://r-docs.synapse.org/latest/reference/Column.md)`(`\
`    name ``=`` ``"my_annotation"``,`\
`    column_type ``=`` ``"STRING"`\
`  ``)`\
`)`\
`my_retrieved_dataset`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

Our custom column isn’t all that useful empty, so let’s update the
dataset with some values.

\
`modified_data`` ``<-`` `[`data.frame`](https://rdrr.io/r/base/data.frame.html)`(`\
`  id ``=`` ``"syn51790028"``, ``# The ID of one of our Files`\
`  my_annotation ``=`` ``"excellent data"`\
`)`\
`my_retrieved_dataset`` ``|>`` ``synUpdateRows``(`\
`  values ``=`` ``modified_data``, primary_keys ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"id"``)``, dry_run ``=`` ``FALSE`\
`)`\
`my_retrieved_dataset`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## 7. Save a snapshot of the dataset

Finally, let’s save a snapshot of the dataset. This creates a read-only
version of the dataset that captures the current state of the dataset
and can be referenced later.

\
`snapshot_info`` ``<-`` ``my_retrieved_dataset`` ``|>`` ``synSnapshot``(`\
`  comment ``=`` ``"My first snapshot"``,`\
`  label ``=`` ``"My first snapshot"`\
`)`\
[`print`](https://rdrr.io/r/base/print.html)`(``snapshot_info``)`

## References

- [`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md)
- [`Column`](https://r-docs.synapse.org/latest/reference/Column.md)
- [`EntityRef`](https://r-docs.synapse.org/latest/reference/EntityRef.md)
- [`File`](https://r-docs.synapse.org/latest/reference/File.md)
- [`Project`](https://r-docs.synapse.org/latest/reference/Project.md)
- [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)
- [`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)
- [`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)
- [`synAddItem`](https://r-docs.synapse.org/latest/reference/Dataset_AddItem.md)
- [`synQuery`](https://r-docs.synapse.org/latest/reference/Dataset_Query.md)
- [`synAddColumn`](https://r-docs.synapse.org/latest/reference/Dataset_AddColumn.md)
- [`synUpdateRows`](https://r-docs.synapse.org/latest/reference/Dataset_UpdateRows.md)
- [`synSnapshot`](https://r-docs.synapse.org/latest/reference/Dataset_Snapshot.md)
- [query
  examples](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html)

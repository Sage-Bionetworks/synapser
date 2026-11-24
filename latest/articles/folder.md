# Folders

## Overview

Similar to Projects, Folders are “containers” that offer an additional w
ay to organize your data. Instead of uploading a bunch of single files
into your project, you can create folders to separate your data in a
systematic way.

Folders in Synapse always have a “parent,” which could be a project or
another folder. You can organize collections of folders and sub-folders,
just as you would on your local computer. See [Domain Models of
Synapse](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.html#folders)
for more background on Folders.

**Note:** You may optionally follow the [Uploading data in
bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md)
tutorial instead. The bulk tutorial may fit your needs better as it
limits the amount of code that you are required to write and maintain.

This vignette follows a mix of [Flattened Data
Layout](https://r-docs.synapse.org/latest/articles/structuring_your_project.html#flattened-data-layout-example)
and [Hierarchy Data
Layout](https://r-docs.synapse.org/latest/articles/structuring_your_project.html#hierarchy-data-layout-example).
It’s recommended to use one or the other, but not both — both are shown
here to demonstrate the flexibility of storing folders within folders on
Synapse, following this example layout:

    .
    ├── experiment_notes
    │   ├── notes_2022
    │   │   ├── fileA.txt
    │   │   └── fileB.txt
    │   └── notes_2023
    │       ├── fileC.txt
    │       └── fileD.txt
    ├── biospecimen_experiment_1
    │   ├── fileA.txt
    │   └── fileB.txt
    ├── biospecimen_experiment_2
    │   ├── fileC.txt
    │   └── fileD.txt
    ├── single_cell_RNAseq_batch_1
    │   ├── SRR12345678_R1.fastq.gz
    │   └── SRR12345678_R2.fastq.gz
    └── single_cell_RNAseq_batch_2
        ├── SRR12345678_R1.fastq.gz
        └── SRR12345678_R2.fastq.gz

In this tutorial you will:

1.  Create 4 new folders
2.  Print stored attributes about a folder
3.  Create 2 sub-folders

## Load the package and log in

## Prerequisites

- Make sure that you have completed the [Create a
  Project](https://r-docs.synapse.org/latest/articles/data_upload_download.html#create-a-project)
  step.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

Credentials are read from `~/.synapseConfig` or the `SYNAPSE_AUTH_TOKEN`
environment variable. See the
[Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
vignette for setup details.

## 1. Create a new folder

Folders need a parent — here, a freshly created Project.

\
`my_project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(`\
`  name ``=`` `[`paste0`](https://rdrr.io/r/base/paste.html)`(`\
`    ``"My uniquely named project about Alzheimer's Disease "``,`\
`    `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`sample`](https://rdrr.io/r/base/sample.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``letters``, ``LETTERS``, ``0``:``9``)``, ``8``, replace ``=`` ``TRUE``)``, collapse ``=`` ``""``)`\
`  ``)`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`# Create a Folder object and store it`\
`my_scrnaseq_batch_1_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"single_cell_RNAseq_batch_1"``,`\
`  parent_id ``=`` ``my_project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`my_scrnaseq_batch_2_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"single_cell_RNAseq_batch_2"``,`\
`  parent_id ``=`` ``my_project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`biospecimen_experiment_1_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"biospecimen_experiment_1"``,`\
`  parent_id ``=`` ``my_project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`biospecimen_experiment_2_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"biospecimen_experiment_2"``,`\
`  parent_id ``=`` ``my_project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## 2. Print stored attributes about your folder

\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"My folder ID is:"``, ``my_scrnaseq_batch_1_folder``$``id``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"The parent ID of my folder is:"``, ``my_scrnaseq_batch_1_folder``$``parent_id``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"I created my folder on:"``, ``my_scrnaseq_batch_1_folder``$``created_on``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"The ID of the user that created my folder is:"``, ``my_scrnaseq_batch_1_folder``$``created_by``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"My folder was last modified on:"``, ``my_scrnaseq_batch_1_folder``$``modified_on``, ``"\n"``)`

You’ll see output like:

    My folder ID is: syn53205629
    The parent ID of my folder is: syn53185532
    I created my folder on: 2023-12-28T20:52:50.193Z
    The ID of the user that created my folder is: 3481671
    My folder was last modified on: 2023-12-28T20:52:50.193Z

## 3. Create 2 sub-folders

Folders can be nested — a folder’s `parent_id` can be another folder,
not just a project:

\
`hierarchical_root_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"experiment_notes"``,`\
`  parent_id ``=`` ``my_project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`folder_notes_2023`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"notes_2023"``,`\
`  parent_id ``=`` ``hierarchical_root_folder``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`folder_notes_2022`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"notes_2022"``,`\
`  parent_id ``=`` ``hierarchical_root_folder``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## Results

Once these folders are created you’ll be able to inspect them on the
Files tab of your project in the Synapse web UI. It should look similar
to:

![Folder hierarchy shown on the Files tab of a Synapse
project](folder.png)

Folder hierarchy shown on the Files tab of a Synapse project

## Clean Up

Delete the project and everything in it when done:

\
[`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)`(``my_project``)`

## References used in this tutorial

- [`Project`](https://r-docs.synapse.org/latest/reference/Project.md)
- [`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)
- [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)
- [`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)
- [`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)

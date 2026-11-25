# synapser

**Important Note About the R Client**

We maintain the R client to support our R user community, recognizing R
as a foundational language in many data workflows. synapser is built on
top of the [Synapse Python client](https://python-docs.synapse.org/) via
the reticulate package. This lets us solve complex engineering problems,
such as file transfers and caching, once in Python and reuse those
solutions in R.

We recommend upgrading to version 3.0 or later of the Synapse R client.
Starting with 3.0, the R client uses reticulate to manage its Python
dependencies, which should make installation and updates easier. You do
not need to set up Python yourself: reticulate installs a compatible
Python and the Synapse Python client the first time synapser is loaded.

If you run into problems, see the [Troubleshooting
guide](https://r-docs.synapse.org/v3.0.0-rc/articles/troubleshooting.md)
or [open an issue](https://github.com/Sage-Bionetworks/synapser/issues).
New features usually appear in the Python client first, so if you need
one that synapser does not have yet, you can use the Python client
directly. If you continue to run into environment or package version
issues, you can also use the Synapse Python client via reticulate. See
the [Using synapseclient with R through
reticulate](https://python-docs.synapse.org/en/stable/tutorials/reticulate/).

We appreciate your patience and continued feedback as we work to improve
the user experience across both clients.

**Introducing synapser 3.0.0**

synapser 3.0.0 is a major release built on version 4.15 of the Synapse
Python client. It introduces object-oriented models: create an instance
of a Synapse object, such as
`File(path = “data.csv”, parent_id = “syn123”)`, then pipe it into verb
functions like
[`synStore()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synStore.md)
and
[`synGet()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synGet.md).
It also brings:

- **No Python setup.** When synapser is loaded, reticulate installs a
  compatible Python and the Synapse Python client for you. Python
  versions 3.11 to 3.15 are supported.
- **Current R dependencies.** synapser works with current versions of
  reticulate (1.44.0 or later) and rjson, and requires R 4.2.0 or later.

**This release is not backward compatible.** Functions from earlier
versions, such as `synGetChildren()` and `synGetAnnotations()`, have
been removed. Before upgrading, see [Key differences from the legacy
API](https://r-docs.synapse.org/v3.0.0-rc/articles/data_upload_download.html#key-differences-from-the-legacy-api)
for how earlier calls map to the new API, and [Supported Models and
Functions](#supported-models-and-functions) for what this release
supports.

## Introduction

The `synapser` package provides an interface to
[Synapse](https://www.synapse.org), a collaborative workspace for
reproducible data-intensive research projects, providing support for:

- integrated presentation of data, code, and text
- fine-grained access control
- provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](https://python-docs.synapse.org/),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop/client/synapseJavaClient),
and [the web browser](https://www.synapse.org).

## Supported Models and Functions

synapser 3.0.0 supports the following Synapse models. Each model’s
reference page also lists the functions that work on it, such as
`synGetAcl()`, `synSetPermissions()`, or `synSyncFromSynapse()`.

| Area | Models |
|----|----|
| Projects, folders, and files | [`Project`](https://r-docs.synapse.org/v3.0.0-rc/reference/Project.md), [`Folder`](https://r-docs.synapse.org/v3.0.0-rc/reference/Folder.md), [`File`](https://r-docs.synapse.org/v3.0.0-rc/reference/File.md), [`Link`](https://r-docs.synapse.org/v3.0.0-rc/reference/Link.md) |
| Tables and views | [`Table`](https://r-docs.synapse.org/v3.0.0-rc/reference/Table.md), [`Column`](https://r-docs.synapse.org/v3.0.0-rc/reference/Column.md), [`JsonSubColumn`](https://r-docs.synapse.org/v3.0.0-rc/reference/JsonSubColumn.md), [`VirtualTable`](https://r-docs.synapse.org/v3.0.0-rc/reference/VirtualTable.md), [`EntityView`](https://r-docs.synapse.org/v3.0.0-rc/reference/EntityView.md), [`MaterializedView`](https://r-docs.synapse.org/v3.0.0-rc/reference/MaterializedView.md), [`SubmissionView`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionView.md), [`Dataset`](https://r-docs.synapse.org/v3.0.0-rc/reference/Dataset.md), [`DatasetCollection`](https://r-docs.synapse.org/v3.0.0-rc/reference/DatasetCollection.md), [`EntityRef`](https://r-docs.synapse.org/v3.0.0-rc/reference/EntityRef.md) |
| Provenance | [`Activity`](https://r-docs.synapse.org/v3.0.0-rc/reference/Activity.md), [`UsedEntity`](https://r-docs.synapse.org/v3.0.0-rc/reference/UsedEntity.md), [`UsedURL`](https://r-docs.synapse.org/v3.0.0-rc/reference/UsedURL.md) |
| Wikis | [`WikiPage`](https://r-docs.synapse.org/v3.0.0-rc/reference/WikiPage.md), [`WikiHeader`](https://r-docs.synapse.org/v3.0.0-rc/reference/WikiHeader.md), [`WikiHistorySnapshot`](https://r-docs.synapse.org/v3.0.0-rc/reference/WikiHistorySnapshot.md), [`WikiOrderHint`](https://r-docs.synapse.org/v3.0.0-rc/reference/WikiOrderHint.md) |
| Challenges and evaluations | [`Evaluation`](https://r-docs.synapse.org/v3.0.0-rc/reference/Evaluation.md), [`Submission`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission.md), [`SubmissionStatus`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionStatus.md), [`SubmissionBundle`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionBundle.md) |
| Users, teams, and organizations | [`Team`](https://r-docs.synapse.org/v3.0.0-rc/reference/Team.md), [`UserProfile`](https://r-docs.synapse.org/v3.0.0-rc/reference/UserProfile.md), [`UserPreference`](https://r-docs.synapse.org/v3.0.0-rc/reference/UserPreference.md), [`Organization`](https://r-docs.synapse.org/v3.0.0-rc/reference/Organization.md), [`JSONSchema`](https://r-docs.synapse.org/v3.0.0-rc/reference/JSONSchema.md) |
| Storage | [`StorageLocation`](https://r-docs.synapse.org/v3.0.0-rc/reference/StorageLocation.md), [`StorageLocationType`](https://r-docs.synapse.org/v3.0.0-rc/reference/StorageLocationType.md) |
| AI agents | [`Agent`](https://r-docs.synapse.org/v3.0.0-rc/reference/Agent.md), [`AgentSession`](https://r-docs.synapse.org/v3.0.0-rc/reference/AgentSession.md), [`AgentPrompt`](https://r-docs.synapse.org/v3.0.0-rc/reference/AgentPrompt.md) |

These functions work across models:

| Task | Functions |
|----|----|
| Connecting to Synapse | [`synLogin`](https://r-docs.synapse.org/v3.0.0-rc/reference/synLogin.md), [`synLogout`](https://r-docs.synapse.org/v3.0.0-rc/reference/synLogout.md), [`synSetEndpoints`](https://r-docs.synapse.org/v3.0.0-rc/reference/synSetEndpoints.md) |
| Getting, storing, and deleting entities | [`synGet`](https://r-docs.synapse.org/v3.0.0-rc/reference/synGet.md), [`synStore`](https://r-docs.synapse.org/v3.0.0-rc/reference/synStore.md), [`synDelete`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDelete.md), [`synSetProperties`](https://r-docs.synapse.org/v3.0.0-rc/reference/synSetProperties.md) |
| Options for getting and storing | [`FileOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/FileOptions.md), [`ActivityOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/ActivityOptions.md), [`TableOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/TableOptions.md), [`LinkOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/LinkOptions.md), [`StoreFileOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/StoreFileOptions.md), [`StoreContainerOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/StoreContainerOptions.md), [`StoreTableOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/StoreTableOptions.md), [`StoreJSONSchemaOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/StoreJSONSchemaOptions.md), [`StoreGridOptions`](https://r-docs.synapse.org/v3.0.0-rc/reference/StoreGridOptions.md) |
| Querying tables and views | [`synQuery`](https://r-docs.synapse.org/v3.0.0-rc/reference/Table_Query.md), [`synQueryPartMask`](https://r-docs.synapse.org/v3.0.0-rc/reference/Table_QueryPartMask.md) |
| Download list (cart) | [`synDownloadListAdd`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDownloadListAdd.md), [`synDownloadListRemove`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDownloadListRemove.md), [`synDownloadListClear`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDownloadListClear.md), [`synDownloadListManifest`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDownloadListManifest.md), [`synDownloadListFiles`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDownloadListFiles.md), [`DownloadListItem`](https://r-docs.synapse.org/v3.0.0-rc/reference/DownloadListItem.md) |
| Utilities | [`synFindEntityId`](https://r-docs.synapse.org/v3.0.0-rc/reference/synFindEntityId.md), [`synIsSynapseId`](https://r-docs.synapse.org/v3.0.0-rc/reference/synIsSynapseId.md), [`synOnweb`](https://r-docs.synapse.org/v3.0.0-rc/reference/synOnweb.md), [`synPrintEntity`](https://r-docs.synapse.org/v3.0.0-rc/reference/synPrintEntity.md), [`synMd5Query`](https://r-docs.synapse.org/v3.0.0-rc/reference/synMd5Query.md), [`synSendMessage`](https://r-docs.synapse.org/v3.0.0-rc/reference/synSendMessage.md) |
| REST API | [`synRestGet`](https://r-docs.synapse.org/v3.0.0-rc/reference/synRestGet.md), [`synRestPost`](https://r-docs.synapse.org/v3.0.0-rc/reference/synRestPost.md), [`synRestPut`](https://r-docs.synapse.org/v3.0.0-rc/reference/synRestPut.md), [`synRestDelete`](https://r-docs.synapse.org/v3.0.0-rc/reference/synRestDelete.md) |

See the [reference
index](https://r-docs.synapse.org/v3.0.0-rc/reference/index.md) for the
full list.

## Requirements

- R version 4.2.0 or higher (tested up to R 4.6.1)
- reticulate 1.44.0 or higher
- [Synapse account](https://www.synapse.org/register)

**Note:** You do not need to install Python yourself. When `synapser` is
loaded, it declares its Python requirement via
[`reticulate::py_require()`](https://rstudio.github.io/reticulate/reference/py_require.html),
and reticulate downloads a compatible Python and the Synapse Python
client into a managed environment on first use.

## Documentation

Full documentation for `synapser` is on the [docs
site](https://r-docs.synapse.org/):

- [Reference](https://r-docs.synapse.org/v3.0.0-rc/reference/index.md):
  every model and function, organized by model.
- [Installation](https://r-docs.synapse.org/v3.0.0-rc/articles/installation.md),
  [Authentication](https://r-docs.synapse.org/v3.0.0-rc/articles/authentication.md),
  and
  [Configuration](https://r-docs.synapse.org/v3.0.0-rc/articles/configuration.md):
  get set up.
- [Tutorials](https://r-docs.synapse.org/v3.0.0-rc/articles/index.md):
  task guides for files, folders, tables, wikis, evaluations, and more.
- [Migrating to synapser
  3.0](https://r-docs.synapse.org/v3.0.0-rc/articles/migration_to_synapser_3_0.md):
  how to update scripts written for synapser 2.x.

## Installation

`synapser` 3.0.0 is distributed through
[R-universe](https://sage-bionetworks.r-universe.dev/synapser), which
provides ready-built binaries for Windows and macOS (Apple silicon and
Intel). Install it with:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(`\
`  ``"synapser"``,`\
`  repos ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"https://sage-bionetworks.r-universe.dev"``, ``"https://cloud.r-project.org"``)`\
`)`

Listing CRAN alongside R-universe lets R pull synapser’s dependencies
(such as `reticulate` and `rjson`) from CRAN.

**Linux:** R installs packages from source on Linux, and several of
synapser’s dependencies contain compiled code. Install a C/C++ compiler
and the libpng headers first, then run the command above:

``` bash
# Ubuntu / Debian
sudo apt-get install -y build-essential libpng-dev
# Amazon Linux / RHEL / CentOS
sudo dnf install -y gcc gcc-c++ make libpng-devel
```

Then restart R and verify the installation:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`packageVersion`](https://rdrr.io/r/utils/packageDescription.html)`(``"synapser"``)``  ``# should be 3.0.0`

The first
[`library(synapser)`](https://github.com/Sage-Bionetworks/synapser) may
take a minute while reticulate downloads Python and the Synapse Python
client. Later loads reuse the cached environment.

[**See the install
guide**](https://r-docs.synapse.org/v3.0.0-rc/articles/installation.md)
for upgrading from synapser 2.x, installing an older version (2.x
releases remain on [RAN](http://ran.synapse.org)), installing from
GitHub, and how synapser finds Python. If installation fails, see the
[Troubleshooting
guide](https://r-docs.synapse.org/v3.0.0-rc/articles/troubleshooting.md).

## Usage

To get started, try logging in to Synapse. If you don’t already have a
Synapse account, register [here](https://www.synapse.org/register):

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/v3.0.0-rc/reference/synLogin.md)`(``)`

To learn more about using `synapser`, visit the [docs
site](https://r-docs.synapse.org/) or browse the package vignettes:

\
[`browseVignettes`](https://rdrr.io/r/utils/browseVignettes.html)`(``package ``=`` ``"synapser"``)`

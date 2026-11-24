# Data Upload, Download, and Delete

## Overview

This vignette demonstrates how to upload, download, and delete data
using `synapser`.

**Note on integer parameters:** R’s bare numeric literals (e.g. `1`) are
doubles. Parameters that the Synapse API expects as integers — such as
`version_number` and `version` — must be written with the `L` suffix
(e.g. `1L`) to pass a true integer to Python. Passing `1` instead of
`1L` may cause unexpected behavior or an API error.

## Key differences from the legacy API:

| Task | Legacy | New pipe UI |
|----|----|----|
| Store an entity | `synStore(obj, ...)` | `File(...) |> synStore(file_options, container_options, ...)` or `synStore(entity = File(...), parent, file_options, container_options, ...)` |
| Suppress new version | `synStore(obj, forceVersion = FALSE)` | `File(..., force_version = FALSE) |> synStore()` |
| Set entity properties (e.g. name) | `entity$properties$name <- "new name"` then `synStore(entity)` | `synGet(synapse_id) |> synSetProperties(name = "new name") |> synStore()` |
| Set version label | `synStore(obj, versionLabel = "2")` | `synGet(synapse_id) |> synSetProperties(version_label = "2") |> synStore()` |
| Track provenance | `synStore(obj, used = "syn123", executed = "syn456")` | `synGet(synapse_id) |> synSetProperties(activity = Activity(used = list(UsedEntity(target_id = "syn123")), executed = list(UsedEntity(target_id = "syn456")))) |> synStore()` |
| Access entity ID | `entity$properties$id` | `entity$id` |
| Get an entity | `synGet(entity, ...)` | `File(...) |> synGet(file_options, ...)` or `synGet(synapse_id, file_options, ...)` |
| Get a specific version | `synGet(entity, version = 1)` | `File(id) |> synGet(version_number = 1L)` or `synGet(synapse_id, version_number = 1L)` |
| Skip file download | `synGet(entity, downloadFile = FALSE)` | `File(...) |> synGet(file_options = FileOptions(download_file = FALSE))` or `synGet(synapse_id, file_options = FileOptions(download_file = FALSE))` |
| Delete a version | `synDelete(obj, version = 1)` | `File(...) |> synDelete(version = 1L, version_only = TRUE)` or `synDelete(entity, version = 1L, version_only = TRUE)` |

## Load the package

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`

## Login

\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

Credentials are read from `~/.synapseConfig` or the `SYNAPSE_AUTH_TOKEN`
environment variable. See the
[Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
vignette for setup details.

## Create a Project

\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(`\
`  name ``=`` `[`paste0`](https://rdrr.io/r/base/paste.html)`(`\
`    ``"My uniquely named project about Alzheimer's Disease "``,`\
`    `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`sample`](https://rdrr.io/r/base/sample.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``letters``, ``LETTERS``, ``0``:``9``)``, ``8``, replace ``=`` ``TRUE``)``, collapse ``=`` ``""``)`\
`  ``)`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Created project:"``, ``project``$``id``, ``"\n"``)`

[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
returns the stored entity with the assigned Synapse ID in `project$id`.
In the new models API, IDs are accessed directly on the object
(`project$id`) rather than through `project$properties$id`.

## Create a Folder

Create a folder inside the project:

\
`data_folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(`\
`  name ``=`` ``"single_cell_RNAseq_batch_1"``,`\
`  parent_id ``=`` ``project``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Created folder:"``, ``data_folder``$``id``, ``"\n"``)`

## Upload a File

Create a local file and upload it to the folder.

\
`# Create a temporary file with some content`\
`tmp`` ``<-`` `[`tempfile`](https://rdrr.io/r/base/tempfile.html)`(``fileext ``=`` ``".txt"``)`\
[`writeLines`](https://rdrr.io/r/base/writeLines.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``"sample"``, ``"data"``)``, ``tmp``)`\
\
`file`` ``<-`` `[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(`\
`  path ``=`` ``tmp``,`\
`  parent_id ``=`` ``data_folder``$``id`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Uploaded file:"``, ``file``$``id``, ``"\n"``)`

Storing the same file path as an existing version does not create a
duplicate. Synapse detects unchanged content by MD5.

## Version the file

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``synapse_id ``=`` ``file``$``id``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    version_label   ``=`` ``"2"``,`\
`    version_comment ``=`` ``"Added version 2"`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## Add, Update and Remove Annotations

Use
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
to add, update, and remove annotations, then
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
to persist the changes. To modify annotations, you don’t have to
download the file. \### Add annotations to a file

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(`\
`  synapse_id ``=`` ``file``$``id``,`\
`  file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)`\
`)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    annotations ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(`\
`      assay ``=`` ``"RNA-seq"``, fileType ``=`` ``"csv"``, dataStage ``=`` ``"processed"`\
`    ``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

### Update annotations of a file

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(`\
`  synapse_id ``=`` ``file``$``id``,`\
`  file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)`\
`)`\
`file`` ``<-`` ``file`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    annotations ``=`` `[`append`](https://rdrr.io/r/base/append.html)`(``file``$``annotations``, `[`list`](https://rdrr.io/r/base/list.html)`(``new ``=`` ``"new_annotation"``)``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

### Remove annotations of a file

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(`\
`  synapse_id ``=`` ``file``$``id``,`\
`  file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)`\
`)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``annotations ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``)``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## Download a File

Retrieve a file by its Synapse ID. The file is downloaded to the local
cache `.synapseCache` by default. To set a download path, use
`FileOptions(download_location = "/path/to/downloads/")` in the
`file_options` parameter.

\
`downloaded_file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(`\
`  ``file``$``id``,`\
`  file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_location ``=`` ``"/path/to/downloads/"``)`\
`)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Downloaded to:"``, ``downloaded_file``$``path``, ``"\n"``)`

## Download a Specific Version

Use `version_number` to pin to a particular version:

\
`version_1`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``file``$``id``, version_number ``=`` ``1L``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Version 1 path:"``, ``version_1``$``path``, ``"\n"``)`

## Clean Up

Delete the project and all its contents when done:

\
[`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)`(``project``)`

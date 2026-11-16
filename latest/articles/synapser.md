# Synapse R Client Overview

## Overview

The `synapser` package provides an interface to
[Synapse](https://www.synapse.org), a collaborative workspace for
reproducible data intensive research projects, providing support for:

- integrated presentation of data, code and text
- fine grained access control
- provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](https://python-docs.synapse.org),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop/client/synapseJavaClient),
and [the web browser](https://www.synapse.org).

If you’re just getting started with `synapser`, have a look at the
[Getting Started](https://r-docs.synapse.org/latest/articles/index.md)
guides:
[Installation](https://r-docs.synapse.org/latest/articles/installation.md),
[Authentication](https://r-docs.synapse.org/latest/articles/authentication.md),
and
[Configuration](https://r-docs.synapse.org/latest/articles/configuration.md).

Good example projects are:

- [TCGA Pan-cancer
  (syn300013)](https://www.synapse.org/#!Synapse:syn300013)
- [Development of a Prognostic Model for Breast Cancer Survival in an
  Open Challenge Environment
  (syn1721874)](https://www.synapse.org/#!Synapse:syn1721874)
- [Demo projects
  (syn1899339)](https://www.synapse.org/#!Synapse:syn1899339)

This page gives a short tour of what you can do with `synapser`. Each
section links to a tutorial that covers the topic in depth.

## Installation

Install `synapser` from
[R-universe](https://sage-bionetworks.r-universe.dev/synapser):

``` r

install.packages(
  "synapser",
  repos = c("https://sage-bionetworks.r-universe.dev", "https://cloud.r-project.org")
)
```

Alternatively, edit your `~/.Rprofile` and configure your default
repositories:

``` r

options(repos = c("https://sage-bionetworks.r-universe.dev", "https://cloud.r-project.org"))
```

after which you may run `install.packages` without specifying the
repositories:

``` r

install.packages("synapser")
```

`synapser` sets up the Synapse Python client it needs the first time it
is loaded, so you don’t need to install Python yourself. On Linux,
complete the extra setup steps in the [Installation
vignette](https://r-docs.synapse.org/latest/articles/installation.md)
first. That vignette also covers installing from GitHub and installing
synapser 2.x and earlier, which remain on the Synapse R repository
(RAN). For troubleshooting, see the
[Troubleshooting](https://r-docs.synapse.org/latest/articles/troubleshooting.md)
guide.

If you’re upgrading from synapser 2.x, read [Migrating to synapser
3.0](https://r-docs.synapse.org/latest/articles/migration_to_synapser_3_0.md)
first.

## Connecting to Synapse

To use Synapse, you’ll need to
[register](https://www.synapse.org/#!RegisterAccount:0) for an account.
The Synapse website can authenticate using a Google account. If you
authenticate using a Google account, you’ll need to create a personal
access token to log in to Synapse through the programmatic clients. See
the [Authentication
vignette](https://r-docs.synapse.org/latest/articles/authentication.md)
for more information.

Once that’s done, you’ll be able to load the library and login:

``` r

library(synapser)
synLogin()
```

For more ways to manage your Synapse credentials, please see the
[Authentication
vignette](https://r-docs.synapse.org/latest/articles/authentication.md),
and the native reference documentation:

``` r

?synLogin
?synLogout
```

## Accessing Data

Synapse identifiers start with `syn`, followed by numbers (for example,
`syn123`). Upload a local file with
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md),
and download a file with
[`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md):

``` r

file <- File(path = "/path/to/data.csv", parent_id = "syn123") |> synStore()

downloaded_file <- synGet(
  file$id,
  file_options = FileOptions(download_location = "/path/to/downloads/")
)
downloaded_file$path
```

By default, files are downloaded to the Synapse cache. See [Data Upload,
Download, and
Delete](https://r-docs.synapse.org/latest/articles/data_upload_download.md)
and [Files](https://r-docs.synapse.org/latest/articles/file.md) for
more, including versioning. To move many files at once, see [Uploading
data in
bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md),
[Downloading data in
bulk](https://r-docs.synapse.org/latest/articles/download_data_in_bulk.md),
and [Downloading data by Synapse
ID](https://r-docs.synapse.org/latest/articles/download_data_by_synid.md).
The manifest file used for bulk uploads is described in [Manifest
CSV](https://r-docs.synapse.org/latest/articles/manifest_csv.md).

## Organizing Data in a Project

Projects and folders are containers that organize your data:

``` r

project <- Project(name = "My uniquely named project") |> synStore()
folder <- Folder(name = "raw_data", parent_id = project$id) |> synStore()
```

To list what a project or folder contains without downloading anything,
sync its metadata:

``` r

project <- project |> synSyncFromSynapse(download_file = FALSE, recursive = FALSE)
for (child in project$folders) {
  print(child$name)
}
```

See [Projects](https://r-docs.synapse.org/latest/articles/project.md),
[Folders](https://r-docs.synapse.org/latest/articles/folder.md), and
[Structuring Your Synapse
Project](https://r-docs.synapse.org/latest/articles/structuring_your_project.md).

## Annotating Synapse Entities

Annotations are key-value metadata that make your data searchable. Set
them with
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
and save them with
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):

``` r

file <- synGet(file$id, file_options = FileOptions(download_file = FALSE)) |>
  synSetProperties(annotations = list(assay = "RNA-seq", fileType = "csv")) |>
  synStore()
file$annotations
```

See
[Annotations](https://r-docs.synapse.org/latest/articles/annotation.md),
[Add, Update and Remove
Annotations](https://r-docs.synapse.org/latest/articles/data_upload_download.html#add-update-and-remove-annotations),
and [Properties and
annotations](https://r-docs.synapse.org/latest/articles/properties_vs_annotations.md).

## Provenance

Synapse’s provenance tools record what was used, and what was executed,
to create a file. Attach an `Activity` to an entity and store it:

``` r

file <- synGet(file$id, file_options = FileOptions(download_file = FALSE)) |>
  synSetProperties(
    activity = Activity(
      name = "clustering",
      description = "whizzy clustering",
      used = list(UsedEntity(target_id = "syn1234")),
      executed = list(UsedURL(name = "analysis code", url = "https://github.com/my-org/my-analysis"))
    )
  ) |>
  synStore()
```

See
[Activity/Provenance](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.html#activityprovenance)
and the `Activity` reference documentation
([`?Activity`](https://r-docs.synapse.org/latest/reference/Activity.md)).

## Tables

Synapse Tables store tabular data that can be queried using a SQL-like
query language. See
[Tables](https://r-docs.synapse.org/latest/articles/tables.md) and
[Virtual
Tables](https://r-docs.synapse.org/latest/articles/virtualtable.md).

## Datasets

A Dataset is a curated, versionable collection of files that can be
queried like a table. Group datasets into a Dataset Collection. See
[Datasets](https://r-docs.synapse.org/latest/articles/dataset.md) and
[Dataset
Collection](https://r-docs.synapse.org/latest/articles/datasetcollection.md).

## Wikis

Wiki pages let you describe your project and its data in Markdown:

``` r

wiki_page <- WikiPage(
  owner_id = project$id,
  title = "My Wiki Page",
  markdown = "# My Wiki Page\n\nThis is a wiki page."
) |> synStore()
```

See [Wikis](https://r-docs.synapse.org/latest/articles/wiki.md).

## Evaluations

An Evaluation is a queue that accepts and scores submissions, for
example in a computational challenge. Submit an entity to an evaluation
queue:

``` r

submission <- Submission(
  entity_id = file$id,
  evaluation_id = "9999999",
  name = "My Submission"
) |> synStore()
```

See
[Evaluations](https://r-docs.synapse.org/latest/articles/evaluation.md)
and [Submissions, SubmissionStatuses,
SubmissionBundles](https://r-docs.synapse.org/latest/articles/submission.md).

## Sharing Access to Content

By default, data you upload is private to you. Share it by setting
permissions for a user, a team, or everyone, for example to give the
public read access:

``` r

project |> synSetPermissions(principal_id = 273949L, access_type = list("READ"))
```

See [Sharing Settings (ACL
Management)](https://r-docs.synapse.org/latest/articles/sharing_settings.md)
and [Access
Control](https://r-docs.synapse.org/latest/articles/access_control.md).

## File Views

A file view can be defined by its scope. It allows querying for files
within the scope using a SQL-like syntax. Please visit the [EntityView
vignette](https://r-docs.synapse.org/latest/articles/entityview.md) for
more information.

## Accessing the API Directly

These methods enable access to the Synapse REST(ish) API taking care of
details like endpoints and authentication. See the [REST API
documentation](https://rest-docs.synapse.org/rest/).

``` r

?synRestGet
?synRestPost
?synRestPut
?synRestDelete
```

## Synapse Utilities

Utilities that used to live in the separate
[synapserutils](https://github.com/Sage-Bionetworks/synapserutils)
package are now available directly in `synapser`:

- Copy files, folders, and projects with `synCopy()`.
- Upload data to Synapse in bulk with `synSyncToSynapse()` (see
  [Uploading data in
  bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md)).
- Download data from Synapse in bulk with `synSyncFromSynapse()` (see
  [Downloading data in
  bulk](https://r-docs.synapse.org/latest/articles/download_data_in_bulk.md)).

## More information

For more information see the [Synapse User
Guide](https://docs.synapse.org/synapse-docs).

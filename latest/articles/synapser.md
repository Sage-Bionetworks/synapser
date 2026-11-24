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

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(`\
`  ``"synapser"``,`\
`  repos ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"https://sage-bionetworks.r-universe.dev"``, ``"https://cloud.r-project.org"``)`\
`)`

Alternatively, edit your `~/.Rprofile` and configure your default
repositories:

\
[`options`](https://rdrr.io/r/base/options.html)`(``repos ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"https://sage-bionetworks.r-universe.dev"``, ``"https://cloud.r-project.org"``)``)`

after which you may run `install.packages` without specifying the
repositories:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"synapser"``)`

`synapser` sets up the Synapse Python client it needs the first time it
is loaded, so you don’t need to install Python yourself. On Linux,
complete the extra setup steps in the
[Installation](https://r-docs.synapse.org/latest/articles/installation.md)
vignette first. That vignette also covers installing from GitHub and
installing synapser 2.x and earlier, which remain on the Synapse R
repository (RAN). For troubleshooting, see the
[Troubleshooting](https://r-docs.synapse.org/latest/articles/troubleshooting.md)
guide.

If you’re upgrading from synapser 2.x, read [Migrating to synapser
3.0](https://r-docs.synapse.org/latest/articles/migration_to_synapser_3_0.md)
first.

## Connecting to Synapse

To use Synapse, you’ll need to
[register](https://www.synapse.org/#!RegisterAccount:0) for an account.
To log in from R, create a [personal access
token](https://help.synapse.org/docs/Managing-Your-Account.2055405596.html#ManagingYourAccount-PersonalAccessTokens)
under your Synapse account settings. Give it at least the **view**
scope, and add **download** and **modify** if you want to download and
upload data.

Then load the library and log in with your token:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``authToken ``=`` ``"your_personal_access_token"``)`

To avoid putting your token in your code, save it in your
`~/.synapseConfig` file instead.
[`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md)
then finds it without any arguments. See the
[Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
vignette for how to set this up, and the reference documentation:

\
`?``synLogin`\
`?``synLogout`

## Accessing Data

Synapse identifiers start with `syn`, followed by numbers (for example,
`syn123`). Upload a local file with
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md),
and download a file with
[`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md):

\
`file`` ``<-`` `[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``path ``=`` ``"/path/to/data.csv"``, parent_id ``=`` ``"syn123"``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`downloaded_file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(`\
`  ``file``$``id``,`\
`  file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_location ``=`` ``"/path/to/downloads/"``)`\
`)`\
`downloaded_file``$``path`

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

\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(``name ``=`` ``"My uniquely named project"``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
`folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``name ``=`` ``"raw_data"``, parent_id ``=`` ``project``$``id``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

To list what a project or folder contains without downloading anything,
sync its metadata:

\
`project`` ``<-`` ``project`` ``|>`` ``synSyncFromSynapse``(``download_file ``=`` ``FALSE``, recursive ``=`` ``FALSE``)`\
`for`` ``(``child`` ``in`` ``project``$``folders``)`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``child``$``name``)`\
`}`

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

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``file``$``id``, file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``annotations ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``assay ``=`` ``"RNA-seq"``, fileType ``=`` ``"csv"``)``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
`file``$``annotations`

See
[Annotations](https://r-docs.synapse.org/latest/articles/annotation.md),
[Add, Update and Remove
Annotations](https://r-docs.synapse.org/latest/articles/data_upload_download.html#add-update-and-remove-annotations),
and [Properties and
annotations](https://r-docs.synapse.org/latest/articles/properties_vs_annotations.md).

## Provenance

Synapse’s provenance tools record what was used, and what was executed,
to create a file. Attach an `Activity` to an entity and store it:

\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``file``$``id``, file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    activity ``=`` `[`Activity`](https://r-docs.synapse.org/latest/reference/Activity.md)`(`\
`      name ``=`` ``"clustering"``,`\
`      description ``=`` ``"whizzy clustering"``,`\
`      used ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(`[`UsedEntity`](https://r-docs.synapse.org/latest/reference/UsedEntity.md)`(``target_id ``=`` ``"syn1234"``)``)``,`\
`      executed ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(`[`UsedURL`](https://r-docs.synapse.org/latest/reference/UsedURL.md)`(``name ``=`` ``"analysis code"``, url ``=`` ``"https://github.com/my-org/my-analysis"``)``)`\
`    ``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

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

\
`wiki_page`` ``<-`` `[`WikiPage`](https://r-docs.synapse.org/latest/reference/WikiPage.md)`(`\
`  owner_id ``=`` ``project``$``id``,`\
`  title ``=`` ``"My Wiki Page"``,`\
`  markdown ``=`` ``"# My Wiki Page\n\nThis is a wiki page."`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

See [Wikis](https://r-docs.synapse.org/latest/articles/wiki.md).

## Evaluations

An Evaluation is a queue that accepts and scores submissions, for
example in a computational challenge. Submit an entity to an evaluation
queue:

\
`submission`` ``<-`` `[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(`\
`  entity_id ``=`` ``file``$``id``,`\
`  evaluation_id ``=`` ``"9999999"``,`\
`  name ``=`` ``"My Submission"`\
`)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

See
[Evaluations](https://r-docs.synapse.org/latest/articles/evaluation.md)
and [Submissions, SubmissionStatuses,
SubmissionBundles](https://r-docs.synapse.org/latest/articles/submission.md).

## Sharing Access to Content

A new project is private to you, and the folders and files you add to it
inherit its sharing settings. To share, grant permissions to a user or
team by ID, or to one of these groups: `273948L` (all registered Synapse
users) or `273949L` (anyone on the internet). For example, let all
registered users view and download a project’s files:

\
`project`` ``|>`` ``synSetPermissions``(`\
`  principal_id ``=`` ``273948L``,`\
`  access_type ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"READ"``, ``"DOWNLOAD"``)`\
`)`

To give a folder or file different access from its project, call
`synSetPermissions()` on it directly. It then gets its own sharing
settings and stops inheriting from the project.

See [Sharing Settings (ACL
Management)](https://r-docs.synapse.org/latest/articles/sharing_settings.md)
and [Access
Control](https://r-docs.synapse.org/latest/articles/access_control.md).

## File Views

A file view can be defined by its scope. It allows querying for files
within the scope using a SQL-like syntax. Please visit the
[EntityView](https://r-docs.synapse.org/latest/articles/entityview.md)
vignette for more information.

## Accessing the API Directly

These methods enable access to the Synapse REST(ish) API taking care of
details like endpoints and authentication. See the [REST API
documentation](https://rest-docs.synapse.org/rest/).

\
`?``synRestGet`\
`?``synRestPost`\
`?``synRestPut`\
`?``synRestDelete`

## Synapse Utilities

Utilities that used to live in the separate
[synapserutils](https://github.com/Sage-Bionetworks/synapserutils)
package are now available directly in `synapser`:

- Copy files, folders, and projects with `synCopy()`.
- Walk the contents of a project or folder with `synWalk()`.
- Generate a manifest for a local directory with
  `synGenerateSyncManifest()`, then upload data to Synapse in bulk with
  `synSyncToSynapse()` (see [Uploading data in
  bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md)).
- Download data from Synapse in bulk with `synSyncFromSynapse()` (see
  [Downloading data in
  bulk](https://r-docs.synapse.org/latest/articles/download_data_in_bulk.md)).

## More information

For more information see the [Synapse User
Guide](https://docs.synapse.org/synapse-docs).

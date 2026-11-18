# synapser

**Important Note About the R Client**

We maintain the R client to support our R user community, recognizing R
as a foundational language in many data workflows. That said, the R
client is built on top of the Synapse Python client via the reticulate
package. This design allows us to solve complex engineering
problems—such as multi-threaded uploads/downloads and file caching—at
the Python layer and reuse those solutions in R.

While we aim to provide a reliable R experience, the dependency on
Python introduces installation nuances, especially around environment
management and package versions. If you encounter issues, we recommend
using the Python client directly, which is actively developed and more
broadly used.

We appreciate your patience and continued feedback as we work to improve
the user experience across both ecosystems.

**Introducing synapser 3.0.0**

synapser 3.0.0 is a major release built on version 4.14 of the Synapse
Python client. It introduces object-oriented models: create an instance
of a Synapse object, such as
`File(path = “data.csv”, parent_id = “syn123”)`, then pipe it into verb
functions like
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
and [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md).
It also brings:

- **No Python setup.** When synapser is loaded, reticulate installs a
  compatible Python and the Synapse Python client for you. Python 3.10
  to 3.14 is supported.
- **Current R dependencies.** synapser works with current versions of
  reticulate (1.44.0 or later) and rjson, and requires R 4.2.0 or later.

**This release is not backwards compatible.** Functions from earlier
versions, such as `synGetChildren()` and `synGetAnnotations()`, have
been removed. Before upgrading, see [Key differences from the legacy
API](https://r-docs.synapse.org/latest/articles/data_upload_download.html#key-differences-from-the-legacy-api)
for how earlier calls map to the new API, and [Supported Models and
Functions](#supported-models-and-functions) for what this release
supports.

## Introduction

The `synapser` package provides an interface to
[Synapse](http://www.synapse.org), a collaborative workspace for
reproducible data intensive research projects, providing support for:

- integrated presentation of data, code and text
- fine grained access control
- provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](https://python-docs.synapse.org/),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop),
and [the web browser](https://www.synapse.org).

## Supported Models and Functions

synapser 3.0.0 supports the following Synapse models. Each model’s
reference page also lists the functions that work on it, such as
`synGetAcl()`, `synSetPermissions()`, or `synSyncFromSynapse()`.

| Area | Models |
|----|----|
| Projects, folders, and files | [`Project`](https://r-docs.synapse.org/latest/reference/Project.md), [`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md), [`File`](https://r-docs.synapse.org/latest/reference/File.md), [`Link`](https://r-docs.synapse.org/latest/reference/Link.md) |
| Tables and views | [`Table`](https://r-docs.synapse.org/latest/reference/Table.md), [`Column`](https://r-docs.synapse.org/latest/reference/Column.md), [`JsonSubColumn`](https://r-docs.synapse.org/latest/reference/JsonSubColumn.md), [`VirtualTable`](https://r-docs.synapse.org/latest/reference/VirtualTable.md), [`EntityView`](https://r-docs.synapse.org/latest/reference/EntityView.md), [`MaterializedView`](https://r-docs.synapse.org/latest/reference/MaterializedView.md), [`SubmissionView`](https://r-docs.synapse.org/latest/reference/SubmissionView.md), [`Dataset`](https://r-docs.synapse.org/latest/reference/Dataset.md), [`DatasetCollection`](https://r-docs.synapse.org/latest/reference/DatasetCollection.md), [`EntityRef`](https://r-docs.synapse.org/latest/reference/EntityRef.md) |
| Provenance | [`Activity`](https://r-docs.synapse.org/latest/reference/Activity.md), [`UsedEntity`](https://r-docs.synapse.org/latest/reference/UsedEntity.md), [`UsedURL`](https://r-docs.synapse.org/latest/reference/UsedURL.md) |
| Wikis | [`WikiPage`](https://r-docs.synapse.org/latest/reference/WikiPage.md), [`WikiHeader`](https://r-docs.synapse.org/latest/reference/WikiHeader.md), [`WikiHistorySnapshot`](https://r-docs.synapse.org/latest/reference/WikiHistorySnapshot.md), [`WikiOrderHint`](https://r-docs.synapse.org/latest/reference/WikiOrderHint.md) |
| Challenges and evaluations | [`Evaluation`](https://r-docs.synapse.org/latest/reference/Evaluation.md), [`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md), [`SubmissionStatus`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md), [`SubmissionBundle`](https://r-docs.synapse.org/latest/reference/SubmissionBundle.md) |
| Users, teams, and organizations | [`Team`](https://r-docs.synapse.org/latest/reference/Team.md), [`UserProfile`](https://r-docs.synapse.org/latest/reference/UserProfile.md), [`UserPreference`](https://r-docs.synapse.org/latest/reference/UserPreference.md), [`Organization`](https://r-docs.synapse.org/latest/reference/Organization.md), [`JSONSchema`](https://r-docs.synapse.org/latest/reference/JSONSchema.md) |
| Storage | [`StorageLocation`](https://r-docs.synapse.org/latest/reference/StorageLocation.md), [`StorageLocationType`](https://r-docs.synapse.org/latest/reference/StorageLocationType.md) |
| AI agents | [`Agent`](https://r-docs.synapse.org/latest/reference/Agent.md), [`AgentSession`](https://r-docs.synapse.org/latest/reference/AgentSession.md), [`AgentPrompt`](https://r-docs.synapse.org/latest/reference/AgentPrompt.md) |

These functions work across models:

| Task | Functions |
|----|----|
| Connecting to Synapse | [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md), [`synLogout`](https://r-docs.synapse.org/latest/reference/synLogout.md), [`synSetEndpoints`](https://r-docs.synapse.org/latest/reference/synSetEndpoints.md) |
| Getting, storing, and deleting entities | [`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md), [`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md), [`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md), [`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md) |
| Options for getting and storing | [`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md), [`ActivityOptions`](https://r-docs.synapse.org/latest/reference/ActivityOptions.md), [`TableOptions`](https://r-docs.synapse.org/latest/reference/TableOptions.md), [`LinkOptions`](https://r-docs.synapse.org/latest/reference/LinkOptions.md), [`StoreFileOptions`](https://r-docs.synapse.org/latest/reference/StoreFileOptions.md), [`StoreContainerOptions`](https://r-docs.synapse.org/latest/reference/StoreContainerOptions.md), [`StoreTableOptions`](https://r-docs.synapse.org/latest/reference/StoreTableOptions.md), [`StoreJSONSchemaOptions`](https://r-docs.synapse.org/latest/reference/StoreJSONSchemaOptions.md), [`StoreGridOptions`](https://r-docs.synapse.org/latest/reference/StoreGridOptions.md) |
| Querying tables and views | [`synQuery`](https://r-docs.synapse.org/latest/reference/Table_Query.md), [`synQueryPartMask`](https://r-docs.synapse.org/latest/reference/Table_QueryPartMask.md) |
| Download list (cart) | [`synDownloadListAdd`](https://r-docs.synapse.org/latest/reference/synDownloadListAdd.md), [`synDownloadListRemove`](https://r-docs.synapse.org/latest/reference/synDownloadListRemove.md), [`synDownloadListClear`](https://r-docs.synapse.org/latest/reference/synDownloadListClear.md), [`synDownloadListManifest`](https://r-docs.synapse.org/latest/reference/synDownloadListManifest.md), [`synDownloadListFiles`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md), [`DownloadListItem`](https://r-docs.synapse.org/latest/reference/DownloadListItem.md) |
| Utilities | [`synFindEntityId`](https://r-docs.synapse.org/latest/reference/synFindEntityId.md), [`synIsSynapseId`](https://r-docs.synapse.org/latest/reference/synIsSynapseId.md), [`synOnweb`](https://r-docs.synapse.org/latest/reference/synOnweb.md), [`synPrintEntity`](https://r-docs.synapse.org/latest/reference/synPrintEntity.md), [`synMd5Query`](https://r-docs.synapse.org/latest/reference/synMd5Query.md), [`synSendMessage`](https://r-docs.synapse.org/latest/reference/synSendMessage.md) |
| REST API | [`synRestGet`](https://r-docs.synapse.org/latest/reference/synRestGet.md), [`synRestPost`](https://r-docs.synapse.org/latest/reference/synRestPost.md), [`synRestPut`](https://r-docs.synapse.org/latest/reference/synRestPut.md), [`synRestDelete`](https://r-docs.synapse.org/latest/reference/synRestDelete.md) |

See the [reference
index](https://r-docs.synapse.org/latest/reference/index.md) for the
full list.

## Requirements

- R version 4.2.0 or higher (tested up to R 4.6.1)
- reticulate 1.44.0 or higher
- [Synapse account](https://www.synapse.org/#!RegisterAccount:0)

**Note:** You do not need to install Python yourself. When `synapser` is
loaded it declares its Python requirement via
[`reticulate::py_require()`](https://rstudio.github.io/reticulate/reference/py_require.html),
and reticulate downloads a compatible Python and the Synapse Python
client into a managed environment on first use. If you would rather
point `synapser` at a Python environment you manage, it must be Python
3.10 to 3.14 — the range supported by synapseclient 4.14. See the
[install
guide](https://r-docs.synapse.org/latest/articles/installation.md) for
how reticulate chooses between the two.

## Documentation

Full documentation for `synapser` is on the [docs
site](https://r-docs.synapse.org/):

- [Reference](https://r-docs.synapse.org/reference/index.html): every
  model and function, organized by model.
- [Installation](https://r-docs.synapse.org/articles/installation.html),
  [Authentication](https://r-docs.synapse.org/articles/authentication.html),
  and
  [Configuration](https://r-docs.synapse.org/articles/configuration.html):
  get set up.
- [Tutorials](https://r-docs.synapse.org/articles/index.html): task
  guides for files, folders, tables, wikis, evaluations, and more.
- [Migrating to synapser
  3.0](https://r-docs.synapse.org/articles/migration_to_synapser_3_0.html):
  how to update scripts written for synapser 2.x.

**For Internal Testing:** the docs site may not show this version yet,
so build it locally: from the root of your synapser clone, run
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
and open `docs/index.html` in a browser.

## Installation

`synapser` is available as a ready-built package for Microsoft Windows
and Mac OSX. For Linux systems, it is available to install from source.
Please also check out our [System Dependencies
article](https://r-docs.synapse.org/latest/articles/systemDependencies.md)
for instructions on how to install system dependencies on Linux
environments.

[**Check out the dedicated install guide for additional
instructions**](https://r-docs.synapse.org/latest/articles/installation.md)

In short you may install `synapser` via:

**For Internal Testing:**

\
`# Install remotes if not already installed`\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"remotes"`](https://remotes.r-lib.org)`, quietly ``=`` ``TRUE``)``)`` ``{`\
`  `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"remotes"``)`\
`}`\
\
`remotes``::``install_github``(``"Sage-Bionetworks/synapser"``, ref ``=`` ``"SYNR-1649-upgrade-pythonclient-4-14"``)`

We recommend that you **DO NOT** update synapser’s dependencies during
installation.

### Release Candidate Installation (WIP)

If you have been asked to validate a release candidate, please use:

\
`remotes``::``install_github``(``"Sage-Bionetworks/synapser"``)`

\
`remotes``::``install_cran``(``"synapser"``, repos ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"http://staging-ran.synapse.org"``)``)`

### Troubleshooting Installation Issues (WIP)

If installation fails, please see our [Troubleshooting
vignette](https://r-docs.synapse.org/latest/articles/troubleshooting.md)
for detailed resolution steps. Note that the `rjson` and `reticulate`
version conflicts reported against synapser 2.x no longer apply: 3.0.0
works with current versions of both.

#### R Version Compatibility (WIP)

**Important**: synapser 3.0.0 requires R 4.2.0 or later. R 4.1.x is not
supported — it is the last Windows release with 32-bit (i386) multiarch,
and the version of `reticulate` that synapser requires does not build
for 32-bit Windows.

- **Check your R version**: Run `R.version.string` in R to see your
  current version
- **If your R is older than 4.2.0**: see [How to Upgrade
  R](#how-to-upgrade-r) below

Under the hood, `synapser` uses `reticulate` and the
synapsePythonClient. reticulate provisions a compatible Python for you
on first use, so you only need to install Python yourself if you prefer
to manage your own environment. See instructions below on
installing/upgrading Python.

## Usage

To get started, try logging into Synapse. If you don’t already have a
Synapse account, register [here](https://www.synapse.org/register):

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

Please visit the `synapser` [docs site](https://r-docs.synapse.org/) or
view our vignettes for using the `synapser` package:

\
[`browseVignettes`](https://rdrr.io/r/utils/browseVignettes.html)`(``package ``=`` ``"synapser"``)`

### Usage Examples

#### [knit2synapse](https://github.com/Sage-Bionetworks/knit2synapse)

Knit RMarkdown files to Synapse wikis

#### [syndccutils](https://github.com/Sage-Bionetworks/syndccutils)

Code for managing data coordinating operations (e.g., development of the
CSBC/PS-ON Knowledge Portal and individual Center pages) for
Sage-supported communities through Synapse.

## How to Upgrade Python

### On Windows

- Download the Python installer from the Official Website of Python
  [here](https://www.python.org/downloads/windows/).

- Install the Downloaded Python Installer

- check Install Python and Check the “Add python.ext to PATH”, then
  click on the “Install Now” button.

- Verify the Update

  ``` bash
  python --version
  ```

- `Note` If it still shows the old version, you may restart your system.
  Or uninstall the old version from the control panel.

### On macOS

- Both python 2x and 3x can stay installed in a MAC. Mac comes with
  python 2x version. To check the default python version in your MAC,
  open the terminal and type

  ``` bash
  python --version
  python3 --version
  ```

- If you don’t then go ahead and install it with the installer. Go the
  the python’s official site
  [here](https://www.python.org/downloads/mac-osx/).

- Now restart the terminal and check again with both commands python
  —version

  ``` bash
  python3 --version
  ```

- `Or` use to `install last version`

  ``` bash
  brew install python3 && cp /usr/local/bin/python3 /usr/local/bin/python
  ```

### On Linux

- Add the repository and update

  ``` bash
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt-get update
  ```

- Update the package list

  ``` bash
  apt-get update
  ```

- Verify the updated Python packages list

  ``` bash
  apt list | grep python3.10
  ```

- Install the Python 3.10 package using apt-get

  ``` bash
  sudo apt-get install python3.10
  ```

- Add Python 3.8 & Python 3.10 to update-alternatives

  ``` bash
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
  ```

- Update Python 3 for point to Python 3.10

  ``` bash
  sudo update-alternatives --config python3
  ```

## How to Upgrade R

- Verify R version
  - Open RStudio \> At the top of the Console you will see session info
    \> The first line tells you which version of R you are using.
  - `or` write in console \>‘R.version.string’ to print out the R
    version.
  - go to Tools \> Check for Package Updates. If there’s an update
    available for tidyverse, install it.

### On Windows

- To update R on Windows, try using the package installer (only for
  Windows).
- Got to Tools (at the top) \> Check for package updates. If tidyverse
  shows up on the list, select it, then click “Install Updates.”

### On Mac

- Go to [here](https://cloud.r-project.org/bin/macosx/).
- Click the link you need to update R pkg
- When the file finishes downloading, double-click to install. You
  should be able to click “Next” to all dialogs to finish the
  installation.
- From within RStudio, go to Help \> Check for Updates to install newer
  version of RStudio (if available, optional).
- To update packages, go to Tools \> Check for Package Updates. If
  updates are available, select All (or just tidyverse), and click
  Install Updates.

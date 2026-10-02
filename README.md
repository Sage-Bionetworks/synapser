
<!-- README.md is generated from README.Rmd. Please modify README.Rmd and run devtools::build_readme()` to update README.md -->

<div class="alert alert-primary" role="alert">

<strong>Important Note About the R Client</strong>

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

</div>

# synapser (WIP)

<div class="alert alert-info" role="alert">

<strong>Introducing synapser 3.0.0</strong>

synapser 3.0.0 is a major release built on version 4.14 of the Synapse
Python client. It introduces object-oriented models: create an instance
of a Synapse object, such as <code>File(path = “data.csv”, parent_id =
“syn123”)</code>, then pipe it into verb functions like
<code>synStore()</code> and <code>synGet()</code>. It also brings:

<ul>

<li>

<strong>No Python setup.</strong> When synapser is loaded, reticulate
installs a compatible Python and the Synapse Python client for you.
Python 3.10 to 3.14 is supported.
</li>

<li>

<strong>Current R dependencies.</strong> synapser works with current
versions of reticulate (1.44.0 or later) and rjson, and requires R 4.2.0
or later.
</li>

</ul>

<strong>This release is not backwards compatible.</strong> Functions
from earlier versions, such as <code>synGetChildren()</code> and
<code>synGetAnnotations()</code>, have been removed. Before upgrading,
see
<a href="articles/data_upload_download.html#key-differences-from-the-legacy-api">Key
differences from the legacy API</a> for how earlier calls map to the new
API, and <a href="#supported-models-and-functions">Supported Models and
Functions</a> for what this release supports.

</div>

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
[Python](https://python-docs.synapse.org/build/html/index.html),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop),
and [the web browser](https://www.synapse.org).

## Supported Models and Functions

synapser 3.0.0 supports the following Synapse models. Each model’s
reference page also lists the functions that work on it, such as
`synGetAcl()`, `synSetPermissions()`, or `synSyncFromSynapse()`.

| Area | Models |
|----|----|
| Projects, folders, and files | [`Project`](reference/Project.html), [`Folder`](reference/Folder.html), [`File`](reference/File.html), [`Link`](reference/Link.html) |
| Tables and views | [`Table`](reference/Table.html), [`Column`](reference/Column.html), [`VirtualTable`](reference/VirtualTable.html), [`EntityView`](reference/EntityView.html), [`MaterializedView`](reference/MaterializedView.html), [`SubmissionView`](reference/SubmissionView.html), [`DatasetCollection`](reference/DatasetCollection.html), [`EntityRef`](reference/EntityRef.html) |
| Provenance | [`Activity`](reference/Activity.html), [`UsedEntity`](reference/UsedEntity.html), [`UsedURL`](reference/UsedURL.html) |
| Wikis | [`WikiPage`](reference/WikiPage.html), [`WikiHeader`](reference/WikiHeader.html), [`WikiHistorySnapshot`](reference/WikiHistorySnapshot.html), [`WikiOrderHint`](reference/WikiOrderHint.html) |
| Challenges and evaluations | [`Evaluation`](reference/Evaluation.html), [`Submission`](reference/Submission.html), [`SubmissionStatus`](reference/SubmissionStatus.html), [`SubmissionBundle`](reference/SubmissionBundle.html) |
| Users, teams, and organizations | [`Team`](reference/Team.html), [`UserProfile`](reference/UserProfile.html), [`UserPreference`](reference/UserPreference.html), [`Organization`](reference/Organization.html) |
| Storage | [`StorageLocation`](reference/StorageLocation.html), [`StorageLocationType`](reference/StorageLocationType.html) |
| AI agents | [`Agent`](reference/Agent.html), [`AgentSession`](reference/AgentSession.html), [`AgentPrompt`](reference/AgentPrompt.html) |

The `Dataset`, `JSONSchema`, and `JsonSubColumn` models are also
available, but don’t have reference pages yet.

These functions work across models:

| Task | Functions |
|----|----|
| Connecting to Synapse | [`synLogin`](reference/synLogin.html), [`synLogout`](reference/synLogout.html), [`synSetEndpoints`](reference/synSetEndpoints.html) |
| Getting, storing, and deleting entities | [`synGet`](reference/synGet.html), [`synStore`](reference/synStore.html), [`synDelete`](reference/synDelete.html), [`synSetProperties`](reference/synSetProperties.html) |
| Options for getting and storing | [`FileOptions`](reference/FileOptions.html), [`ActivityOptions`](reference/ActivityOptions.html), [`TableOptions`](reference/TableOptions.html), [`LinkOptions`](reference/LinkOptions.html), [`StoreFileOptions`](reference/StoreFileOptions.html), [`StoreContainerOptions`](reference/StoreContainerOptions.html), [`StoreTableOptions`](reference/StoreTableOptions.html), [`StoreJSONSchemaOptions`](reference/StoreJSONSchemaOptions.html), [`StoreGridOptions`](reference/StoreGridOptions.html) |
| Querying tables and views | [`synQuery`](reference/Table_Query.html), [`synQueryPartMask`](reference/Table_QueryPartMask.html) |
| Download list (cart) | [`synDownloadListAdd`](reference/synDownloadListAdd.html), [`synDownloadListRemove`](reference/synDownloadListRemove.html), [`synDownloadListClear`](reference/synDownloadListClear.html), [`synDownloadListManifest`](reference/synDownloadListManifest.html), [`synDownloadListFiles`](reference/synDownloadListFiles.html), [`DownloadListItem`](reference/DownloadListItem.html) |
| Utilities | [`synFindEntityId`](reference/synFindEntityId.html), [`synIsSynapseId`](reference/synIsSynapseId.html), [`synOnweb`](reference/synOnweb.html), [`synPrintEntity`](reference/synPrintEntity.html), [`synMd5Query`](reference/synMd5Query.html), [`synSendMessage`](reference/synSendMessage.html) |
| REST API | [`synRestGet`](reference/synRestGet.html), [`synRestPost`](reference/synRestPost.html), [`synRestPut`](reference/synRestPut.html), [`synRestDelete`](reference/synRestDelete.html) |

See the [reference index](reference/index.html) for the full list.

## Requirements

- R version 4.2.0 or higher (tested up to R 4.6.1)
- reticulate 1.44.0 or higher
- [Synapse account](https://www.synapse.org/#!RegisterAccount:0)

**Note:** You do not need to install Python yourself. When `synapser` is
loaded it declares its Python requirement via
`reticulate::py_require()`, and reticulate downloads a compatible Python
and the Synapse Python client into a managed environment on first use.
If you would rather point `synapser` at a Python environment you manage,
it must be Python 3.10 to 3.14 — the range supported by synapseclient
4.12. See the [install guide](articles/installation.html) for how
reticulate chooses between the two.

## Installation

`synapser` is available as a ready-built package for Microsoft Windows
and Mac OSX. For Linux systems, it is available to install from source.
Please also check out our [System Dependencies
article](articles/systemDependencies.html) for instructions on how to
install system dependencies on Linux environments.

[**Check out the dedicated install guide for additional
instructions**](articles/installation.html)

In short you may install `synapser` via:

**For Internal Testing:**

``` r
# Install remotes if not already installed
if (!require("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("Sage-Bionetworks/synapser", ref = "SYNR-1649-upgrade-pythonclient-4-14")
```

We recommend that you **DO NOT** update synapser’s dependencies during
installation.

### Release Candidate Installation (WIP)

If you have been asked to validate a release candidate, please use:

``` r
remotes::install_github("Sage-Bionetworks/synapser")
```

``` r
remotes::install_cran("synapser", repos = c("http://staging-ran.synapse.org"))
```

### Troubleshooting Installation Issues (WIP)

If installation fails, please see our [Troubleshooting
vignette](./articles/troubleshooting.html) for detailed resolution
steps. Note that the `rjson` and `reticulate` version conflicts reported
against synapser 2.x no longer apply: 3.0.0 works with current versions
of both.

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

``` r
library(synapser)
synLogin()
```

Please visit the `synapser` [docs site](https://r-docs.synapse.org/) or
view our vignettes for using the `synapser` package:

``` r
browseVignettes(package = "synapser")
```

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

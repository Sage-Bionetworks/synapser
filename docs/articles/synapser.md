# Synapse R Client Overview

## Overview

The `synapser` package provides an interface to
[Synapse](http://www.synapse.org), a collaborative workspace for
reproducible data intensive research projects, providing support for:

- integrated presentation of data, code and text
- fine grained access control
- provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](http://docs.synapse.org/python),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop/client/synapseJavaClient),
and [the web browser](https://www.synapse.org).

If you’re just getting started with Synapse, have a look at the [Getting
Started guides for
Synapse](http://docs.synapse.org/articles/getting_started.md).

Good example projects are:

- [TCGA Pan-cancer
  (syn300013)](https://www.synapse.org/#!Synapse:syn300013)
- [Development of a Prognostic Model for Breast Cancer Survival in an
  Open Challenge Environment
  (syn1721874)](https://www.synapse.org/#!Synapse:syn1721874)
- [Demo projects
  (syn1899339)](https://www.synapse.org/#!Synapse:syn1899339)

## Installation

`synapser` is available as a ready-built package for Microsoft Windows
and Mac OSX. For Linux systems, it is available to install from source.

### Recommended Installation Method

We recommend using the `remotes` package to install synapser, which will
automatically handle the specific dependency versions:

**Install Latest Version:**

``` r
# Install remotes if not already installed
if (!require("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install the latest version of synapser (automatically installs compatible dependency versions)
remotes::install_cran("synapser", repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```

**Install Specific Version:**

``` r
# Install remotes if not already installed
if (!require("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install a specific version of synapser (e.g., version 2.1.1.259 - major.minor.patch.build)
remotes::install_version("synapser", version = "X.Y.Z.AAA", repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```

### Alternative Installation with Manual Dependency Management

If you prefer to manage dependencies manually before using the standard
installation:

``` r
# Install remotes if not already installed
if (!require("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install specific versions of dependencies to avoid conflicts
remotes::install_version("rjson", "0.2.21")
remotes::install_version("reticulate", "1.28")

# Install synapser
install.packages("synapser", repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```

### Alternative Simple Installation

If you don’t have dependency conflicts, you can try the simple
installation method:

``` r
install.packages("synapser", repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```

Alternatively, edit your `~/.Rprofile` and configure your default
repositories:

``` r
options(repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```

after which you may run `install.packages` without specifying the
repositories:

``` r
install.packages("synapser")
```

**Important:** Synapser requires Python 3.9 to 3.11 (we recommend Python
3.10). For detailed installation instructions see [installation
vignette](https://r-docs.synapse.org/articles/installation.md). For
troubleshooting dependency conflicts, please refer to the
[Troubleshooting](https://r-docs.synapse.org/articles/troubleshooting.md)
guide.

## Connecting to Synapse

To use Synapse, you’ll need to
[register](https://www.synapse.org/#!RegisterAccount:0) for an account.
The Synapse website can authenticate using a Google account. If you
authenticate using a Google account, you’ll need to create a personal
access token to log in to Synapse through the programmatic clients. See
the [Manage Synapse Credentials
vignette](https://r-docs.synapse.org/articles/manageSynapseCredentials.md)
for more information.

Once that’s done, you’ll be able to load the library and login:

``` r
library(synapser)
## 
## TERMS OF USE NOTICE:
##   When using Synapse, remember that the terms and conditions of use require that you:
##   1) Attribute data contributors when discussing these data or results from these data.
##   2) Not discriminate, identify, or recontact individuals or groups represented by the data.
##   3) Use and contribute only data de-identified to HIPAA standards.
##   4) Redistribute data only under these same terms of use.
synLogin()
## NULL
```

For more ways to manage your Synapse credentials, please see the [Manage
Synapse Credentials
vignette](https://r-docs.synapse.org/articles/manageSynapseCredentials.md),
and the native reference documentation:

``` r
?synLogin
?synLogout
```

## Accessing Data

To make the example below print useful information, we prepare a file:

``` r
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)

# Create some files
filePath <- tempfile()
connection <- file(filePath)
writeChar("a \t b \t c \n d \t e \t f \n", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = project)
# Add a version comment
file$properties$versionComment <- 'Some sort of comment about the new version of the file.'
file <- synStore(file)
synId <- file$properties$id
```

Synapse identifiers are used to refer to projects and data which are
represented by *entity* objects. For example, the entity above
represents a tab-delimited file containing a 2 by 3 matrix. Getting the
entity retrieves an object that holds metadata describing the matrix,
and also downloads the file to a local cache:

``` r
fileEntity <- synGet(synId)
```

View the entity’s metadata in the R console:

``` r
print(fileEntity)
## File(isLatestVersion=True, _file_handle={'id': '170773016', 'etag': 'fb48e7db-382b-4f0c-b291-fa99d354c6c1', 'createdBy': '3324230', 'createdOn': '2026-04-06T17:32:57.000Z', 'modifiedOn': '2026-04-06T17:32:57.000Z', 'concreteType': 'org.sagebionetworks.repo.model.file.S3FileHandle', 'contentType': 'application/octet-stream', 'contentMd5': '8465d33d9f407ef250ce519e92f300fb', 'fileName': 'file516955b769be', 'storageLocationId': 1, 'contentSize': 23, 'status': 'AVAILABLE', 'bucketName': 'proddata.sagebase.org', 'key': '3324230/ab662231-01f3-4f40-91a3-f57a9d18add8/file516955b769be', 'isPreview': False, 'externalURL': None}, etag='fec7382c-7f58-4b79-a40f-eef8440b7196', dataFileHandleId='170773016', id='syn74360929', versionLabel='1', versionNumber=1, createdOn='2026-04-06T17:32:57.679Z', modifiedBy='3324230', createdBy='3324230', concreteType='org.sagebionetworks.repo.model.FileEntity', files=['file516955b769be'], synapseStore=True, parentId='syn74360928', versionComment='Some sort of comment about the new version of the file.', cacheDir='/var/folders/67/ghxb0p_j4r5gjj95l9z3502c0000gq/T/Rtmp7NKByR', path='/var/folders/67/ghxb0p_j4r5gjj95l9z3502c0000gq/T/Rtmp7NKByR/file516955b769be', modifiedOn='2026-04-06T17:32:57.679Z', name='file516955b769be')
```

This is one simple way to read in a small matrix (we load just the first
few rows):

``` r
read.table(fileEntity$path, nrows = 2)
##   V1 V2 V3
## 1  a  b  c
## 2  d  e  f
```

View the entity in the browser:

``` r
synOnweb(synId)
```

### Download Location

By default the download location will always be in the Synapse cache.
You can specify the downloadLocation parameter.

``` r
entity <- synGet("syn00123", downloadLocation = "/path/to/folder")
```

For more details see the native reference documentation, e.g.:

``` r
?synGet
?synOnweb
```

## Organizing Data in a Project

You can create your own projects and upload your own data sets. Synapse
stores entities in a hierarchical or tree structure. Projects are at the
top level and must be uniquely named:

``` r
project <- Project(projectName)
project <- synStore(project)
```

Creating a folder:

``` r
dataFolder <- Folder("Data", parent = project)
dataFolder <- synStore(dataFolder)
```

Adding files to the project:

``` r
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = dataFolder)
file <- synStore(file)
```

You can print the properties of an entity (such as the file we just
created):

``` r
file$properties
## Dict (13 items)
```

Most other properties are immutable, but you *can* change an entity’s
name:

``` r
file$properties$name <- "different name"
```

Update Synapse with the change:

``` r
file <- synStore(file)
file$properties
## Dict (13 items)
```

You can list all children of an entity:

``` r
children <- synGetChildren(project$properties$id)
as.list(children)
## [[1]]
## [[1]]$name
## [1] "Data"
## 
## [[1]]$id
## [1] "syn74360930"
## 
## [[1]]$type
## [1] "org.sagebionetworks.repo.model.Folder"
## 
## [[1]]$versionNumber
## [1] 1
## 
## [[1]]$versionLabel
## [1] "1"
## 
## [[1]]$isLatestVersion
## [1] TRUE
## 
## [[1]]$benefactorId
## [1] 74360928
## 
## [[1]]$createdOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## [[1]]$modifiedOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## [[1]]$createdBy
## [1] "3324230"
## 
## [[1]]$modifiedBy
## [1] "3324230"
## 
## 
## [[2]]
## [[2]]$name
## [1] "file516955b769be"
## 
## [[2]]$id
## [1] "syn74360929"
## 
## [[2]]$type
## [1] "org.sagebionetworks.repo.model.FileEntity"
## 
## [[2]]$versionNumber
## [1] 1
## 
## [[2]]$versionLabel
## [1] "1"
## 
## [[2]]$isLatestVersion
## [1] TRUE
## 
## [[2]]$benefactorId
## [1] 74360928
## 
## [[2]]$createdOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## [[2]]$modifiedOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## [[2]]$createdBy
## [1] "3324230"
## 
## [[2]]$modifiedBy
## [1] "3324230"
```

You can also filter by type:

``` r
filesAndFolders <- synGetChildren(project$properties$id, includeTypes = c("file", "folder"))
as.list(filesAndFolders)
## [[1]]
## [[1]]$name
## [1] "Data"
## 
## [[1]]$id
## [1] "syn74360930"
## 
## [[1]]$type
## [1] "org.sagebionetworks.repo.model.Folder"
## 
## [[1]]$versionNumber
## [1] 1
## 
## [[1]]$versionLabel
## [1] "1"
## 
## [[1]]$isLatestVersion
## [1] TRUE
## 
## [[1]]$benefactorId
## [1] 74360928
## 
## [[1]]$createdOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## [[1]]$modifiedOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## [[1]]$createdBy
## [1] "3324230"
## 
## [[1]]$modifiedBy
## [1] "3324230"
## 
## 
## [[2]]
## [[2]]$name
## [1] "file516955b769be"
## 
## [[2]]$id
## [1] "syn74360929"
## 
## [[2]]$type
## [1] "org.sagebionetworks.repo.model.FileEntity"
## 
## [[2]]$versionNumber
## [1] 1
## 
## [[2]]$versionLabel
## [1] "1"
## 
## [[2]]$isLatestVersion
## [1] TRUE
## 
## [[2]]$benefactorId
## [1] 74360928
## 
## [[2]]$createdOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## [[2]]$modifiedOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## [[2]]$createdBy
## [1] "3324230"
## 
## [[2]]$modifiedBy
## [1] "3324230"
```

You can avoid reading all children into memory at once by iterating
through one at a time:

``` r
children <- synGetChildren(project$properties$id)
tryCatch({
  while (TRUE) {
    child <- nextElem(children)
    print(child)
  }
}, error = function(e) {
    print("Reached end of list.")
})
## $name
## [1] "Data"
## 
## $id
## [1] "syn74360930"
## 
## $type
## [1] "org.sagebionetworks.repo.model.Folder"
## 
## $versionNumber
## [1] 1
## 
## $versionLabel
## [1] "1"
## 
## $isLatestVersion
## [1] TRUE
## 
## $benefactorId
## [1] 74360928
## 
## $createdOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## $modifiedOn
## [1] "2026-04-06T17:32:58.669Z"
## 
## $createdBy
## [1] "3324230"
## 
## $modifiedBy
## [1] "3324230"
## 
## $name
## [1] "file516955b769be"
## 
## $id
## [1] "syn74360929"
## 
## $type
## [1] "org.sagebionetworks.repo.model.FileEntity"
## 
## $versionNumber
## [1] 1
## 
## $versionLabel
## [1] "1"
## 
## $isLatestVersion
## [1] TRUE
## 
## $benefactorId
## [1] 74360928
## 
## $createdOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## $modifiedOn
## [1] "2026-04-06T17:32:57.679Z"
## 
## $createdBy
## [1] "3324230"
## 
## $modifiedBy
## [1] "3324230"
## 
## [1] "Reached end of list."
```

You can move files to a different parent:

``` r
newFolder <- Folder("New Parent", parent = project)
newFolder <- synStore(newFolder)

file <- synMove(file, newFolder)
```

Content can be deleted:

``` r
synDelete(file)
## NULL
```

Deletion of a project will also delete its contents, in this case the
folder:

``` r
folderId <- dataFolder$properties$id
synDelete(project)
## NULL
tryCatch(
  synGet(folderId),
  error = function(e) {
    message(sprintf("Retrieving a deleted folder causes: %s", as.character(e)))
  },
  silent = TRUE
)
## Retrieving a deleted folder causes: Error in value[[3L]](cond): 404 Client Error: 
## Entity syn74360930 is in trash can.
```

In addition to simple data storage, Synapse entities can be annotated
with key/value metadata, described in markdown documents (wikis), and
linked together in provenance graphs to create a reproducible record of
a data analysis pipeline.

For more details see the native reference documentation, e.g.:

``` r
?Project
?Folder
?File
?Link
?synStore
```

## Annotating Synapse Entities

``` r
# (We use a time stamp just to help ensure uniqueness.)
projectName <- sprintf("My unique project created on %s", format(Sys.time(), "%a %b %d %H%M%OS4 %Y"))
project <- Project(projectName)
# This will erase all existing annotations
project$annotations <- list(annotationName = "annotationValue")
project <- synStore(project)
```

``` r
project <- synGet(project$properties$id)
project$annotations
## {
##   "annotationName": [
##     "annotationValue"
##   ]
## }
synGetAnnotations(project)
## $annotationName
## [1] "annotationValue"
```

## Provenance

Synapse provides tools for tracking ‘provenance’, or the transformation
of raw data into processed results, by linking derived data objects to
source data and the code used to perform the transformation.

The Activity object represents the source of a data set or the data
processing steps used to produce it. Using [W3C
provenance](http://www.w3.org/2011/prov/wiki/Main_Page) ontology terms,
a result is generated by a combination of data and code which are either
used or executed.

### Creating an activity object:

``` r
act <- Activity(
  name = "clustering",
  description = "whizzy clustering",
  used = c("syn1234", "syn1235"),
  executed = "syn4567")
```

Here, syn1234 and syn1235 might be two types of measurements on a common
set of samples. Some whizzy clustering code might be referred to by
syn4567.

Alternatively, you can build an activity up piecemeal:

``` r
act <- Activity(name = "clustering", description = "whizzy clustering")
act$used(c("syn12345", "syn12346"))
act$executed("syn4567")
```

The used and executed can reference entities in Synapse or URLs.

Entity examples:

``` r
  act$used("syn12345")
  act$used(project)
  act$used(target = "syn12345", targetVersion = 2)
```

URL examples:

``` r
  act$used("http://mydomain.com/my/awesome/data.RData")
  act$used(url = "http://mydomain.com/my/awesome/data.RData", name = "Awesome Data")
  act$used(url = "https://github.com/joe_hacker/code_repo", name = "Gnarly hacks", wasExecuted = TRUE)
```

### Storing entities with provenance

The activity can be passed in when storing an Entity to set the Entity’s
provenance:

``` r
project <- synGet(project$properties$id)
project <- synStore(project, activity = act)
```

We’ve now recorded that ‘project’ is the output of syn4567 applied to
the data stored in syn1234 and syn1235.

### Recording data source

The synStore() has shortcuts for specifying the used and executed lists
directly. For example, when storing a data entity, it’s a good idea to
record its source:

``` r
project <- synStore(
  project,
  activityName = "data-r-us",
  activityDescription = "downloaded from data-r-us",
  used = "http://data-r-us.com/excellent/data.xyz")
```

For more information:

``` r
?Activity
?synDeleteProvenance
```

## Tables

Tables can be built up by adding sets of rows that follow a user-defined
schema and queried using a SQL-like syntax. Please visit the [Table
vignettes](https://r-docs.synapse.org/articles/tables.md) for more
information.

## Wikis

Wiki pages can be attached to an Synapse entity (i.e. project, folder,
file, etc). Text and graphics can be composed in markdown and rendered
in the web view of the object.

Creating a Wiki

``` r
project <- synGet(project$properties$id)
content <- "
# My Wiki Page

Here is a description of my **fantastic** project!
"
# attachment
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)

wiki <- Wiki(owner = project,
             title = "My Wiki Page",
             markdown = content,
             attachments = list(filePath))
wiki <- synStore(wiki)
```

Updating a Wiki

``` r
project <- synGet(project$properties$id)
wiki <- synGetWiki(project)
wiki.markdown <- "
# My Wiki Page

Here is a description of my **fantastic** project! Let's
*emphasize* the important stuff.
"

wiki <- synStore(wiki)
```

For more information:

``` r
?Wiki
?synGetWiki
```

## Evaluations

An Evaluation is a Synapse construct useful for building processing
pipelines and for scoring predictive modeling and data analysis
challenges.

Creating an Evaluation:

``` r
eval <- Evaluation(
  name = sprintf("My unique evaluation created on %s", format(Sys.time(), "%a %b %d %H%M%OS4 %Y")),
  description = "testing",
  contentSource = project$properties$id,
  submissionReceiptMessage = "Thank you for your submission!",
  submissionInstructionsMessage = "This evaluation only accepts files.")
eval <- synStore(eval)
```

Retrieving the created Evaluation:

``` r
eval <- synGetEvaluation(eval$id)
eval
## {
##   "contentSource": "syn74360933",
##   "createdOn": "2026-04-06T17:33:11.287Z",
##   "description": "testing",
##   "etag": "7510884a-99a4-440b-b15b-8d28d2c0b2df",
##   "id": "9619530",
##   "name": "My unique evaluation created on Mon Apr 06 103311.1843 2026",
##   "ownerId": "3324230",
##   "submissionInstructionsMessage": "This evaluation only accepts files.",
##   "submissionReceiptMessage": "Thank you for your submission!"
## }
```

Submitting a file to an existing Evaluation:

``` r
# first create a file to submit
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is my first submission", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = project)
file <- synStore(file)
# submit the created file
submission <- synSubmit(eval, file)
```

List submissions:

``` r
submissions <- synGetSubmissionBundles(eval)
as.list(submissions)
## [[1]]
## [[1]][[1]]
## {
##   "contributors": [
##     {
##       "createdOn": "2026-04-06T17:33:13.745Z",
##       "principalId": "3324230"
##     }
##   ],
##   "createdOn": "2026-04-06T17:33:13.745Z",
##   "entityBundleJSON": "{\"entity\":{\"name\":\"file51693131c55e\",\"id\":\"syn74360934\",\"etag\":\"93921562-fe19-4653-891c-1e1466f9cdd2\",\"createdOn\":\"2026-04-06T17:33:13.307Z\",\"modifiedOn\":\"2026-04-06T17:33:13.307Z\",\"createdBy\":\"3324230\",\"modifiedBy\":\"3324230\",\"parentId\":\"syn74360933\",\"concreteType\":\"org.sagebionetworks.repo.model.FileEntity\",\"versionNumber\":1,\"versionLabel\":\"1\",\"isLatestVersion\":true,\"dataFileHandleId\":\"170773025\"},\"entityType\":\"file\",\"annotations\":{\"id\":\"syn74360934\",\"etag\":\"00000000-0000-0000-0000-000000000000\",\"annotations\":{}},\"fileHandles\":[{\"id\":\"170773025\",\"etag\":\"24e6a6d9-e15e-4089-8416-5cf3a966cfeb\",\"createdBy\":\"3324230\",\"createdOn\":\"2026-04-06T17:33:13.000Z\",\"modifiedOn\":\"2026-04-06T17:33:13.000Z\",\"concreteType\":\"org.sagebionetworks.repo.model.file.S3FileHandle\",\"contentType\":\"application/octet-stream\",\"contentMd5\":\"3f466b7f85d184292a68cea1c4f7cfc2\",\"fileName\":\"file51693131c55e\",\"storageLocationId\":1,\"contentSize\":27,\"status\":\"AVAILABLE\",\"bucketName\":\"proddata.sagebase.org\",\"key\":\"3324230/229b00bb-7c5c-4148-9967-4bae2c9ac09e/file51693131c55e\",\"isPreview\":false}]}",
##   "entityId": "syn74360934",
##   "evaluationId": "9619530",
##   "id": "9765998",
##   "name": "file51693131c55e",
##   "userId": "3324230",
##   "versionNumber": 1
## }
## 
## [[1]][[2]]
## {
##   "entityId": "syn74360934",
##   "etag": "b0f302cf-1b3b-470c-9bd1-b101e791b952",
##   "id": "9765998",
##   "modifiedOn": "2026-04-06T17:33:13.745Z",
##   "status": "RECEIVED",
##   "statusVersion": 0,
##   "submissionAnnotations": {},
##   "versionNumber": 1
## }
```

Retrieving submission by id:

``` r
# Not evaluating this section because of SYNPY-235
submission <- synGetSubmission(submission$id)
submission
```

Retrieving the submission status:

``` r
submissionStatus <- synGetSubmissionStatus(submission)
submissionStatus
## {
##   "entityId": "syn74360934",
##   "etag": "b0f302cf-1b3b-470c-9bd1-b101e791b952",
##   "id": "9765998",
##   "modifiedOn": "2026-04-06T17:33:13.745Z",
##   "status": "RECEIVED",
##   "statusVersion": 0,
##   "submissionAnnotations": {},
##   "versionNumber": 1
## }
```

To view the annotations:

``` r
submissionStatus$submissionAnnotations
## {}
```

To update an annotation:

``` r
submissionStatus$annotations["doubleAnnos"] <- list(c("rank" = 3))
synStore(submissionStatus)
```

For more information, please see:

``` r
?synGetEvaluation
?synSubmit
?synGetSubmissionBundles
?synGetSubmission
?synGetSubmissionStatus
```

## Sharing Access to Content

By default, data sets in Synapse are private to your user account, but
they can easily be shared with specific users, groups, or the public.

Retrieve the sharing setting on an entity:

``` r
synGetAcl(project, principal_id = "273950")
## list()
```

The first time an entity is shared, an ACL object is created for that
entity. Let’s make project public:

``` r
acl <- synSetPermissions(project, principalId = 273949, accessType = list("READ"))
acl
## $id
## [1] "syn74360933"
## 
## $creationDate
## [1] "2026-04-06T17:33:04.287Z"
## 
## $etag
## [1] "91736488-f812-4a19-9dee-1b563b12699e"
## 
## $resourceAccess
## $resourceAccess[[1]]
## $resourceAccess[[1]]$principalId
## [1] 273949
## 
## $resourceAccess[[1]]$accessType
## [1] "READ"
## 
## 
## $resourceAccess[[2]]
## $resourceAccess[[2]]$principalId
## [1] 3324230
## 
## $resourceAccess[[2]]$accessType
## [1] "DELETE"             "READ"               "CHANGE_SETTINGS"   
## [4] "CREATE"             "DOWNLOAD"           "MODERATE"          
## [7] "UPDATE"             "CHANGE_PERMISSIONS"
```

Now public can read:

``` r
synGetAcl(project, principal_id = 273950)
## [1] "READ"
```

Get permissions will obtain more human-readable view of an entity’s
permissions

``` r
permissions = synGetPermissions(project)
permissions$can_view
## [1] TRUE
```

``` r
?synGetAcl
?synSetPermissions
?synGetPermissions
```

``` r
synDelete(project)
## NULL
```

## File Views

A file view can be defined by its scope. It allows querying for
FileEntity within the scope using a SQL-like syntax. Please visit the
[Views vignettes](https://r-docs.synapse.org/articles/views.md) for more
information.

## Accessing the API Directly

These methods enable access to the Synapse REST(ish) API taking care of
details like endpoints and authentication. See the [REST API
documentation](NA).

``` r
?synRestGET
?synRestPOST
?synRestPUT
?synRestDELETE
```

## Synapse Utilities

We provide some utility functions in the
[synapserutils](https://github.com/Sage-Bionetworks/synapserutils)
package:

- Copy Files, Folders, Tables, Links, Projects, and Wiki Pages.
- Upload data to Synapse in bulk.
- Download data from Synapse in bulk.

Please visit the [synapserutils Github
repository](https://github.com/Sage-Bionetworks/synapserutils) for
instructions on how to download.

## More information

For more information see the [Synapse User
Guide](https://docs.synapse.org/synapse-docs).

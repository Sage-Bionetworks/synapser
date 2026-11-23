# Changelog

## synapser 3.0.0

synapser 3.0.0 is a major release and is not backwards compatible with
2.x. Most existing scripts need updates; see the [Migrating to synapser
3.0](https://r-docs.synapse.org/articles/migration_to_synapser_3_0.html)
vignette.

### Breaking Changes

- Object-oriented models. Build an instance, then pipe it into verbs:
  `File(path = "data.csv", parent_id = "syn123") |> synStore()`. Same
  shape for every entity type, with **snake_case** arguments matching
  the Python client field-for-field (for example, `parentId` is now
  `parent_id`).
- `entity$properties` has been removed. Read properties directly from
  the object, for example `entity$id` instead of `entity$properties$id`.
  To change properties or annotations, use
  [`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
  and then
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):
  `entity |> synSetProperties(name = "new name", annotations = list(key = "value")) |> synStore()`.
  Setting `annotations` replaces all existing annotations.
- [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md),
  [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md)
  and
  [`synDelete()`](https://r-docs.synapse.org/latest/reference/synDelete.md)
  now take settings as fields on the entity or as options objects
  instead of loose arguments.
- `EntityViewSchema`, `MaterializedViewSchema` and
  `SubmissionViewSchema` are now `EntityView`, `MaterializedView` and
  `SubmissionView`.
- Many 2.x functions have been removed or renamed, for example
  `synTableQuery()` is now `synQuery()`, `synCreateSnapshotVersion()` is
  now `synSnapshot()`, and `synRestGET()` and its siblings are now
  [`synRestGet()`](https://r-docs.synapse.org/latest/reference/synRestGet.md),
  [`synRestPost()`](https://r-docs.synapse.org/latest/reference/synRestPost.md),
  [`synRestPut()`](https://r-docs.synapse.org/latest/reference/synRestPut.md)
  and
  [`synRestDelete()`](https://r-docs.synapse.org/latest/reference/synRestDelete.md).
  The download list functions are now
  [`synDownloadListRemove()`](https://r-docs.synapse.org/latest/reference/synDownloadListRemove.md),
  [`synDownloadListClear()`](https://r-docs.synapse.org/latest/reference/synDownloadListClear.md),
  [`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md)
  and
  [`synDownloadListManifest()`](https://r-docs.synapse.org/latest/reference/synDownloadListManifest.md).
  The removed functions include `synBuildTable()`, `synMove()`,
  `synGetChildren()`, `synCreateExternalS3FileHandle()`,
  `synUploadFileHandle()`, `synDownloadTableColumns()`,
  `synGetConfigFile()` and `synInvalidateAPIKey()`, plus the annotation,
  provenance, column, team, user profile, wiki, evaluation, submission
  and storage location functions. See [Removed
  functions](https://r-docs.synapse.org/articles/migration_to_synapser_3_0.html#removed-functions)
  for the replacement for each.
- `synGetPermissions()` returns only your own permissions. Use
  `synGetAcl(principal_id = ...)` to check another user or team.
- Python 3.10 and earlier are no longer supported. If you used a
  pre-release 3.0 build, `SchemaOrganization` is now `Organization`.

### Improvements

- Upgraded to synapsePythonClient 4.15.
- No Python setup needed: the first time synapser loads, reticulate
  downloads a compatible Python and the Synapse Python client into a
  managed environment.
- Removed the version caps on `reticulate` and `rjson`. synapser now
  requires R 4.2.0 or later and `reticulate` 1.44.0 or later.

#### New Functions

- Models: `VirtualTable`, `DatasetCollection`, `Agent`, `AgentSession`,
  `Organization`, `JSONSchema`, `StorageLocation`, `StorageLocationType`
  and `DownloadListItem`.
- Entities: `synSetProperties` sets properties and annotations on any
  entity. `synChangeMetadata` renames a file or changes its download
  name or content type without re-uploading it.
- Tables: `synAddColumn`, `synDeleteColumn`, `synReorderColumn`,
  `synStoreRows` and `synUpsertRows`. `synStoreRows` can infer the
  table’s columns from the data.
- Projects and folders: `synCopy`, `synWalk`, `synSyncFromSynapse`,
  `synSyncToSynapse` and `synGenerateSyncManifest` copy, traverse and
  sync them. `synDeleteProjectSetting`, `synIndexFilesForMigration` and
  `synMigrateIndexedFiles` remove a storage setting and move existing
  files to another storage location.
- Sharing Settings: `synListAcl` and `synDeletePermissions` work
  recursively over a project or folder, and `synDeletePermissions` has a
  `dry_run` option. `synUpdateAcl` and `synGetAcl` also manage access to
  evaluations and to JSON Schema organizations.
- JSON Schemas: `synBindSchema`, `synUnbindSchema`, `synValidateSchema`,
  `synGetSchema`, `synGetSchemaDerivedKeys`,
  `synGetSchemaValidationStatistics` and `synGetInvalidValidation` bind
  and validate schemas. `synGetJsonSchemas`, `synGetVersions` and
  `synGetBody` browse an organization’s schemas.
- Evaluations and Submissions: `synGetSubmissionCount`,
  `synBatchUpdateSubmissionStatuses`, `synCancel` and
  `synGetAvailableEvaluations`.
- Teams: `synDeleteInvitation`.
- Download list: `synDownloadListAdd`.
- Wikis: `WikiHistorySnapshot`, `WikiOrderHint`, `synRestore`,
  `synGetMarkdownFile` and `synGetAttachmentPreview`. `synCopy` on a
  `WikiPage` copies a wiki tree to another entity.

### Documentation Improvements

- Reworked setup pages: Installation and Troubleshooting are rewritten
  for the managed environment, and new Authentication and Configuration
  pages cover logging in and every `.synapseConfig` section.
- The reference site is organized by model, with a page and R examples
  for every constructor and function.
- Added tutorials for each model, workflow guides (bulk upload and
  download, sharing settings), concept articles (data model, access
  control, properties and annotations, manifest CSV) and the [Migrating
  to synapser
  3.0](https://r-docs.synapse.org/articles/migration_to_synapser_3_0.html)
  vignette.

## synapser 2.2.0

### Improvements

- Upgraded to the synapsePythonClient v4.12.
- Use the latest version of rjson and reticulate

## synapser 2.1.5

### Deprecation

- No longer support python 3.8

### Documentation Improvements

- Updated documents for R and Python dependencies.

## synapser 2.1.4

### Improvements

- Upgraded to the synapsePythonClient v4.4.2.

### Documentation Improvements

- Updated instructions for synLogin.

## synapser 2.1.3

### Improvements

- Now support R 4.5.2.

### Documentation Improvements

- Added instruction to add string list annotation in entity view.

## synapser 2.1.2

### Improvements

- Correcting the specification for `rjson` and `reticulate` package
  versions allowing the `remotes` library to handle automatic version
  resolution.

### Documentation Improvements

- Enhanced installation documentation to use `remotes` package for
  better dependency management
- Added comprehensive troubleshooting guide for rjson/reticulate version
  conflicts
- Clarified Python version compatibility requirements (3.8-3.11,
  recommend 3.10)
- Updated all vignettes with improved installation instructions and
  cross-references
- Added detailed guidance for users experiencing dependency conflicts

## synapser 2.1.1

### Improvements

- Pinned `rjson` package version to 0.2.21 to support R versions older
  than 4.4.0.

## synapser 2.1.0

### Improvements

- Upgraded to the synapsePythonClient v4.4.0.
- Now support R 4.4.1.
- The data upload and download algorithm in synapsePythonClient have
  been revamped for enhanced stability, reliability, and performance.
- Updated reference documents and code examples for both new and
  modified functions.

#### New Functions

- `synCreateTeam` and `synDeleteTeam` have been added to manage team.
- `synRestGetAsync`, `synRestDeleteAsync`, `synRestPostAsync` and
  `synRestPutAsync` have been added to allow interaction with Synapse
  server utilizing
  [asynchronous](https://python-docs.synapse.org/reference/oop/models_async/)
  models.

#### Minor behavior changes:

- Credentials passed by command line argument will now be evaluated
  before credentials stored in the `~/.synapseConfig` file.
- Using syn123.version notation is now supported with `synGet` and
  `synSetProvenance`.
- File entities will no longer have their version incremented during
  no-op changes. Only when file content, or fields on the file has been
  updated will a version number be incremented.
- New parameters have been added to allow more features:
  - Defining the project alias used in project url is now supported in
    `Project`.
  - Setting the annotations on the entity is now supported in
    `synStore`.
  - The MD5 of the file can now be used when creating S3 file handle in
    `synCreateExternalS3FileHandle`.

For more changes, please view the [Release
Notes](https://python-docs.synapse.org/news/) on the Python client
documentation.

## synapser 2.0.0

### Improvements

- Python synapsePythonClient dependency updated to 4.0.0
- You can only login via a Synapse Personal Access token now. All other
  forms of authentication have been disabled for security purposes.
- `rememberMe` has been deprecated in `synLogin`.
- `synSetAnnotations` removed as it is not working as expected due to
  implementation in the Python API.
- For more changes, please view the 3.2.0 and 4.0.0 changes on the
  [Python client documentation](https://python-docs.synapse.org/news/).

## synapser 1.3.0

### Improvements

- Python synapsePythonClient dependency updated to 3.1.1

## synapser 1.2.0

### Improvements

- Python synapsePythonClient dependency updated to 3.0.0
- Use `virtualenv` to install Python dependencies

## synapser 1.1.0

### Improvements

- Python synapsePythonClient dependency updated to 2.7.2

## synapser 1.0.0

------------------------------------------------------------------------

### Improvements

Special thanks to [genUI](https://www.genui.com/) for their work to push
out this major release!

- PythonEmbedInR dependency has been replaced by Reticulate
  ([SYNR-1310](https://sagebionetworks.jira.com/browse/SYNR-1310))
- Raised R dependency to 4.0 in DESCRIPTION
- Python synapsePythonClient dependency updated to 2.7.0
- Validated working with R \>= 4.1.3, Python \>= 3.8
- Python dependencies should install automatically in most instances
- Streamlined `build.yml` replacing custom steps with standard actions
  where practical
- Brought `abbreviateStackTrace.py`, `patchStdoutStdErr.py`,
  `pyPkgInfo.py`, `stdouterrCapture.py`, `PythonPkgWrapperUtils.R` file
  over from `PythonEmbedInR` for R-wrapper generation
- Brought `/templates` directory for auto-generating Rd files over from
  `PythonEmbedInR`
- Removed disused `installPythonClient.py` `interruptCheck.py` files
- Updated `/man` with latest auto-generated Rd files from `/auto-man`
- Removed empty sections from `man/*.Rd` files to resolve `R CMD check`
  WARNINGs
- Updated tests

### Python [synapsePythonClient](https://github.com/Sage-Bionetworks/synapsePythonClient) release notes for 2.5.0+

- [2.7.0](https://python-docs.synapse.org/build/html/news.html#id1)
- [2.6.0](https://python-docs.synapse.org/build/html/news.html#id2)
- [2.5.1](https://python-docs.synapse.org/build/html/news.html#id7)
- [2.5.0](https://python-docs.synapse.org/build/html/news.html#id11)

## synapser 0.11

------------------------------------------------------------------------

### Improvements

- Added ability to authenticate from a SYNAPSE_AUTH_TOKEN environment
  variable set with a valid [personal access
  token](https://help.synapse.org/docs/Managing-Your-Account.2055405596.html#ManagingYourAccount-PersonalAccessTokens),
  e.g.:

&nbsp;

    # set environment variable prior to using synapser
    export SYNAPSE_AUTH_TOKEN='<my_personal_access_token>'

The environment variable will take priority over credentials in the
user’s .synapseConfig file or any credentials saved in a prior login
using the remember me option.

### Deprecation

- R \>= 4.0 is required for this and future versions of synapser.

## synapser 0.10

------------------------------------------------------------------------

### Improvements

- Login using an access token is now supported,
  e.g. `synLogin(authToken="token")`. See [Manage Synapse
  Credentials](https://r-docs.synapse.org/latest/articles/manageSynapseCredentials.md)
  for more details.
- The following additional functions are exposed:
  - [synCreateExternalS3FileHandle](https://r-docs.synapse.org/latest/reference/synCreateExternalS3FileHandle.md)
  - [synCreateS3StorageLocation](https://r-docs.synapse.org/latest/reference/synCreateS3StorageLocation.md)
  - [synCreateSnapshotVersion](https://r-docs.synapse.org/latest/reference/synCreateSnapshotVersion.md)
  - [synGetStsStorageToken](https://r-docs.synapse.org/latest/reference/synGetStsStorageToken.md)
  - [synIsCertified](https://r-docs.synapse.org/latest/reference/synIsCertified.md)

### Bug fixes

- Expose (additional) Python commands in the synapser package
  ([SYNR-1474](https://sagebionetworks.jira.com/browse/SYNR-1474))
- Python cryptography installation can fail due to Rust compiler
  dependency
  ([SYNR-1475](https://sagebionetworks.jira.com/browse/SYNR-1475))

## synapser 0.9

------------------------------------------------------------------------

### Bug fixes

- Markupsafe version incompatibility resolved
  ([SYNR-1466](https://sagebionetworks.jira.com/browse/SYNR-1466))
- Fixed incomaptibility with source compile R 4.0.3 on Mac
  ([SYNR-1471](https://sagebionetworks.jira.com/browse/SYNR-1471))

## synapser 0.8

------------------------------------------------------------------------

### Bug fixes

- Implicit gettext dependency removed on Macs
  ([SYNR-1463](https://sagebionetworks.jira.com/browse/SYNR-1463))

### Improvements

- Formal arguments defined on most Synapse methods
  ([SYNR-1243](https://sagebionetworks.jira.com/browse/SYNR-1243)

## synapser 0.7

------------------------------------------------------------------------

### Bug fixes

- Internet connection no longer required to load synapser package
  ([SYNR-1233](https://sagebionetworks.jira.com/browse/SYNR-1233))

### Improvements

- R-4.0 compatible
  ([SYNR-1445](https://sagebionetworks.jira.com/browse/SYNR-1445))

## synapser 0.6

------------------------------------------------------------------------

### New Features

- New method `set_entity_views` in `EntityViewSchema` allows replacing
  the entity types that will appears in a view.
- New message on package load notifies users when a new `synapser`
  version is available on Sage’s RAN.

### Improvements

- `synSetAnnotations()` documentation now clearly states that the
  function will replace the existing annotations.
  ([SYNR-1361](https://sagebionetworks.jira.com/browse/SYNR-1361))
- The [`Table()`](https://r-docs.synapse.org/latest/reference/Table.md)
  reference documentation now has a link to the Table vignette.
  ([SYNR-1365](https://sagebionetworks.jira.com/browse/SYNR-1365))
- The synapser vignette now has a link to the Manage Synapse Credentials
  vignette.
  ([SYNR-1382](https://sagebionetworks.jira.com/browse/SYNR-1382))
- The Manage Synapse Credentials vignette now has instructions on how to
  login using Synapse API key.
  ([SYNR-1383](https://sagebionetworks.jira.com/browse/SYNR-1383))
- Table vignettes has new examples using `synGetTableColumns`.
  ([SYNR-1384](https://sagebionetworks.jira.com/browse/SYNR-1384))
- `synBuild_table()` no longer shows up in the synapser package’s
  namespace.
  ([SYNR-1387](https://sagebionetworks.jira.com/browse/SYNR-1387))
- synapser installation instructions now has a link to System
  Dependencies vignette.
  ([SYNR-1393](https://sagebionetworks.jira.com/browse/SYNR-1393))

## synapser 0.5

------------------------------------------------------------------------

### New Features

- New parameter `includeEntityTypes` in `EntityViewSchema` allows
  configuring Synapse Views with all available Entity types.
  ([SYNR-1350](https://sagebionetworks.jira.com/browse/SYNR-1350))

### Bug Fixes

- In synapser 0.5, we locked down the version of the Python package
  `keyring.alt` to ensure stable installation in the Linux environment.
  ([SYNR-1375](https://sagebionetworks.jira.com/browse/SYNR-1375))
- `as.data.frame(synTableQuery(...))` now correctly returns R
  `data.frame` with column types matching the Table column types.
  ([SYNR-1275](https://sagebionetworks.jira.com/browse/SYNR-1275),
  [SYNR-1322](https://sagebionetworks.jira.com/browse/SYNR-1322), and
  [SYNR-1325](https://sagebionetworks.jira.com/browse/SYNR-1325))

### Improvements

- New
  [Troubleshooting](https://r-docs.synapse.org/latest/news/troubleshooting.md)
  vignette with more information about package installation on Windows
  with network drive configuration.
  ([SYNR-1248](https://sagebionetworks.jira.com/browse/SYNR-1248))
- New [File Upload](https://r-docs.synapse.org/latest/news/upload.md)
  vignette with more information about uploading a new version of a
  file. ([SYNR-1360](https://sagebionetworks.jira.com/browse/SYNR-1360))
- New [Manage Synapse
  Credentials](https://r-docs.synapse.org/latest/news/manageSynapseCredentials.md)
  vignette with more ways to login to Synapse.
  ([SYNR-1367](https://sagebionetworks.jira.com/browse/SYNR-1367))
- Improve `synGetChildren()` documentation.
  ([SYNR-1280](https://sagebionetworks.jira.com/browse/SYNR-1280), and
  [SYNR-1374](https://sagebionetworks.jira.com/browse/SYNR-1374))
- Improve `synSetAnnotations()` documentation.
  ([SYNR-1165](https://sagebionetworks.jira.com/browse/SYNR-1165))
- Simplify docs for deleting Table rows.
  ([SYNR-1340](https://sagebionetworks.jira.com/browse/SYNR-1340))
- Document accessing md5 with
  [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md).
  ([SYNR-1359](https://sagebionetworks.jira.com/browse/SYNR-1359))
- Document
  [`synSendMessage()`](https://r-docs.synapse.org/latest/reference/synSendMessage.md)
  for one receipient.
  ([SYNR-1362](https://sagebionetworks.jira.com/browse/SYNR-1362))
- Improve
  [`Table()`](https://r-docs.synapse.org/latest/reference/Table.md)
  documentation.
  ([SYNR-1365](https://sagebionetworks.jira.com/browse/SYNR-1365))

## synapser 0.4

------------------------------------------------------------------------

### Deprecation

- `synQuery()` and `synChunkedQuery()` are deprecated and removed. To
  query for entities filter by annotations, please use
  `EntityViewSchema` feature.
- `synUploadFileHandle()` and `synUploadSynapseManagedFileHandle()` are
  deprecated in synapser 0.4, and will be removed in synapser 0.5.

### Bug Fixes

- In synapser 0.4, we locked down the version of the Python package
  `keyring` to ensure stable installation on Linux environment.
  ([SYNR-1345](https://sagebionetworks.jira.com/browse/SYNR-1345))

## synapser 0.3

------------------------------------------------------------------------

### New Features

- New convenience function `synBuildTable` creates a Table Schema based
  on the given data, and returns a Table object that can be stored in
  Synapse using `synStore`.
- New convenience function `synMove` allows users to move entities to a
  different parent.

### Minor Bug Fixes and Improvements

- `synStore` now uses a single thread to avoid the C stack limit error
  ([SYNR-1323](https://sagebionetworks.jira.com/browse/SYNR-1323)).
- Create 50 or more Links at a time
  ([SYNR-1276](https://sagebionetworks.jira.com/browse/SYNR-1276)).
- Python warning messages are no longer printed.
- `synapser` namespace no longer contains `PythonEmbedInR` and other R
  package functions
  ([SYNR-1274](https://sagebionetworks.jira.com/browse/SYNR-1274)).
- New NEWS.md provides the change log for each released version
  ([SYNR-1315](https://sagebionetworks.jira.com/browse/SYNR-1325)).
- New [System Dependencies
  vignette](https://r-docs.synapse.org/latest/news/articles/systemDependencies.md)
  explains what dependencies are required and how to install them
  ([SYNR-1328](https://sagebionetworks.jira.com/browse/SYNR-1328)).
- New examples on [how to move a
  file](https://r-docs.synapse.org/latest/news/articles/synapser.html#organizing-data-in-a-project)
  shows how `synMove` can be used
  ([SYNR-1296](https://sagebionetworks.jira.com/browse/SYNR-1296)).
- New [example R packages that depends on
  `synapser`](https://github.com/Sage-Bionetworks/synapser#usage)
  showcases two R packages developed by Sage Bionetworks’ scientists
  ([SYNR-1317](https://sagebionetworks.jira.com/browse/SYNR-1317)).
- New section [Synapse
  Utilities](https://r-docs.synapse.org/latest/news/articles/synapser.html#synapse-utilities)
  links to `synapserutils` package for high level utilities functions
  ([SYNR-1314](https://sagebionetworks.jira.com/browse/SYNR-1314)).

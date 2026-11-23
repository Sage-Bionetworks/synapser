# Migrating to synapser 3.0

## Who this guide is for

This guide is for anyone with existing R code that uses synapser 2.x.
Upgrading to 3.0 will break that code: functions have been renamed,
arguments have new names, and the objects you get back are structured
differently.

The good news is that the code fails with a clear error rather than
silently returning wrong results. Typical errors look like this:

- `could not find function "synTableQuery"` (a renamed or removed
  function)
- `unused argument (parentId = "syn123")` (an argument now in
  snake_case)
- `AttributeError: 'File' object has no attribute 'properties'` (a
  property that is no longer nested under `$properties`)

If you’re writing new code rather than porting old code, you don’t need
this guide at all: start from [Data Upload, Download, and
Delete](https://r-docs.synapse.org/latest/articles/data_upload_download.md)
and [Tables](https://r-docs.synapse.org/latest/articles/tables.md).

## Why upgrade now

Staying on 2.x costs you more than the new API:

- **Frozen R dependencies.** 2.x pins `reticulate` to 1.25–1.28 and
  `rjson` to ≤ 0.2.21, which holds back every other project sharing your
  R library. 3.0 drops both ceilings.
- **A Python ceiling.** 2.x supports only Python 3.9–3.11 (with old
  `pandas` and `numpy` caps). 3.0 supports Python 3.11–3.15 and no
  Python setup is needed.
- **An outdated Python client.** 2.x is stuck on synapseclient 4.4.2.
  3.0 is built on 4.15, and new Python client features become available
  in R as soon as they are released. See [What you gain in
  3.0](#what-you-gain-in-30).

## Why this release is not backwards compatible

Previous versions of synapser wrapped a hand-curated subset of the
Python client behind R-idiomatic function names and camelCase arguments.
3.0 upgrades the reticulate/rjson dependency and keep pace with the
Python client’s newer `synapseclient.models`/`synapseclient.operations`
architecture, generates the R layer directly from those Python OOP
models instead of maintaining a separate hand-written wrapper. The
result is an API that mirrors the Python client field-for-field, so most
existing synapser scripts will need updates.

This guide covers the Project/Folder/File/Table workflow — the paths
most scripts use. The same patterns apply to every other entity type
(Dataset, Views, Evaluation, Team, Wiki, …); see the [full
reference](https://r-docs.synapse.org/latest/articles/index.md) for
exact signatures.

## What you gain in 3.0

Upgrading costs a round of script updates (see below), but it buys you
real capability, not just a version bump:

- **No Python environment to manage, and no pinned dependencies.**
  synapser sets up the Python client it needs the first time it loads,
  so there is no virtualenv to create, activate, or repair by hand. Its
  R dependencies (`reticulate`, `rjson`) are no longer held to old
  versions, so installing synapser doesn’t force older packages on the
  rest of your R library.
- **New functionality that 2.x simply didn’t have.** Recursive
  `synCopy()`/`synSyncFromSynapse()`/`synWalk()`, manifest-driven bulk
  upload (`synGenerateSyncManifest()`/`synSyncToSynapse()`),
  hierarchy-wide `synListAcl()` and `synDeletePermissions()` (with a
  `dry_run` preview), and JSON Schema binding/validation
  (`synBindSchema()`, `synValidateSchema()`, …), table upserts
  (`synUpsertRows()`), wiki history and restore, functions for running
  evaluation queues, and Synapse AI agent chat are all new in 3.0. See
  [New in 3.0: capabilities that didn’t exist
  before](#new-in-30-capabilities-that-didnt-exist-before) below.
- **New entity types, not just new methods on the old ones.**
  `VirtualTable`, `DatasetCollection`, `Agent`/`AgentSession`, and
  `Organization`/`JSONSchema` have no 2.x counterpart at all, and the
  view types (`EntityView`, `MaterializedView`, `SubmissionView`)
  replace 2.x’s
  `EntityViewSchema`/`MaterializedViewSchema`/`SubmissionViewSchema`
  while picking up the same column, query, and ACL verbs as `Table`.
- **Faster access to new Python client features going forward.** Because
  the R layer is generated from the same OOP models the Python client
  ships, new methods and arguments added to `synapseclient` can be
  surfaced in R without waiting on a hand-written wrapper to catch up.
- **One mental model, matching the Python docs.** Every entity — File,
  Folder, Table, Dataset, Project, … — now follows the same
  `Constructor(...) |> synMethod(...)` shape, with snake_case arguments
  that match the Python client’s field names exactly.
- **Comprehensive documentation.** Every entity and every function has
  its own reference page with R examples, organized by entity type on
  the [reference
  site](https://r-docs.synapse.org/latest/articles/index.md). Beyond the
  reference, there are step-by-step tutorials for each entity type
  (Projects, Folders, Files, Tables, Views, Datasets, Wikis,
  Evaluations, Submissions, …), workflow guides for tasks such as bulk
  upload and download and sharing settings, and concept articles on
  Synapse’s data model, access control, and annotations. See [Where to
  go next](#where-to-go-next) for the full list.

In short, upgrading to 3.0 means updating your scripts once. In return,
you get no Python setup and no pinned dependencies, much broader Synapse
coverage (new entity types plus recursive, bulk-upload, and schema
workflows), one consistent API that matches the Python client, and full
documentation for every entity and function. Because the R layer is
generated from the Python client, it stays current as the Python client
evolves.

## Before you upgrade

synapser 3.0 requires:

- R 4.2.0 or later.
- `reticulate` 1.44.0 or later. Earlier versions, including the 1.28
  that 2.x pinned, fail with
  `could not find a Python environment for /`.
- Python 3.11 to 3.15. Synapser downloads a compatible Python and the
  Synapse Python client into its managed environment the first time
  synapser loads.

If you set up pinned dependencies for 2.x (such as `rjson` and
`reticulate`), remove them, and remove the `r-reticulate` virtualenv and
any `RETICULATE_PYTHON` setting so synapser can use its managed
environment via [uv](https://docs.astral.sh/uv/). Then restart R:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``"rjson"``, ``"reticulate"``)``)`\
`reticulate``::`[`virtualenv_remove`](https://rstudio.github.io/reticulate/reference/virtualenv-tools.html)`(``"r-reticulate"``)`

Run
[`reticulate::py_config()`](https://rstudio.github.io/reticulate/reference/py_config.html)
to check which Python synapser is using. See
[Installation](https://r-docs.synapse.org/latest/articles/installation.md)
for details.

## Four patterns to relearn

### 1. Instance-first, then pipe

Every entity is now a real object you construct directly — `File(...)`,
`Folder(...)`, `Table(...)`, `Project(...)`, … — and every operation on
it is a “verb” function
([`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md),
[`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md),
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md),
`synAddColumn()`, `synDeleteRows()`, …) that takes the instance as its
first argument. You construct the object first, then thread it through a
chain of these verbs with the native pipe, tidyverse-style, instead of
reassigning a variable at every step:

\
`# 2.x -- synStore() was one Python-backed function shared by every entity`\
`` # type, with Python duck-typing on `obj` internally; each step reassigned a ``\
`# variable rather than chaining`\
`file`` ``<-`` `[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``path``, parentId ``=`` ``"syn123"``)`\
`file`` ``<-`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``file``)`\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``file``$``properties``$``id``, downloadFile ``=`` ``FALSE``)`\
\
`# 3.0 -- construct the instance, then pipe it through verbs`\
`file`` ``<-`` `[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``path ``=`` ``path``, parent_id ``=`` ``"syn123"``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`` ``|>`\
`  `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`

This is the change everything else in this guide follows from. Two kinds
of function take an instance this way:

- [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md),
  [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md),
  and
  [`synDelete()`](https://r-docs.synapse.org/latest/reference/synDelete.md)
  are single factory functions that accept any supported entity — or,
  for
  [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md)
  and
  [`synDelete()`](https://r-docs.synapse.org/latest/reference/synDelete.md),
  a Synapse ID string instead — and apply the behavior appropriate to
  that entity’s type.
- Every other verb (`synAddColumn()`, `synGetAcl()`, `synCopy()`,
  `synWalk()`, `synBindSchema()`, …) is a generic that dispatches on the
  class of the object you pipe in. The same verb name therefore works
  uniformly across every entity type that supports it.

### 2. Properties are no longer nested under `$properties` and synSetProperties

Properties and annotations are now plain fields on the object. Read them
directly, and update them with the convenience function
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md),
which sets any number of fields, including `annotations`, in one call
and returns the entity so you can pipe it into
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):

\
`# 2.x`\
`entity``$``properties``$``id`\
`entity``$``properties``$``name`\
`entity``$``annotations``$``assay`\
\
`# 3.0`\
`entity``$``id`\
`entity``$``name`\
`entity``$``annotations``$``assay`\
\
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``synapse_id``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    name ``=`` ``"new name"``,`\
`    version_label ``=`` ``"2"``,`\
`    annotations ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``assay ``=`` ``"RNA-seq"``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

Setting `annotations` replaces all of the entity’s existing annotations.
To add to them instead, combine them first:
`synSetProperties(annotations = append(entity$annotations, list(key = "value")))`.

### 3. Arguments are snake_case, matching the Python client exactly

\
`# 2.x`\
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``entity``, downloadFile ``=`` ``FALSE``)`\
[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``obj``, forceVersion ``=`` ``FALSE``, versionLabel ``=`` ``"2"``)`\
[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``path``, parentId ``=`` ``project``$``properties``$``id``)`\
\
`# 3.0`\
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``entity``, file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`\
`obj`` ``|>`` `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``force_version ``=`` ``FALSE``, version_label ``=`` ``"2"``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``path ``=`` ``path``, parent_id ``=`` ``project``$``id``)`

Some arguments didn’t just change case; they moved. In 2.x,
`forceVersion` and `versionLabel` were arguments to
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md).
In 3.0 they are fields on the entity (`force_version`, `version_label`),
which you set when you create the entity or with
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md).
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
no longer accepts them. It takes only the entity, an optional `parent`,
and an options object for the entity type, such as
[`StoreFileOptions()`](https://r-docs.synapse.org/latest/reference/StoreFileOptions.md),
[`StoreContainerOptions()`](https://r-docs.synapse.org/latest/reference/StoreContainerOptions.md),
or
[`StoreTableOptions()`](https://r-docs.synapse.org/latest/reference/StoreTableOptions.md).

### 4. Property Mutation goes through `synSetProperties()`, then an explicit `synStore()`

Directly assigning into `$properties` no longer works. Properties are
set with
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
— which validates the field names against the object’s dataclass fields
— and piped into
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):

\
`# 2.x`\
`entity``$``properties``$``name`` ``<-`` ``"new name"`\
`entity`` ``<-`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``entity``)`\
\
`# 3.0`\
`entity`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``synapse_id``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``name ``=`` ``"new name"``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

Table columns are the one exception — those are still mutated in place
on the `$columns` list before
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):

\
`table``$``columns``[[``"Expression"``]``]``$``name`` ``<-`` ``"Expression2"`\
`table``$``columns``[[``"Expression"``]``]``$``column_type`` ``<-`` ``"INTEGER"`\
`table`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

The column verbs `synAddColumn()`, `synDeleteColumn()`, and
`synReorderColumn()` work the same way: they change the table object in
place and return nothing, so they are separate statements rather than
links in a pipe into
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md):

\
`table`` ``|>`` ``synAddColumn``(`[`Column`](https://r-docs.synapse.org/latest/reference/Column.md)`(``name ``=`` ``"Expression"``, column_type ``=`` ``"STRING"``)``)`\
`table`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

## Side-by-side reference: common operations

| Task | 2.x (legacy) | 3.0 (new) |
|----|----|----|
| Create + store an entity | `File(path, parentId = "syn123")` then `synStore(obj)` | `File(path = path, parent_id = "syn123") \|> synStore()` |
| Suppress a new version | `synStore(obj, forceVersion = FALSE)` | `File(path = path, parent_id = "syn123", force_version = FALSE) \|> synStore()` |
| Set name / version label | `entity$properties$name <- "x"; synStore(entity)` | `synGet(id) \|> synSetProperties(name = "x") \|> synStore()` |
| Move an entity | `synMove(entity, newParent)` | `synGet(id) \|> synSetProperties(parent_id = "syn456") \|> synStore()` |
| Track provenance | `synStore(obj, used = "syn123", executed = "syn456")` | `synGet(id) \|> synSetProperties(activity = Activity(used = list(UsedEntity(target_id = "syn123")), executed = list(UsedEntity(target_id = "syn456")))) \|> synStore()` |
| Read provenance | `synGetProvenance(entity)` | `Activity() \|> synGetFromParent(parent = synapse_id)` |
| Remove provenance | `synDeleteProvenance(entity)` | `synDisassociateActivityFromEntity(Activity, parent = entity)` |
| Get an entity | `synGet(entity, ...)` | `synGet(synapse_id, file_options = FileOptions(...))` |
| Get a specific version | `synGet(entity, version = 1)` | `synGet(synapse_id, version_number = 1L)` |
| Skip downloading file content | `synGet(entity, downloadFile = FALSE)` | `synGet(synapse_id, file_options = FileOptions(download_file = FALSE))` |
| Delete a version only | `synDelete(obj, version = 1)` | `synDelete(entity, version = 1L, version_only = TRUE)` |
| Query a table | `synTableQuery(sql)` | `synQuery(sql)` |
| Create a table column | `synCreateColumn(name = "x", columnType = "STRING")` | `Column(name = "x", column_type = "STRING")` |
| Add a table column | manual list manipulation | `table \|> synAddColumn(Column(name = "x", column_type = "STRING"))`, then `table \|> synStore()` |
| Remove a table column | manual list manipulation | `table \|> synDeleteColumn(name = "x")`, then `table \|> synStore()` |
| Insert-or-update table rows | query, merge, re-store | `table \|> synUpsertRows(values = df, primary_keys = list("Name"))` |
| Build a table from a CSV, inferring columns | `synBuildTable(name, parent, "genes.csv")` | `Table(name = ..., parent_id = ...) \|> synStore() \|> synStoreRows(values = "genes.csv", schema_storage_strategy = "INFER_FROM_DATA")` |

## Removed functions

Because 3.0 generates the R layer from the Python models, a 2.x function
survives only if the models expose an equivalent. These are the removals
most scripts will hit.

### Renamed or restructured

- **`synBuildTable()`** →
  `Table(...) |> synStore() |> synStoreRows(values = ..., schema_storage_strategy = "INFER_FROM_DATA")`.
  The table has to exist before rows can be stored into it, so the
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  step is not optional. See
  [Tables](https://r-docs.synapse.org/latest/articles/tables.md).
- **`synTableQuery()`** → `synQuery()`. See
  [Tables](https://r-docs.synapse.org/latest/articles/tables.html#querying-for-data).
- **`synMove()`** →
  `synGet() |> synSetProperties(parent_id = ...) |> synStore()`
- **`synGetChildren()`** →
  `synSyncFromSynapse(recursive = FALSE, download_file = FALSE)` and
  then the container’s `$files`/`$folders`, or `synWalk()` to traverse a
  whole tree. See [Downloading data in
  bulk](https://r-docs.synapse.org/latest/articles/download_data_in_bulk.md).
- **`synGetAnnotations()` / `synSetAnnotations()`** → the `annotations`
  field: read `entity$annotations`, write
  `synSetProperties(annotations = list(...)) |> synStore()`. See
  [Annotations](https://r-docs.synapse.org/latest/articles/annotation.md).
- **`synGetProvenance()`** →
  `Activity() |> synGetFromParent(parent = synapse_id)`, adding
  `parent_version_number` for a specific version. See
  [Activity/Provenance](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.html#activityprovenance).
- **`synSetProvenance()` / `synDeleteProvenance()` /
  `synUpdateActivity()`** → the `activity` field (an
  [`Activity()`](https://r-docs.synapse.org/latest/reference/Activity.md)
  object) set via
  [`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md),
  and `synDisassociateActivityFromEntity(Activity, parent = entity)` to
  remove it. See
  [Activity/Provenance](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.html#activityprovenance).
- **`synCreateColumn()` / `synCreateColumns()` / `synGetColumn()` /
  `synGetColumns()` / `synGetTableColumns()`** → the
  [`Column()`](https://r-docs.synapse.org/latest/reference/Column.md)
  constructor and the table’s own `$columns` list. See
  [Tables](https://r-docs.synapse.org/latest/articles/tables.html#changing-table-structure).
- **`synCreateSnapshotVersion()`** → `synSnapshot()`. See
  [`Table`](https://r-docs.synapse.org/latest/reference/Table_Snapshot.md).
- **`synRestGET()` / `synRestPOST()` / `synRestPUT()` /
  `synRestDELETE()`**, and the 2.x `synRestGetAsync()` family →
  [`synRestGet()`](https://r-docs.synapse.org/latest/reference/synRestGet.md),
  [`synRestPost()`](https://r-docs.synapse.org/latest/reference/synRestPost.md),
  [`synRestPut()`](https://r-docs.synapse.org/latest/reference/synRestPut.md),
  [`synRestDelete()`](https://r-docs.synapse.org/latest/reference/synRestDelete.md)
- **`synCreateTeam()`** → `Team(name = "...") |> synCreate()`;
  **`synGetTeam()`** → `Team |> synGetFromId(id = id)` or
  `Team |> synGetFromName(name = name)`; **`synDeleteTeam()`** →
  `synDelete(team)`. See
  [`Team`](https://r-docs.synapse.org/latest/reference/Team.md).
- **`synSendMembershipInvitation()`** → `synInviteToTeam()`;
  **`synGetTeamOpenInvitations()`** → `synGetOpenInvitations()`;
  **`synGetMembershipStatus()`** → `synGetUserMembershipStatus()`. See
  [`Team`](https://r-docs.synapse.org/latest/reference/Team.md).
- **`synGetUserProfile()`** →
  `UserProfile |> synGetFromId(user_id = user_id)` or
  `UserProfile |> synGetFromUsername(username = username)`. See
  [`UserProfile`](https://r-docs.synapse.org/latest/reference/UserProfile.md).
- **Wikis:** **`synGetWiki()`** →
  `WikiPage(owner_id = ..., id = ...) |> synGet()`; storing a wiki page
  →
  `WikiPage(owner_id = ..., title = ..., markdown = ...) |> synStore()`;
  **`synGetWikiHeaders()`** →
  `as.list(WikiHeader() |> synGet(owner_id = ...))`;
  **`synGetWikiAttachments()`** → `synGetAttachmentHandles()`, or
  `synGetAttachment()` to fetch one attachment. See
  [Wikis](https://r-docs.synapse.org/latest/articles/wiki.md).
- **Evaluations:** **`synGetEvaluation()`** →
  `Evaluation(id = ...) |> synGet()`; **`synGetEvaluationByName()`** →
  `Evaluation(name = ...) |> synGet()`;
  **`synGetEvaluationByContentSource()`** →
  `synGetEvaluationsByProject(project_id = ...)`. See
  [Evaluation](https://r-docs.synapse.org/latest/articles/evaluation.md).
- **Submissions:** **`synSubmit()`** →
  `Submission(entity_id = ..., evaluation_id = ...) |> synStore()`;
  **`synGetSubmission()`** → `Submission(id = ...) |> synGet()`;
  **`synGetSubmissionStatus()`** →
  `SubmissionStatus(id = ...) |> synGet()`, then
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  to update it; **`synGetSubmissions()`** →
  `Submission() |> synGetEvaluationSubmissions(evaluation_id = ...)`;
  **`synGetSubmissionBundles()`** →
  `SubmissionBundle() |> synGetEvaluationSubmissionBundles(evaluation_id = ...)`.
  See
  [Submission](https://r-docs.synapse.org/latest/articles/submission.md).
- **Storage locations:** **`synCreateS3StorageLocation()`** /
  **`synCreateStorageLocationSetting()`** →
  `StorageLocation(...) |> synStore()`;
  **`synGetMyStorageLocationSetting()`** →
  `StorageLocation(storage_location_id = ...) |> synGet()`;
  **`synSetStorageLocation()`**, **`synGetProjectSetting()`**, and
  **`synGetStsStorageToken()`** keep their names but are now verbs piped
  from a `Folder` or `Project`
  (`folder |> synSetStorageLocation(storage_location_id = ...)`). New on
  the same objects: `synDeleteProjectSetting()` removes a storage
  setting, and `synIndexFilesForMigration()` followed by
  `synMigrateIndexedFiles()` moves a container’s existing files to
  another storage location.
- **Download lists:** **`synGetDownloadList()`** →
  [`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md);
  **`synGetDownloadListManifest()`** →
  [`synDownloadListManifest()`](https://r-docs.synapse.org/latest/reference/synDownloadListManifest.md);
  **`synRemoveFromDownloadList()`** →
  [`synDownloadListRemove()`](https://r-docs.synapse.org/latest/reference/synDownloadListRemove.md);
  **`synClearDownloadList()`** →
  [`synDownloadListClear()`](https://r-docs.synapse.org/latest/reference/synDownloadListClear.md).
  [`synDownloadListAdd()`](https://r-docs.synapse.org/latest/reference/synDownloadListAdd.md)
  is new.

Note the calling convention in the Team, UserProfile, and provenance
entries. `synGetFromId()`, `synGetFromName()`, `synGetFromUsername()`,
`synGetFromParent()`, and `synDisassociateActivityFromEntity()` wrap
Python classmethods, so their first argument is the *constructor*
(`Team`, `UserProfile`, `Activity`) — that is what selects the
implementation — rather than an instance of it. An empty instance works
as the marker too (`Team() |> synGetFromId(id = id)`), which is the
style the reference pages use.

### Removed

These 2.x functions have no equivalent in 3.0. Where you still need one,
call the [REST API](https://rest-docs.synapse.org/) directly with
[`synRestGet()`](https://r-docs.synapse.org/latest/reference/synRestGet.md)/[`synRestPost()`](https://r-docs.synapse.org/latest/reference/synRestPost.md)/[`synRestPut()`](https://r-docs.synapse.org/latest/reference/synRestPut.md)/[`synRestDelete()`](https://r-docs.synapse.org/latest/reference/synRestDelete.md):

- **`synCreateExternalS3FileHandle()`**: no replacement.
- **`synUploadFileHandle()`**: no replacement.
- **`synDownloadTableColumns()`**: no replacement. The Python client has
  deprecated it too, and will remove it in 5.0.0. To download the files
  in a `FILEHANDLEID` column, query the table for the file handle IDs
  and request them from the REST API (`POST /fileHandle/batch`, with
  `associateObjectType` set to `TableEntity`).
- **`synGetConfigFile()`**: no replacement. Read `~/.synapseConfig`
  directly if you need it. See
  [Configuration](https://r-docs.synapse.org/latest/articles/configuration.md).
- **`synInvalidateAPIKey()`**: removed with no replacement. Synapse no
  longer supports API keys. Use a [personal access
  token](https://help.synapse.org/docs/Managing-Your-Account.2055405596.html#ManagingYourAccount-PersonalAccessTokens)
  instead.

## New in 3.0: capabilities that didn’t exist before

The OOP-model generation doesn’t just rename old functions — it also
surfaces Python client functionality that synapser never exposed at all.
These functions have no 2.x equivalent, so there’s nothing to migrate
*from*, but existing scripts that worked around their absence (manual
recursion to bulk update ACLs, hand-rolled directory walks, shelling out
to `synapseutils` from Python) can now be simplified.

### Richer access control

`synDeletePermissions()` and `synListAcl()` are new. Both work over a
single entity or an entire container hierarchy at once, so an audit or
cleanup that used to mean writing your own recursive walk over 2.x’s
`synGetChildren()` — and getting the edge cases (nested folders,
inherited vs. local ACLs) right yourself — is now one call. `dry_run`
lets you preview exactly what a recursive permissions change will touch
before anything is deleted, which matters once you’re operating on an
entire project tree instead of a single entity:

\
`# Preview, then perform, a recursive ACL cleardown of a folder and its children`\
[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synDeletePermissions``(``recursive ``=`` ``TRUE``, include_container_content ``=`` ``TRUE``, dry_run ``=`` ``TRUE``)`\
[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synDeletePermissions``(``recursive ``=`` ``TRUE``, include_container_content ``=`` ``TRUE``)`\
\
`# List every ACL in a hierarchy, optionally as an ASCII tree`\
[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synListAcl``(``recursive ``=`` ``TRUE``, log_tree ``=`` ``TRUE``)`

`synGetPermissions()` returns only *your own* effective permissions. The
2.x reference page documented a `principalId` argument for it, but 2.x’s
function never accepted one, and 3.0 doesn’t either. To check another
user’s or team’s permissions, use `synGetAcl(principal_id = ...)`. 2.x
also had `synGetAcl()`; in 3.0 it is a verb you pipe an entity into:

\
`# 2.x`\
`synGetAcl``(``entity``, principal_id ``=`` ``"273948"``)`\
\
`# 3.0 -- synGetPermissions() is caller-only; use synGetAcl() for another principal`\
[`File`](https://r-docs.synapse.org/latest/reference/File.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synGetAcl``(``principal_id ``=`` ``273948L``)`

On an `Evaluation`, `synGetAcl()` takes no `principal_id`; it returns
the ACL for every principal.

### Container traversal and sync

synapser 2.x didn’t include the `copy`, `syncFromSynapse`,
`syncToSynapse`, or `walk` utilities from `synapseutils`. In 3.0, they
are methods on any container, such as a Project or Folder. You can copy
a whole tree, download a project to a local folder, upload a directory,
or list everything in a hierarchy without downloading it, all with one
pipeline in R:

\
`# Recursively copy a folder, and everything in it, to a new parent`\
[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synCopy``(``parent_id ``=`` ``"syn456"``)`\
\
`# Recursively download a folder tree, populating $files/$folders/$tables/...`\
`folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`` ``|>`` ``synSyncFromSynapse``(``path ``=`` ``"~/local-copy"``)`\
\
`# Bulk upload: write a manifest that mirrors a local directory, then upload it`\
`folder`` ``|>`` ``synGenerateSyncManifest``(``directory_path ``=`` ``"./my_data"``, manifest_path ``=`` ``"manifest.csv"``)`\
`folder`` ``|>`` ``synSyncToSynapse``(``manifest_path ``=`` ``"manifest.csv"``)`\
\
`# Traverse a hierarchy without downloading anything`\
`for`` ``(``entry`` ``in`` `[`as.list`](https://rdrr.io/r/base/list.html)`(``folder`` ``|>`` ``synWalk``(``)``)``)`` ``{`\
`  ``dirpath`` ``<-`` ``entry``[[``1``]``]``; ``dirs`` ``<-`` ``entry``[[``2``]``]``; ``nondirs`` ``<-`` ``entry``[[``3``]``]`\
`  `[`cat`](https://rdrr.io/r/base/cat.html)`(``dirpath``[[``1``]``]``, ``"\n"``)`\
`}`

`synWalk()` returns a `GeneratorWrapper` — the same lazy-iterator object
2.x returned from `synGetChildren()`, which no longer exists. Call
[`as.list()`](https://rdrr.io/r/base/list.html) on it to materialize
every result into a plain list, or `nextElem()` to pull results one at a
time; you can’t loop over it directly the way you can a list. For the
narrower job `synGetChildren()` used to do — listing one container’s
immediate children without downloading them — use
`synSyncFromSynapse(recursive = FALSE, download_file = FALSE)` and read
the resulting `$files`/`$folders`.

The manifest that `synGenerateSyncManifest()` writes, and that
`synSyncToSynapse()` reads, is the same format that
`synSyncFromSynapse()` and
[`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md)
use — see [Manifest
CSV](https://r-docs.synapse.org/latest/articles/manifest_csv.md) and
[Uploading data in
bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md).

### JSON Schema binding and validation

Also new: entities can be bound to a JSON Schema and validated against
it directly from R. This lets you enforce metadata/annotation standards
on Files, Folders, and Tables as part of an R pipeline — catching
entities with missing or malformed annotations programmatically instead
of relying on manual review or the web UI — and derive annotation values
automatically from the schema rather than entering them by hand:

\
`folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`\
`folder`` ``|>`` ``synBindSchema``(``json_schema_uri ``=`` ``"myOrg-mySchema-0.0.1"``)`\
`folder`` ``|>`` ``synValidateSchema``(``)`\
`folder`` ``|>`` ``synUnbindSchema``(``)`

`synBindSchema()` returns the binding record rather than the entity.

This applies to Files, Folders, Tables, Projects, and other
container/entity types. Creating the organization and schema themselves
uses the new `Organization`/`JSONSchema` constructors
(`SchemaOrganization()`, from pre-release 3.0 builds, is now
[`Organization()`](https://r-docs.synapse.org/latest/reference/Organization.md))
— see
[`?Folder_synBindSchema`](https://r-docs.synapse.org/latest/reference/Folder_BindSchema.md)
for a full example. The rest of the family: `synGetSchema()` and
`synGetSchemaDerivedKeys()` on any bindable entity, plus
`synGetSchemaValidationStatistics()` and `synGetInvalidValidation()` on
containers (Folder, Project).

You can also browse schemas from R. `synGetJsonSchemas()` lists an
organization’s schemas, and
[`synGetVersions()`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetVersions.md)
and
[`synGetBody()`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetBody.md)
return a schema’s published versions and its body. `synGetAcl()` and
`synUpdateAcl()` manage who can publish schemas to an organization:

\
[`Organization`](https://r-docs.synapse.org/latest/reference/Organization.md)`(``name ``=`` ``"myOrg"``)`` ``|>`` ``synGetJsonSchemas``(``)`\
\
`schema`` ``<-`` `[`JSONSchema`](https://r-docs.synapse.org/latest/reference/JSONSchema.md)`(``organization_name ``=`` ``"myOrg"``, name ``=`` ``"mySchema"``)`\
`schema`` ``|>`` `[`synGetVersions`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetVersions.md)`(``)`\
`schema`` ``|>`` `[`synGetBody`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetBody.md)`(``version ``=`` ``"0.0.1"``)`

### Upserting table rows

`synUpsertRows()` updates the rows that match on one or more primary-key
columns and inserts the rest. In 2.x, you had to query the table, merge
the results in R, and store them again. Use `dry_run = TRUE` to see what
would change before writing anything:

\
`table`` ``<-`` `[`Table`](https://r-docs.synapse.org/latest/reference/Table.md)`(``id ``=`` ``"syn123"``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
`table`` ``|>`` ``synUpsertRows``(``values ``=`` ``df``, primary_keys ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"Name"``)``, dry_run ``=`` ``TRUE``)`\
`table`` ``|>`` ``synUpsertRows``(``values ``=`` ``df``, primary_keys ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"Name"``)``)`

See [Tables](https://r-docs.synapse.org/latest/articles/tables.md) for
the full set of options.

### More `synapseutils` utilities

3.0 also adds three more `synapseutils` utilities that 2.x didn’t
include: changing a file’s metadata, copying a wiki, and migrating files
to another storage location.

\
`# Rename a file, or change its download name or content type, without`\
`# re-uploading it. These fields can't be changed with synStore().`\
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``"syn123"``, file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`` ``|>`\
`  ``synChangeMetadata``(``name ``=`` ``"renamed.csv"``, download_as ``=`` ``"renamed.csv"``, content_type ``=`` ``"text/csv"``)`\
\
`# Copy a project's whole wiki tree to another entity and rewrite internal links.`\
`` # Set `id` to copy only the sub-tree under that page. ``\
[`WikiPage`](https://r-docs.synapse.org/latest/reference/WikiPage.md)`(``owner_id ``=`` ``"syn123"``)`` ``|>`` ``synCopy``(``destination_owner_id ``=`` ``"syn456"``)`\
\
`# Move a container's existing files to another storage location in two steps`\
`folder`` ``<-`` `[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md)`(``id ``=`` ``"syn123"``)`\
`folder`` ``|>`` ``synIndexFilesForMigration``(``dest_storage_location_id ``=`` ``"12345"``, db_path ``=`` ``"migration.db"``)`\
`folder`` ``|>`` ``synMigrateIndexedFiles``(``db_path ``=`` ``"migration.db"``, force ``=`` ``TRUE``)`

`synMigrateIndexedFiles()` asks for confirmation before it moves
anything. When it can’t ask (for example, in an R script), it stops
without migrating unless you pass `force = TRUE`.

### Wiki history and page order

2.x could get and store a wiki page, but not its history or its order in
the wiki navigation. In 3.0, you can list a page’s versions, restore an
earlier version, and set the order of the pages:

\
`# List a page's versions, then restore one of them`\
[`WikiHistorySnapshot`](https://r-docs.synapse.org/latest/reference/WikiHistorySnapshot.md)`(``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``owner_id ``=`` ``"syn123"``, id ``=`` ``wiki_id``)`\
[`WikiPage`](https://r-docs.synapse.org/latest/reference/WikiPage.md)`(``owner_id ``=`` ``"syn123"``, id ``=`` ``wiki_id``, wiki_version ``=`` ``"0"``)`` ``|>`` ``synRestore``(``)`\
\
`# Set the order of the wiki's pages in the navigation.`\
`# Page IDs are numeric strings, such as "12345", not numbers.`\
[`WikiOrderHint`](https://r-docs.synapse.org/latest/reference/WikiOrderHint.md)`(``owner_id ``=`` ``"syn123"``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``id_list ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``root_id``, ``page_2_id``, ``page_1_id``)``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`# Download a page's markdown`\
[`WikiPage`](https://r-docs.synapse.org/latest/reference/WikiPage.md)`(``owner_id ``=`` ``"syn123"``, id ``=`` ``wiki_id``)`` ``|>`` ``synGetMarkdownFile``(``download_location ``=`` ``"~/temp"``)`

`synGetAttachmentPreview()` downloads the preview of an attachment. See
[Wikis](https://r-docs.synapse.org/latest/articles/wiki.md).

### Evaluation queues, submissions, and teams

The Python client added several functions for running an evaluation
queue (a challenge) that 2.x never had:

\
`# Count a queue's submissions without downloading them`\
`synGetSubmissionCount``(``evaluation_id ``=`` ``"9614112"``)`\
\
`# Update up to 500 submission statuses in one request, instead of one`\
`# synStore() call each`\
`synBatchUpdateSubmissionStatuses``(``evaluation_id ``=`` ``"9614112"``, statuses ``=`` ``statuses``)`\
\
`# Cancel one of your own submissions`\
[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(``id ``=`` ``submission_id``)`` ``|>`` ``synCancel``(``)`\
\
`# List the queues you can submit to`\
`synGetAvailableEvaluations``(``active_only ``=`` ``TRUE``)`\
\
`# Withdraw a pending team invitation (2.x could send one, but not delete it)`\
`invitations`` ``<-`` `[`Team`](https://r-docs.synapse.org/latest/reference/Team.md)`(``id ``=`` ``123456L``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`` ``|>`` ``synGetOpenInvitations``(``)`\
`synDeleteInvitation``(``invitation_id ``=`` ``invitations``[[``1``]``]``$``id``)`

See
[Evaluation](https://r-docs.synapse.org/latest/articles/evaluation.md),
[Submission](https://r-docs.synapse.org/latest/articles/submission.md)
and [Team](https://r-docs.synapse.org/latest/articles/team.md).

### Synapse AI agents

`Agent` and `AgentSession` let you chat with a Synapse AI agent from R.
[`Agent()`](https://r-docs.synapse.org/latest/reference/Agent.md) with
no arguments uses the same default agent as the [Synapse chat
page](https://www.synapse.org/Chat:default). A session starts
automatically the first time you send a prompt:

\
`agent`` ``<-`` `[`Agent`](https://r-docs.synapse.org/latest/reference/Agent.md)`(``)`\
`agent`` ``|>`` ``synPrompt``(``prompt ``=`` ``"What is in the AD Knowledge Portal?"``, print_response ``=`` ``TRUE``)`\
`agent`` ``|>`` ``synGetChatHistory``(``)`

To use a custom agent, register it with `synRegister()` (custom agents
are available only to Sage Bionetworks staff). To manage sessions
yourself, use `AgentSession() |> synStart()`. See
[`Agent`](https://r-docs.synapse.org/latest/reference/Agent.md).

## Known pitfall: integer literals

R’s bare numeric literals (`1`) are doubles. Parameters the Synapse API
expects as integers — `version_number`, `version`, row IDs/versions in
`synDeleteRows(df = ...)` — must use the `L` suffix (`1L`). Passing `1`
instead of `1L` can produce unexpected behavior or an API error. This
isn’t new in 3.0, but it surfaces more often now that raw integer
parameters are exposed directly instead of being hidden behind wrapper
defaults.

## Where to go next

\*\* Updated Tutorials\*\*

- [Synapse R Client
  Overview](https://r-docs.synapse.org/latest/articles/synapser.md) is a
  short tour of the package.
- [Data Upload, Download, and
  Delete](https://r-docs.synapse.org/latest/articles/data_upload_download.md)
  walks through creating, downloading, and deleting projects, folders,
  and files.
- [Tables](https://r-docs.synapse.org/latest/articles/tables.md) covers
  the new table functions (`synAddColumn()`, `synDeleteColumn()`, and
  `synUpsertRows()`), schema inference, and dates.
- Tutorials for each model:
  [Projects](https://r-docs.synapse.org/latest/articles/project.md),
  [Folders](https://r-docs.synapse.org/latest/articles/folder.md),
  [Files](https://r-docs.synapse.org/latest/articles/file.md),
  [Annotations](https://r-docs.synapse.org/latest/articles/annotation.md),
  [EntityViews](https://r-docs.synapse.org/latest/articles/entityview.md),
  [Virtual
  Tables](https://r-docs.synapse.org/latest/articles/virtualtable.md),
  [Datasets](https://r-docs.synapse.org/latest/articles/dataset.md),
  [Dataset
  Collections](https://r-docs.synapse.org/latest/articles/datasetcollection.md),
  [Wikis](https://r-docs.synapse.org/latest/articles/wiki.md),
  [Evaluations](https://r-docs.synapse.org/latest/articles/evaluation.md),
  and
  [Submissions](https://r-docs.synapse.org/latest/articles/submission.md).
- Workflow guides: [Sharing Settings (ACL
  Management)](https://r-docs.synapse.org/latest/articles/sharing_settings.md),
  [Uploading data in
  bulk](https://r-docs.synapse.org/latest/articles/upload_data_in_bulk.md),
  [Downloading data in
  bulk](https://r-docs.synapse.org/latest/articles/download_data_in_bulk.md),
  and [Downloading data by Synapse
  ID](https://r-docs.synapse.org/latest/articles/download_data_by_synid.md).
- Concepts: [Domain Models of
  Synapse](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.md),
  [Access
  Control](https://r-docs.synapse.org/latest/articles/access_control.md),
  [Properties and
  annotations](https://r-docs.synapse.org/latest/articles/properties_vs_annotations.md),
  [Structuring Your Synapse
  Project](https://r-docs.synapse.org/latest/articles/structuring_your_project.md),
  and [Manifest
  CSV](https://r-docs.synapse.org/latest/articles/manifest_csv.md).

**Setup and environment** (the API changes above don’t affect how you
log in or configure the client; for installation changes, see [Before
you upgrade](#before-you-upgrade)):

- [Installation](https://r-docs.synapse.org/latest/articles/installation.md)
  covers installing the package and the Python environment that synapser
  sets up for you.
- [Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
  covers authentication token setup and storage.
- [Configuration](https://r-docs.synapse.org/latest/articles/configuration.md)
  covers the `.synapseConfig` file and client settings.
- [Troubleshooting](https://r-docs.synapse.org/latest/articles/troubleshooting.md)
  covers common connection and configuration errors.
- [System
  Dependencies](https://r-docs.synapse.org/latest/articles/systemDependencies.md)
  covers the system libraries needed on Linux and the supported Python
  versions.

**Reference:**

- The [reference
  site](https://r-docs.synapse.org/latest/articles/index.md) is
  organized per entity type (File, Table, Folder, …) — every constructor
  and method function is documented there, generated directly from the
  Python client so it stays current going forward.

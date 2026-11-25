# Contributing to synapser

This guide covers development, documentation, and release practices for the [synapser](https://github.com/Sage-Bionetworks/synapser) R package, which wraps the [Synapse Python client](https://github.com/Sage-Bionetworks/synapsePythonClient).

## Contents

- [Repository](#repository)
  - [Branches](#branches)
- [Development Setup](#development-setup)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Create a Feature Branch](#create-a-feature-branch)
- [Making Changes](#making-changes)
  - [Code Style](#code-style)
  - [Submitting a Pull Request](#submitting-a-pull-request)
- [Adding New Models or Functions](#adding-new-models-or-functions)
  - [1. Whitelist new model classes](#1-whitelist-new-model-classes--modelclassestoinclude)
  - [2. Whitelist new operations functions](#2-whitelist-new-operations-functions--operationsfunctionnames)
  - [3. Whitelist legacy Synapse functions](#3-whitelist-legacy-synapse-functions--synapseclassmethodstoinclude)
  - [4. Add function name mappings](#4-add-function-name-mappings--functionnamemappingsynapse-and-functionnamemappingsynapseclientmodels)
  - [5. Exclude specific methods](#5-exclude-specific-methods--modelclassmethodstoomit)
  - [6. Keep model methods the operations factory can't dispatch](#6-keep-model-methods-the-operations-factory-cant-dispatch--operationsunsupportedmodelmethods)
  - [7. Whitelist operations option classes](#7-whitelist-operations-option-classes--operationsclassestoinclude)
  - [After updating the allowlists](#after-updating-the-allowlists)
- [Updating the Python Client Version](#updating-the-python-client-version)
  - [Testing Against a synapseclient Feature Branch](#testing-against-a-synapseclient-feature-branch)
- [Python Environment](#python-environment)
- [Regenerating Documentation](#regenerating-documentation)
  - [Updating the README](#updating-the-readme)
- [Release Process](#release-process)
  - [Step 1: Identify scope](#step-1-identify-scope)
  - [Step 2: Staging release](#step-2-staging-release)
  - [Step 3: Validation](#step-3-validation)
  - [Step 4: Patch staging (if needed)](#step-4-patch-staging-if-needed)
  - [Step 5: Production release](#step-5-production-release)
- [Publishing Documentation](#publishing-documentation)
  - [Previewing Documentation in a Fork](#previewing-documentation-in-a-fork)
- [CI/CD](#cicd)

## Repository

- **synapser**: https://github.com/Sage-Bionetworks/synapser

### Branches

| Branch | Purpose |
|--------|---------|
| `master` | Latest release |
| `develop` | Active development |
| `vX.Y.Z-rc` | Release candidate for version X.Y.Z |

## Development Setup

### Prerequisites

- R (check `DESCRIPTION` for minimum version)
- Python 3.11 to 3.15 (for the [embedded Python client](https://github.com/Sage-Bionetworks/synapsePythonClient/blob/master/setup.cfg))
- `devtools`, `pkgdown` (>= 2.2.0), `styler` R packages
- [pandoc](https://pandoc.org/installing.html) 3.14, used to build the README and the docs site. The workflows pin this version because other versions can format `README.md` differently, which makes the `readme` check fail. Check yours with `pandoc --version`.

### Configuration

Create `~/.synapseConfig` for Synapse credentials:

```ini
[authentication]
authtoken=your_personal_access_token
```

An example config is at https://github.com/Sage-Bionetworks/synapsePythonClient/blob/develop/synapseclient/.synapseConfig.

### Create a Feature Branch

1. Check out a new branch from `develop`:
   ```bash
   git checkout develop
   git pull
   git checkout -b SYNR-1234-short-description
   ```
2. On your branch, add these repository secrets (values in LastPass under "Python Client dev stack openssl keys") to enable vignette integration tests in GitHub Actions:
   - `encrypted_d17283647768_iv`
   - `encrypted_d17283647768_key`

## Making Changes

### Code Style

Follow [tidyverse style guidelines](http://style.tidyverse.org/). Format files before committing:

```r
styler::style_file("R/your_file.R")
```

You can also use the `Air - R Language Support` extension in VS Code or Cursor to format R code automatically on save.

### Submitting a Pull Request

Push your feature branch to GitHub:

```bash
git push --set-upstream origin SYNR-1234-short-description
```

When your change is ready for review:

- Open a Pull Request from your branch to `develop` in `Sage-Bionetworks/synapser`.
- Request review from the DPE team or a designated reviewer.
- After approval and passing checks, merge into `develop`.


## Adding New Models or Functions

When the underlying Python client adds new model classes or top-level functions that should be exposed in synapser, update the corresponding allowlists and mappings in `R/shared.R`. 

### 1. Whitelist new model classes — `.modelClassesToInclude`

`R/shared.R` contains a character vector that controls which Python model classes get wrapped as R functions:

```r
.modelClassesToInclude <- c(
  "Agent",
  "AgentSession",
  "Project",
  "Folder",
  "File",
  # ... etc.
)
```

Add the exact Python class name (case-sensitive, matching `synapseclient.models`) to this vector. Classes omitted here will not be wrapped. Classes that are commented out are intentionally excluded.

### 2. Whitelist new operations functions — `.operationsFunctionNames`

`R/shared.R` also contains an allowlist for synchronous functions exposed from `synapseclient.operations`:

```r
.operationsFunctionNames <- c(
  "get",
  "store",
  "delete",
  "download_list_files",
  # ... etc.
)
```

Add the exact Python function name (case-sensitive) to this vector when you want it wrapped into `syn*` R functions. Model methods with the same name are then removed from the class wrappers; see [step 6](#6-keep-model-methods-the-operations-factory-cant-dispatch--operationsunsupportedmodelmethods) for classes the operations function doesn't support.

### 3. Whitelist legacy Synapse functions — `.synapseClassMethodsToInclude`

Some wrappers are generated from the legacy `synapseclient.Synapse` class:

```r
.synapseClassMethodsToInclude <- c(
  "login",
  "logout",
  "setEndpoints",
  "sendMessage",
  "rest_get_async",
  # ... etc.
)
```

### 4. Add function name mappings — `.functionNameMappingSynapse` and `.functionNameMappingSynapseclientModels`

By default, Python method names are converted to R function names using a `syn` prefix (for example, `store` -> `synStore`). Use these mapping helpers in `R/shared.R` when the generated name should be renamed for clarity:

- `.functionNameMappingSynapse`: for methods from `synapseclient.Synapse`
- `.functionNameMappingSynapseclientModels`: for methods from `synapseclient.models`

Example mappings:

```r
.functionNameMappingSynapse <- function() {
  list(
    explicit = list(
      "synRestGetAsync" = "synRestGet",
   # ... etc.
    )
  )
}

.functionNameMappingSynapseclientModels <- function() {
  list(
    explicit = list(
      # "auto-generated R name" = "desired R name"
      "synDisassociateFromEntity" = "synDisassociateActivityFromEntity",
      "synFromPath"               = "synGetFromPath",
      # ... etc.
    )
  )
}
```

Add a new `"auto-generated-name" = "desired-name"` entry under the appropriate mapping function for any method whose default R name should be overridden.

### 5. Exclude specific methods — `.modelClassMethodsToOmit`

Methods from `synapseclient.models` that are internal or not useful in R (e.g., `fill_from_dict`, `to_synapse_request`) are listed in:

```r
.modelClassMethodsToOmit <- c(
  "format_for_manifest",
  "fill_from_dict",
  "to_synapse_request",
  "allow_client_caching"
)
```

Add method names here to suppress them from the generated R wrappers.

### 6. Keep model methods the operations factory can't dispatch — `.operationsUnsupportedModelMethods`

Any model method whose name is in `.operationsFunctionNames` (for example `get`, `store`, `delete`) is dropped from that class's R wrappers, because `synGet()`, `synStore()`, and `synDelete()` are generated from the `synapseclient.operations` functions instead. That only works if the operations function supports the class. For classes it doesn't support, `store()` and `delete()` raise an error such as `Unsupported entity type: Submission`, while `get()` treats the unsupported instance as a Synapse ID, so the call fails later, in the entity lookup. Either way, the model's own method would otherwise be unreachable from R.

To keep a model's own method, add the class and method names to `.operationsUnsupportedModelMethods` in `R/shared.R`:

```r
.operationsUnsupportedModelMethods <- list(
  WikiPage = c("get", "store", "delete"),
  Submission = c("get", "store", "delete"),
  Evaluation = c("get"),
  Activity = c("store", "delete"),
  # ... etc.
)
```

Methods listed here stay wrapped, and `.defineOperationsFallbacks()` in `R/zzz.R` replaces `synGet()`/`synStore()`/`synDelete()` with a shim. The shim decides whether a call goes to the model's own method (e.g. `Activity$store`) or to the `synapseclient.operations` function, which only accepts entities. For example, `Activity(...) |> synStore(parent = file)` reaches `Activity.store`, and `Submission(id = "9999999") |> synGet()` reaches `Submission.get`. Anything without a listed method falls back to the operations function.

The shim decides in two steps:

1. **Pick the dispatch object.** This is the argument bound to the operations function's first formal (`synapse_id` for `synGet()`, `entity` for `synStore()`/`synDelete()`): that argument by name if the caller supplied it, otherwise the first unnamed argument. It is not simply the first argument by position. Named arguments can come in any order, so the object may not be first:

   ```r
   synStore(parent = file, entity = activity)   # dispatches on `activity`
   synStore(parent = file, activity)            # dispatches on `activity`
   synGet(synapse_id = Submission(id = "9"))    # dispatches on the Submission
   ```
   
2. **Match its class.** The shim strips the module path from each entry of `class(<object>)` and uses the first one that has a worker in `.functionalMethodDispatch`. Matching on `class(x)[1]` as-is is not enough, because only objects built with an R constructor carry the short class name. An object read from a field or a list carries reticulate's full dotted path:

   ```r
   activity <- Activity(name = "x")
   file <- File(id = "syn123", activity = activity)  # an existing file you can edit

   class(activity)[1]       # "Activity"
   class(file$activity)[1]  # "synapseclient.models.activity.Activity"

   synStore(file$activity, parent = file)   # reaches Activity.store
   ```
   
To check whether a class needs an entry, look for it in the supported types of the matching operations function in `synapseclient/operations/` (`store_operations.py`, `factory_operations.py`, `delete_operations.py`). Remove the entry once the operations function supports the class. For documentation, `tools/createRdFiles.R` still generates `auto-man/` pages for these methods, but they are not copied into `man/`; put their examples on the model's constructor page instead (see [Regenerating Documentation](#regenerating-documentation)).

### 7. Whitelist operations option classes — `.operationsClassesToInclude`

Option dataclasses from `synapseclient.operations` that callers construct directly, to configure `synGet()`/`synStore()` calls or to pass as arguments, are listed in:

```r
.operationsClassesToInclude <- c(
  "StoreFileOptions",
  "FileOptions",
  "TableOptions",
  "DownloadListItem",
  # ... etc.
)
```

Add the exact Python class name here when a new option class is introduced; otherwise R users have no constructor for it. A class that is referenced in an argument but not exposed (for example a `csv_table_descriptor` argument whose class is not listed here) can only be left as `NULL` from R.

### After updating the allowlists

1. Regenerate the documentation and curate the new pages (see [Regenerating Documentation](#regenerating-documentation)).
2. Add each new reference page to the `reference:` section of `_pkgdown.yml`. That index lists topics explicitly, either by name or with `has_keyword("ClassName")`. A curated page that isn't covered makes `pkgdown::build_reference()` fail with "Topics missing from index".
3. In a fresh R session, confirm the new wrapper exists and dispatches as expected, e.g. `exists("synNewFunction")` and a call on an instance of the class.

## Updating the Python Client Version

The wrapped Python client version is pinned in `R/shared.R`:

```r
PYTHON_CLIENT_VERSION <- "4.15"
```

After bumping the version, update the Python range in `SystemRequirements` in `DESCRIPTION` to match the release's `Requires-Python`, then regenerate documentation (see next section).

### Testing Against a synapseclient Feature Branch

To exercise synapser against unreleased changes on a `synapsePythonClient` feature branch, put your checkout on `PYTHONPATH` in a **fresh** R session before loading synapser:

```r
Sys.setenv(PYTHONPATH = "/path/to/synapsePythonClient")
devtools::load_all("/path/to/synapser")
```

synapser still provisions its uv-managed environment with the pinned `synapseclient[pandas]`, which supplies the dependencies. Python searches `PYTHONPATH` before site-packages, so `import synapseclient` resolves to your checkout, including uncommitted edits.

- If the branch adds a Python dependency the pinned version lacks, declare it before loading, e.g. `reticulate::py_require("newdep")`.
- If you edit the synapsePythonClient checkout after synapser has loaded, restart R to pick up the edits. Python caches `synapseclient` on first import, so re-running `load_all()` in the same session reuses the old code.
- The same allowlist check as for a version bump applies (see [Updating the Python Client Version](#updating-the-python-client-version)).

To confirm synapser loaded your branch:

```r
reticulate::py_run_string("import synapseclient; print(synapseclient.__version__, synapseclient.__file__)")
```

The printed file path should point into your feature-branch checkout, and the version is the checkout's, not `PYTHON_CLIENT_VERSION`.

## Python Environment

synapser runs in its own Python environment, which reticulate sets up automatically using uv and the pinned version of `synapseclient[pandas]` (see `R/shared.R`). No manual Python installation or environment setup is required.

If Python has not yet been initialized, synapser ignores `RETICULATE_PYTHON`, `use_python()`, activated virtual environments, and project-level `.venv` directories.

> **Note:** Python can only be set up once per R session. If another package initializes Python before synapser loads, synapser stops with an error naming the Python it found. Restart R and load synapser first.

To confirm which environment synapser is using:

```r
reticulate::py_config()  # the python: path should be under reticulate's uv cache
reticulate::py_run_string("import synapseclient; print(synapseclient.__version__)")
```

## Regenerating Documentation

synapser auto-generates draft `.Rd` files from Python docstrings into `auto-man/`. These must be manually reviewed and merged into `man/` before committing.

1. Build the package to regenerate `auto-man/`:
   ```bash
   R CMD INSTALL .
   ```

2. Diff the auto-generated files:
   ```bash
   git diff auto-man/
   ```

3. Manually copy new or changed files from `auto-man/` to `man/`, editing as needed:
   - For models listed in `.operationsUnsupportedModelMethods` in `R/shared.R`, `tools/createRdFiles.R` automatically generates `.Rd` files for the individual methods. DO NOT copy those method files into `man/`; add their examples to the model's constructor page instead.

   - Run the `translate-rd-python-to-r` skill for a first-pass edit: it converts Python terms/syntax in `\description{}`, `\arguments{}`, and `\value{}` to R-friendly wording, and translates the Python code in `\examples{}` to R.
     - In Claude Code, from the repo root (so `.claude/skills/` is discovered), invoke it as a slash command against the file(s) to curate — one or several, either the `auto-man/` draft or the in-progress `man/` copy:
       ```
       /translate-rd-python-to-r man/
       /translate-rd-python-to-r man/file_name.Rd
       ```
     - It verifies names/behavior against the real R API and the Python source in `synapsePythonClient`, and checks each Rd tag's formatting (title, empty sections, `\arguments{}` vs. `\usage{}`, brace balance in `\examples{}`) — but leaves anything it can't verify for the developer to resolve manually.
   - Review the skill's output (and anything it flagged or left untouched): confirm parameter descriptions and translated code are accurate for R callers before committing.

4. Update `_pkgdown.yml` to reflect any new or modified content. Organize tutorials imported from the Python client under the "Tutorials" section, and place supplementary materials or extended examples in the "Advanced" section under "Further Reading," as appropriate.

5. Check that the newly generated reference pages render successfully. The `override` builds into `site-out/`, the same folder the docs workflow uses, so nothing under `docs/` changes.
   ```bash
   R -e "pkgdown::build_reference(override = list(destination = 'site-out'))"
   ```
6. Check that new or changed home and article pages render successfully. For guidance on additional documentation sections, see https://pkgdown.r-lib.org/reference/index.html.
   ```bash
   R -e "pkgdown::build_home(override = list(destination = 'site-out'))"
   R -e "pkgdown::build_articles(override = list(destination = 'site-out'))"
   ```
   These builds don't run the publishing workflow. To check the whole published site, including the version picker, see [Previewing Documentation in a Fork](#previewing-documentation-in-a-fork).
7. Commit the `auto-man/`, `man/`, `_pkgdown.yml`, and `vignettes/` changes. Do not commit rendered pages: the [docs workflow](#publishing-documentation) builds and publishes the site.
   ```bash
   git add auto-man/ man/ _pkgdown.yml vignettes/
   git commit -m "SYNR-1234: update generated and curated docs for new FooClass wrapper"
   ```

> **Note:** Do not skip the manual review step — Python docstrings often contain Python-specific syntax that renders incorrectly in R documentation.

### Updating the README

`README.md` is knitted from `README.Rmd`, so make README changes in `README.Rmd` and regenerate the other file:
```bash
R -e "devtools::build_readme()"
```
Commit both `README.Rmd` and `README.md`: GitHub shows `README.md` on the repository page, and pkgdown builds the home page from it. The `readme` workflow checks every pull request that changes either file and fails if `README.md` is not what `README.Rmd` knits to. The `docs` workflow runs the same check before it publishes, and publishes nothing if it fails, so a stale `README.md` can't reach the docs site.

## Release Process

### Step 1: Identify scope

Review open [SYNR JIRA tickets](https://sagebionetworks.jira.com/projects/SYNR/issues), set the target version, and assign tickets. All feature work merges to `develop` via Pull Requests (see above).

### Step 2: Staging release

Once all tickets for the release are resolved:

1. Create a release candidate branch from `develop`:
   ```bash
   git checkout -b vX.Y-rc develop
   ```

2. Update `NEWS.md` (changelog) and bump the version in `DESCRIPTION`. Commit and push `NEWS.md` and `DESCRIPTION`

3. On GitHub → [Releases](https://github.com/Sage-Bionetworks/synapser/releases), draft a new release:
   - **Tag**: `X.Y.Z-rc`
   - **Target**: `vX.Y-rc` branch
   - **Title**: `X.Y.Z-rc`
   - **Check** "Set as a pre-release"

4. Notify validators with the release candidate tag (e.g. `3.1.0-rc`).

### Step 3: Validation

Validators install the release candidate from its GitHub tag:

```r
remotes::install_github("Sage-Bionetworks/synapser@X.Y.Z-rc")
```

A pre-release is not deployed to [R-universe](https://sage-bionetworks.r-universe.dev/synapser), which builds only the **latest** full release. Publishing the pre-release does deploy this release candidate's docs to `vX.Y.Z-rc/` on the docs site, so validators can review them (see [Publishing Documentation](#publishing-documentation)).

### Step 4: Patch staging (if needed)

For critical bugs found during validation:
1. Fix on a branch off `vX.Y-rc`, open a PR back to `vX.Y-rc`.
2. After merge, move the `X.Y.Z-rc` pre-release to the new commit by deleting and re-creating the pre-release and its tag. Editing the existing release **does not** move its tag or rebuild the docs: the [docs workflow](#publishing-documentation) runs only when a release is published, so the docs in `vX.Y.Z-rc/` are rebuilt only when the pre-release is published again.
   1. Delete the pre-release and its tag. On GitHub → [Releases](https://github.com/Sage-Bionetworks/synapser/releases), open the `X.Y.Z-rc` release, click **Delete**, then delete the `X.Y.Z-rc` tag under the **Tags** tab. Deleting a release does not delete its tag. Or using GitHub CLI:
      ```bash
      gh release delete X.Y.Z-rc --repo Sage-Bionetworks/synapser --cleanup-tag --yes
      ```
   2. Delete the old tag from your local clone, so it does not get pushed again later:
      ```bash
      git tag -d X.Y.Z-rc
      ```
   3. Re-create the pre-release on the latest commit of `vX.Y-rc` with the same settings as in [Step 2](#step-2-staging-release) step 3 (**Tag** `X.Y.Z-rc`, **Target** `vX.Y-rc`, **Title** `X.Y.Z-rc`, **Check** "Set as a pre-release"). Or, with the GitHub CLI:
      ```bash
      gh release create X.Y.Z-rc --repo Sage-Bionetworks/synapser \
        --target vX.Y-rc --title X.Y.Z-rc --prerelease --generate-notes
      ```
   4. Check that the `docs` workflow run for the new pre-release succeeded on the [Actions tab](https://github.com/Sage-Bionetworks/synapser/actions/workflows/docs.yml), and that the docs in `vX.Y.Z-rc/` show the fix.

   Validators who already installed the release candidate must reinstall it to get the fix, since the tag name is unchanged: `remotes::install_github("Sage-Bionetworks/synapser@X.Y.Z-rc", force = TRUE)`.
3. Notify validators to re-test and re-validate the ticket with the updated release candidate.

### Step 5: Production release

Once all tickets are closed:

1. On GitHub → Releases, draft a new release:
   - **Tag**: `X.Y.Z`
   - **Target**: `vX.Y-rc` branch
   - **Title**: `X.Y.Z`
   - **Do not** check "Set as a pre-release"

   Publishing the release is what deploys it: [R-universe](https://sage-bionetworks.r-universe.dev/synapser) tracks the **latest** GitHub release of synapser, picks up the new tag, and builds source and binary packages for Windows, macOS, and Linux. R-universe [checks package repositories and the registry for changes every hour](https://docs.r-universe.dev/publish/troubleshoot-build.html), so the build can take up to an hour to start. To start the build sooner, trigger a sync manually with the sync button on the [R-universe packages page](https://sage-bionetworks.r-universe.dev/packages).

   R-universe builds the new release only if the synapser entry in `packages.json` in the registry repository, [Sage-Bionetworks/Sage-Bionetworks.r-universe.dev](https://github.com/Sage-Bionetworks/Sage-Bionetworks.r-universe.dev), has `"branch": "*release"`, which [looks up the most recent GitHub release](https://docs.r-universe.dev/publish/set-up.html). With any other value, R-universe builds that branch instead. Check this before publishing the release. It is currently set to `"*release"`.

   Check the build status on the [R-universe builds page](https://sage-bionetworks.r-universe.dev/builds), then confirm the new version installs:
   ```r
   install.packages(
     "synapser",
     repos = c("https://sage-bionetworks.r-universe.dev", "https://cloud.r-project.org")
   )
   packageVersion("synapser")
   ```

2. Merge the release candidate to `master`:
   ```bash
   git checkout master
   git merge vX.Y-rc
   git push upstream master
   ```
   Pushing to `master` runs the docs workflow, which publishes the `stable/` docs at https://r-docs.synapse.org/stable/.

3. Merge `master` back to `develop`:
   ```bash
   git checkout develop
   git merge master
   git push upstream develop
   ```

## Publishing Documentation

Users discover `synapser` through several entry points:

1. Synapse Docs portal: https://r-docs.synapse.org/
2. GitHub repository: https://github.com/Sage-Bionetworks/synapser
3. R-universe: https://sage-bionetworks.r-universe.dev/synapser
4. Synapse R repository (RAN), for synapser 2.x and earlier only: http://ran.synapse.org

Each location should include general `synapser` information and installation guidance. The package documentation site should be the canonical source for full documentation, and the other locations should link to it.

The docs site is built and published automatically by the `docs` GitHub Actions workflow ([`.github/workflows/docs.yml`](https://github.com/Sage-Bionetworks/synapser/blob/develop/.github/workflows/docs.yml)), so rendered pages are not committed to this repository. The home page is built from `README.md`, so the workflow first checks that it matches `README.Rmd` (see [Updating the README](#updating-the-readme)) and publishes nothing if it doesn't. Each build owns one folder on the `gh-pages` branch, which GitHub Pages serves:

| Event | Published to |
|-------|--------------|
| Push to `develop` | `latest/` |
| Push to `master` | `stable/` |
| Production release, tag `X.Y.Z` | `vX.Y.Z/` |
| Pre-release, tag `X.Y.Z-rc` | `vX.Y.Z-rc/`, deleted once `X.Y.Z` is published |

Other pre-release tags (for example `X.Y.Z-test` or `X.Y.Z-rc1`) are not published, and neither are pushes to a `vX.Y-rc` branch. The site root forwards to `stable/` (or to `latest/` until there is a stable version), and the home page of every version has a version picker. The list of versions is `versions.json` at the site root; `.github/scripts/docs_versions.py` rewrites it on every publish.

Documentation updates are part of the release process:

- During a staging release, publishing the pre-release (tag `X.Y.Z-rc`) adds its docs to `vX.Y.Z-rc/`; pushes to the release candidate branch are not published.
- During a production release, publishing the release (tag `X.Y.Z`) adds that version's docs and deletes `vX.Y.Z-rc/`, and merging the release candidate to `master` updates `stable/`.

### Previewing Documentation in a Fork

The local builds in [Regenerating Documentation](#regenerating-documentation) check that pages render. They don't run the publishing workflow, which produces the version picker, the root redirect, `versions.json`, and the final URLs that links resolve to. The `docs` workflow only runs on pushes to `develop` and `master` and on releases, so a pull request never exercises it. To check these before merging to `develop`, publish to GitHub Pages on your own fork. Nothing is published to the real site, because the workflow pushes to the fork's own `gh-pages` branch.

One-time setup on your fork of `Sage-Bionetworks/synapser`:

1. Enable GitHub Actions on the fork (Actions tab). Workflows are disabled on a new fork until you do.
2. Create a `gh-pages` branch. The `docs` workflow fails if it doesn't exist. Copying the real one also brings the existing versions along, so you can see how the version picker looks with them:
   ```bash
   git fetch upstream gh-pages
   git push origin upstream/gh-pages:refs/heads/gh-pages
   ```
   Here `upstream` is `Sage-Bionetworks/synapser` and `origin` is your fork; check yours with `git remote -v`. To start empty instead, use the commands in the header of `docs.yml`.
3. In the fork, go to Settings > Pages and deploy from the `gh-pages` branch, folder `/ (root)`.

Each time you want to preview a change:

1. Create a throwaway branch from your feature branch, for example `docs-preview`, and make these edits on it. They are for the fork only and must not go into the pull request:
   - In `.github/workflows/docs.yml`, add the branch under `on.push.branches`. The workflow only starts on pushes to the branches listed there, which are `develop` and `master`, so without this a push to your preview branch doesn't start a run. 
   - In the same file, set `ref:` in the "Check out publishing tools" step to the same branch, so `docs_versions.py`, `index.html`, and `version-switcher.js` come from your branch instead of the fork's `develop`. Skip this if you didn't change those files.
   - In `_pkgdown.yml`, set `url:` to `https://<your-github-user>.github.io/synapser` so the generated sitemap points at your fork instead of `r-docs.synapse.org`.
2. Push the branch to your fork:
   ```bash
   git push -u origin docs-preview
   ```
3. Watch the `docs` run in the fork's Actions tab. The `readme` and `publish` jobs should pass. Any branch other than `master` is published to `latest/`. Then wait for the `pages-build-deployment` run to finish, which takes a minute or two, and open `https://<your-github-user>.github.io/synapser/latest/`.
4. Check what your change affects: the home page, the reference and article pages, links in `README.md` (relative links resolve under `latest/`), the version picker, and that the site root `https://<your-github-user>.github.io/synapser/` forwards to the first entry in `versions.json`.

Don't open the pull request from `docs-preview`, because it has the throwaway edits. Open it from your feature branch.

When you're done, delete the preview branch, locally and on your fork:
```bash
git branch -D docs-preview                 # -D because the branch was never merged
git push origin --delete docs-preview
```
The fork's `latest/` still shows the preview. To restore it, publish `develop` again by syncing your fork's `develop` with upstream, which starts the `docs` workflow if there are new commits:
```bash
git fetch upstream
git push origin upstream/develop:develop
```
If your fork's `develop` was already up to date, nothing is pushed and no run starts. In that case, open the most recent `docs` run on `develop` in the fork's Actions tab and choose "Re-run all jobs".

## CI/CD

GitHub Actions build and test every change. The build workflow is defined in [`.github/workflows/build.yml`](https://github.com/Sage-Bionetworks/synapser/blob/develop/.github/workflows/build.yml). Package deployment is handled outside this repository's workflows: R-universe builds and serves each full GitHub release (see [Step 5](#step-5-production-release)). The documentation site is built and published by [`.github/workflows/docs.yml`](https://github.com/Sage-Bionetworks/synapser/blob/develop/.github/workflows/docs.yml) (see [Publishing Documentation](#publishing-documentation)). Every push to a fork runs the build and test suite automatically.

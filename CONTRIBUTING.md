# Contributing to synapser

This guide covers development, documentation, and release practices for the [synapser](https://github.com/Sage-Bionetworks/synapser) R package, which wraps the [Synapse Python client](https://github.com/Sage-Bionetworks/synapsePythonClient).

---

## Repository

- **synapser**: https://github.com/Sage-Bionetworks/synapser
- **synapserutils**: https://github.com/Sage-Bionetworks/synapserutils

### Branches

| Branch | Purpose |
|--------|---------|
| `master` | Latest release |
| `develop` | Active development |
| `vX.Y-rc` | Release candidate for version X.Y |

---

## Development Setup

### Prerequisites

- R (check `DESCRIPTION` for minimum version)
- Python (for the embedded Python client)
- `devtools`, `pkgdown`, `styler` R packages

### Configuration

Create `~/.synapseConfig` for Synapse credentials:

```ini
[authentication]
authtoken=your_personal_access_token
```

An example config is at https://github.com/Sage-Bionetworks/synapsePythonClient/blob/develop/synapseclient/.synapseConfig.

### Create a Feature Branch

1. Checkout a new branch from `develop`:
   ```bash
   git checkout develop
   git pull
   git checkout -b SYNR-1234-short-description
   ```
3. On your branch, add these repository secrets (values in LastPass under "Python Client dev stack openssl keys") to enable vignette integration tests in GitHub Actions:
   - `encrypted_d17283647768_iv`
   - `encrypted_d17283647768_key`

---

## Making Changes

### Code Style

Follow [tidyverse style guidelines](http://style.tidyverse.org/). Format files before committing:

```r
styler::style_file("R/your_file.R")
```

You can also utilize `Air - R Language Support` extension from VS code or cursor to allow Air to format R code on save for you. 

### Submitting a Pull Request

Push your branch to your feature branch:

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

Add the exact Python function name (case-sensitive) to this vector when you want it wrapped into `syn*` R functions. 

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

---

## Updating the Python Client Version

The wrapped Python client version is pinned in `R/shared.R`:

```r
PYTHON_CLIENT_VERSION <- 'v4.12'
```

After bumping the version, regenerate documentation (see next section).

---

## Testing Against a synapseclient Feature Branch

To exercise synapser against unreleased changes on a `synapsePythonClient` feature branch (best option if you're iterating on both repos at once), use a persistent virtualenv with an editable install rather than the pinned version in `R/shared.R`.

1. Checkout the feature branch and install it editable into a dedicated venv:
   ```bash
   cd /path/to/synapsePythonClient
   git checkout SYNPY-1234-feature-branch
   python -m venv ~/.venvs/synapser-dev
   source ~/.venvs/synapser-dev/bin/activate
   pip install -e ".[pandas]"
   ```

2. In a **fresh** R session, point `RETICULATE_PYTHON` at that venv before synapser (or reticulate) touches Python, then load synapser:
   ```r
   Sys.setenv(RETICULATE_PYTHON = "~/.venvs/synapser-dev/bin/python")
   devtools::load_all("/path/to/synapser")
   ```

This works because `.onLoad` in `R/zzz.R` calls `py_require()` with the pinned version first, which normally makes reticulate auto-provision an ephemeral uv-managed venv at that exact version. If `RETICULATE_PYTHON` already points to a persistent venv, reticulate uses that env instead — so `import synapseclient` resolves to your editable branch checkout, including any uncommitted edits, with no reinstall needed as you keep editing.

> **Note:** Python binds to the R process once. If you change `RETICULATE_PYTHON` or need to switch branches, restart R — re-running `load_all()` alone won't pick up the change.

To confirm synapser actually loaded your branch (not a stale cached env):

```r
reticulate::py_config()  # check the python: path matches your venv
reticulate::py_run_string("import synapseclient, os; print(synapseclient.__version__); print(os.path.dirname(synapseclient.__file__))")
```

The printed file path should point into your feature-branch checkout.

Because synapser generates its R wrappers by introspecting the Python module at load time, also check whether the branch adds/renames classes or methods that need corresponding updates to the allowlists in `R/shared.R` (see [Adding New Models or Functions](#adding-new-models-or-functions) above) — new Python API surface is otherwise silently omitted from synapser.

---

## Regenerating Documentation (This part is subject to change.)

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
   - Translate Python code examples into R equivalents.
   - Verify parameter descriptions are accurate for R callers.

4. Commit both `auto-man/` and `man/` changes:
   ```bash
   git add auto-man/ man/
   git commit -m "SYNR-1234: update generated and curated docs for new FooClass wrapper"
   ```

> **Note:** Do not skip the manual review step — Python docstrings often contain Python-specific syntax that renders incorrectly in R documentation.

---

## Release Process

### Step 1: Identify scope

Review open [SYNR JIRA tickets](https://sagebionetworks.jira.com/projects/SYNR/issues), set the target version, and assign tickets. All feature work merges to `develop` via Pull Requests (see above).

### Step 2: Staging release

Once all tickets for the release are resolved:

1. Create a release candidate branch from `develop`:
   ```bash
   git checkout -b vX.Y-rc develop
   ```

2. Update `NEWS.md` (changelog) and bump the version in `DESCRIPTION`.

3. Build the pkgdown site:
   ```bash
   R -e "devtools::build_readme()"
   R -e "pkgdown::build_site()"
   ```
   Review `docs/index.html`, then commit and push.

4. On GitHub → [Releases](https://github.com/Sage-Bionetworks/synapser/releases), draft a new release:
   - **Tag**: `X.Y-rc`
   - **Target**: `vX.Y-rc` branch
   - **Title**: `X.Y-rc`
   - **Check** "Set as a pre-release"

   Publishing triggers a GitHub Action that deploys to http://staging-ran.synapse.org.

5. Notify validators with the artifact version (format: `<version>.<build-number>`, e.g. `1.0.87`).

### Step 3: Validation

Validators install from staging RAN:

```r
install.packages("synapser", repos = c("http://staging-ran.synapse.org"))
```

Or via devtools:

```r
devtools::install_github("Sage-Bionetworks/synapser@v2.0-rc")
```

### Step 4: Patch staging (if needed)

For critical bugs found during validation:
1. Fix on a branch off `vX.Y-rc`, open a PR back to `vX.Y-rc`.
2. After merge, publish a new pre-release (repeat Step 2 steps 4–5).
3. Notify validators to re-test and re-validate the ticket with the new artifact.

### Step 5: Production release

Once all tickets are closed:

1. On GitHub → Releases, draft a new release:
   - **Tag**: `X.Y`
   - **Target**: `vX.Y-rc` branch
   - **Title**: `X.Y`
   - **Do NOT** check "This is a pre-release"

   Publishing deploys to http://ran.synapse.org.

2. Merge the release candidate to `master`:
   ```bash
   git checkout master
   git merge vX.Y-rc
   git push upstream master
   ```
   Merging to `master` automatically updates https://r-docs.synapse.org via GitHub Pages.

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
3. Staging RAN: http://staging-ran.synapse.org
4. Production RAN: http://ran.synapse.org

Each location should include general `synapser` information and installation guidance. The package documentation site should be the canonical source for full documentation, and the other locations should link to it.

Documentation updates are part of the release process:

- During staging release builds (artifact publication to staging RAN), regenerate docs and commit updates to the release candidate branch.
- During production release, merge the release candidate branch to `master`; this updates the published docs site.

## CI/CD

GitHub Actions drive all builds and deployments. The workflow is defined in [`.github/workflows/build.yml`](https://github.com/Sage-Bionetworks/synapser/blob/develop/.github/workflows/build.yml). Every push to a fork runs the build and test suite automatically.

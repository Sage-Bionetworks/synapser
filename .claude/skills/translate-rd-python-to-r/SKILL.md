---
name: translate-rd-python-to-r
description: Translate the Python prose and code in a synapser .Rd file (man/) — Description, Arguments, Value, and Examples — into R-friendly, verified content. Use when asked to translate/convert/fix/rewrite a generated .Rd file.
---

# Translate a generated Rd page from Python to R

## Background

synapser wraps the Python `synapseclient` package. Its `.Rd` docs are drafted
automatically from Python docstrings (see `generateRdFiles`/`autoGenerateRdFiles`
in `R/PythonPkgWrapperUtils.R`), and `CONTRIBUTING.md` describes the human
curation step that turns an `auto-man/` draft into a real `man/` page.

The generator's own roxygen docs say this plainly (`R/PythonPkgWrapperUtils.R`,
`@note` on `generateRdFiles`): *"Python documentation may contain key words
and terms that are only meaningful to Python users. The generated .Rd files
... do not auto correct these terms ... One must ... make sure that the
language being used in these documents is friendly to R users."* That
correction is this skill's job, across **every** section — not just
Examples.

`\examples{}` code is copied verbatim into a real `\dontrun{}` block (see
`.buildExamplesRdContent`) so it renders in the docs, but it's still Python
syntax. Description/Arguments/Value text goes through more automated cleanup
(`pyVerbiageToLatex`, mkdocstrings cross-ref conversion, markdown→Rd) but that
cleanup is syntactic, not semantic — it fixes markup, not vocabulary or stale
references.

## Ground truth over guessing

Never translate a name, or a claim that some behavior/function exists, from
what "seems right" in the Python text — verify it every time. Two traps
already found in this exact codebase:

- A `synapse_client` argument's boilerplate description across many pages
  says caching can be controlled via `Synapse.allow_client_caching(False)`.
  But `allow_client_caching` is listed in `.modelClassMethodsToOmit` in
  `R/shared.R` — it's *deliberately excluded* from doc generation, so there
  is no `synAllowClientCaching()` in the current R API. Translating that
  sentence into a fabricated R call would document a function that doesn't
  exist. When a Python capability isn't exposed in R drop the detail.

Before using any name, verify it:
- A page's own `\usage{}` line is ground truth for that page's function name
  and argument names/order.
- For a class method exposed through the functional interface (Python
  `dataset.get_acl(...)`), the real generic name lives in the sibling draft
  `auto-man/<Class>_<Method>.Rd`'s `\name{}`/`\alias{}` — the shared,
  unqualified name (e.g. `synGetAcl`), not the class-qualified file name.
- A handful of names are deliberately renamed away from the naive
  Python-method → R-name mapping. `R/shared.R`'s
  `.functionNameMappingSynapse()` and
  `.functionNameMappingSynapseclientModels()` are applied by `applyFunctionNameMapping()`
  (`R/PythonPkgWrapperUtils.R`) during both wrapper and Rd generation, so a
  current `auto-man`/`man` page's `\name{}`/`\alias{}` already reflects the
  mapped name — but if you're deriving a name straight from the Python
  method name instead of reading it off the Rd file, check this table first
  so you don't reproduce the pre-mapping default.
- If unsure whether a wrapper exists at all, grep for it:
  `grep -rn "<name>" auto-man/ man/ R/`, and check `R/shared.R`'s
  `.modelClassMethodsToOmit` / class filters for deliberate exclusions.

**When still uncertain, stop and leave it.** Do not invent a name, argument,
behavior, or example to fill a gap — if verification doesn't turn up a clear
answer (the R equivalent isn't obvious, the grep is ambiguous, the intended
meaning of a stale/empty description can't be determined), leave that spot
as-is and call it out in your response to the developer, rather than
guessing. Don't write review notes into the Rd content itself — tag bodies
render as visible text in the built documentation, so anything like "needs
double check" placed there would leak into shipped docs; flagging it in
conversation is what lets a human resolve it by hand before it ships (see
`CONTRIBUTING.md`'s documented review step). A wrong translation that reads
plausibly is worse than an untouched Python-ism, since the latter is at
least visibly incomplete.

## Section by section

### Description, Arguments, Value and Returns

These already went through automated markup conversion (markdown →
Rd), so don't restructure formatting that already works. Look specifically
for leftover **Python vocabulary and syntax** in the prose:

- **Booleans/None**: `True`/`False`/`None` in prose → `TRUE`/`FALSE`/`NULL`.
  Real example, `Dataset_GetAcl.Rd`: *"If True (default), check the
  benefactor... If False, only check the entity itself."*
- **Collections**: "dict"/"dictionary"/"OrderedDict" → "named list" (what the
  R argument actually accepts); Python "tuple" → R "vector" or "list"
  depending on what's actually returned/accepted.
- **Method-call syntax embedded in prose**: Python `Class.method(...)` or
  `.method()` referring to a Python API call needs either (a) the verified R
  equivalent (`synMethodName(...)`) if one is actually exposed, or (b) plain
  English if it isn't — see the `allow_client_caching` trap above. Same
  applies to `\code{.reorder_column()}`-style leftover dot-method mentions in
  `\section{Methods}{}` text — the real R callable is `synReorderColumn()`,
  not `.reorder_column()`.
- **Exception language**: "will raise a ValueError"/"raises TypeError" →
  describe it in R terms ("will raise an error"), since R doesn't have
  Python's exception classes.
- **Leftover mkdocstrings cross-refs**: `.convertMkdocstringsCrossRefs` in
  `R/PythonPkgWrapperUtils.R` only handles the *bare* form
  `[qualified.name][]`. The *aliased* form `[display text][qualified.path]`
  is **not** auto-converted and leaks straight through — real example still
  visible in `Dataset_GetAcl.Rd`: `[ACL][synapseclient.core.models.permission.Permissions.access_types]`.
  Fix these by hand: `\code{\link[=synX]{display text}}` if `synX` is a
  real, verified R page. If not, don't just drop to plain text — first grep
  `synapsePythonClient/synapseclient/` for an existing
  `https://python-docs.synapse.org/...` link to that same class/module in
  another docstring, and reuse that exact full path verbatim; a docstring
  that already links to the page is ground truth for its real published URL,
  not a path to re-derive. Only if no such existing link turns up, fall back
  to checking whether `qualified.path`'s class/module has a page under
  `synapsePythonClient/docs/reference/` (grep for its `::: module.Class`
  mkdocstrings directive) and constructing `\href{https://python-docs.synapse.org/<page-path>/}{display text}`
  from that (the URL mirrors the doc's path under `docs/reference/`,
  directory-style — real example already in this codebase:
  `auto-man/synLogin.Rd`'s
  `\href{https://python-docs.synapse.org/tutorials/authentication/}{personal access token}`,
  for `docs/tutorials/authentication.md`). Link to the page, not a guessed
  member-level anchor — mkdocstrings' exact anchor id for a specific
  method/attribute isn't reliably derivable from the qualified path without
  building the docs, so don't fabricate one. Only fall back to plain display
  text if no matching reference page exists either.
- **REST API / Java-model references**: `https://rest-docs.synapse.org/rest/`
  (auto-generated REST API javadoc) is the other real external reference
  site already used throughout this codebase — dozens of `auto-man/` pages
  already carry working links converted straight from markdown in the
  Python docstrings, e.g. `AgentSession.Rd`:
  `\href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/agent/AgentSession.html}{Synapse Agent Session}`,
  plus `Team.Rd`, `WikiPage.Rd`, and the `AccessControlList`/`EntityType`/
  table `Row` links throughout `*_SetPermissions.Rd`/`*_Query*.Rd` pages. The
  URL pattern is the Java fully-qualified class name with dots replaced by
  slashes plus `.html` (`org.sagebionetworks.repo.model.Team` →
  `.../rest/org/sagebionetworks/repo/model/Team.html`). Use it the same way
  as the Python-docs fallback above: when a leftover reference is to a REST
  schema/Java model class rather than a Python one, construct or verify the
  link from the real fully-qualified Java class name rather than guessing,
  and sanity-check any link you carry forward isn't truncated — malformed
  versions of exactly this link have shipped before (now-superseded, but
  real: `auto-man-old/synGetAcl.Rd` and `auto-man-old/synGetPermissions.Rd`
  both cut off mid-path at `https://rest-docs.synapse.org/rest/org/`).
- **Empty/missing descriptions**: some constructor arguments have no
  description at all (e.g. `_last_persistent_instance`, `view_type_mask` in
  `Dataset.Rd`) — that's a documentation gap, not a Python-ism; fill it in if
  you can determine the real meaning, otherwise leave it rather than
  guessing.

### Examples

Apply these translation rules to the Python code inside `\dontrun{}`,
grounded in the places in this repo that already show verified, working
R usage: `vignettes/tables.Rmd` and `vignettes/data_upload_download.Rmd`
(real, maintained examples covering entity store/get/delete, annotations,
and versioning). When a page's example overlaps with something these
vignettes already demonstrate (creating a `File`/`Folder`, `synStore()`,
`synGet()`, `synSetProperties()`, `synDelete()`, etc.), match their calling
convention exactly rather than guessing at argument names or shapes. These
two are the only vignettes to treat as ground truth for current calling
convention and code style — the rest of `vignettes/` (`installation.Rmd`,
`synapser.Rmd`, `troubleshooting.Rmd`, `upload.Rmd`, `views.Rmd`, etc.)
predate the latest changes and haven't been updated to match, so don't pull
style or API usage from them.

A docstring's example often walks through a full workflow end-to-end (e.g.
login, create, configure, upload, verify) — translate every step of it.
The numbered rules below call out specific lines to remove or rewrite
(imports, login boilerplate, sync/async duplication, stray Rd markup); they
are not license to drop a step or shorten the workflow for brevity. Only
remove a line when one of these rules (or an already-established rule
elsewhere in this skill) says it's no longer needed — never remove a step
that demonstrates distinct functionality.

1. **Drop imports.** `from synapseclient import Synapse`,
   `from synapseclient.models import X, Y` — delete.
2. **Login boilerplate.** Python's `syn = Synapse(); syn.login()` becomes a
   single `synLogin()` call.
3. **Object construction stays a direct call**, same argument names as
   Python — verify them against the page's own `\usage{}` line.
4. **Method calls become piped generics**: Python `obj.method(args)` → R
   `obj |> synMethodName(args)` (native pipe; package requires R >= 4.1).
   Resolve `synMethodName` via ground truth, not by guessing. The functional
   interface's first formal is always literally named `instance`, typed to
   a specific class — real example, `Dataset_GetAcl.Rd`'s `\usage{}`:
   `synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`,
   whose `\arguments{}` pins it to `\item{instance}{(Dataset) The Dataset
   instance to operate on.}`. Make sure the object you pipe in or pass as
   `instance` is actually an instance of that same class — don't reuse an
   object constructed for a different page's example. The equivalent
   non-piped call is `synMethodName(instance = obj, args)`. Prefer the piped
   form to match `vignettes/tables.Rmd`'s style, but the named-`instance`
   form is a valid alternative worth showing when it reads more clearly
   (e.g. multiple examples reusing the same object).
5. **Attribute access uses `$`**: Python `obj.attr` → R `obj$attr` (matches
   `table$id` in `vignettes/tables.Rmd`).
6. **Collections**: Python list `[a, b, c]` → R `list(a, b, c)`; Python dict
   `{"key": val}` → R named list `list(key = val)`.
7. **String formatting**: f-strings/`.format()`/`%`-formatting →
   `sprintf(...)`.
8. **Tabular input data**: `pd.DataFrame(...)` used to build *input* → R
   `data.frame(...)`. Don't touch DataFrames the API actually *returns*.
9. **Drop async/sync duplication**: synapser only exposes the synchronous
   call — there's no R equivalent of `async def main(): ... /
   asyncio.run(main())`. Translate one R example, not a sync+async pair.
10. **No Rd markup inside `\examples{}`**: it's parsed as raw verbatim text,
    so a stray `\code{x}`/`\href{}{}` left from the docstring renders as
    literal backslashes — strip to plain text.
11. **Keep the itemization convention**: `## Example N: Title` comments, not
    real `\itemize{}` (illegal inside `\examples{}`, hard-errors R's parser).
12. **Keep `\dontrun{}`**: these touch a live Synapse instance and need real
    credentials.
13. **Assignment and spacing**: match `vignettes/tables.Rmd`'s style — `=`
    for assignment (`project = Project(...) |> synStore()`, `results =
    synQuery(...)`), not `<-`, with spaces around `=` in both assignment and
    named arguments (`name = "Name"`, not `name="Name"`).
14. **Quote style**: string literals use double quotes, matching every
    string in `vignettes/tables.Rmd` (`"STRING"`, `"My Favorite Genes..."`).

## Check completeness against the Python source

The auto-generated draft can silently drop or truncate content from the
original docstring (missing arguments, a skipped Value/Returns paragraph, a
missing example). Before finishing a page, find the real Python docstring it
was drafted from — the class/method lives under
`synapsePythonClient/synapseclient/` (e.g. models in
`synapseclient/models/<name>.py`, e.g. `file.py`, `folder.py`, `dataset.py`;
client methods in `synapseclient/client.py`; REST-adjacent helpers under
`synapseclient/api/`) — and compare section by section:

- Every parameter documented in the Python docstring should have a
  corresponding `\item{}` in `\arguments{}` (modulo any deliberately omitted
  per `.modelClassMethodsToOmit`/class filters).
- The Value/Returns description should reflect everything the Python
  docstring says is returned, not a truncated subset.
- If the Python docstring has multiple examples, check whether the `.Rd`
  dropped any — if so, that's a gap to flag, not necessarily one to fill
  in blind (see "leave it" above if the right R translation isn't obvious).

If the `.Rd` is missing something the Python source documents, flag it to
the developer in your response either way: if you can translate it
confidently (verified name, real behavior), add it and say what you added;
if you can't verify it confidently, leave it and say what's missing, rather
than guessing — same rule as above: don't write the gap into the Rd content
itself, since tag bodies render into shipped docs.

## Verify section formatting

Auto-generation runs the same template across ~240 pages, so the same
placeholder/formatting defects recur verbatim. Check each tag itself, not
just its prose, against these patterns found in this exact codebase:

- **`\title{}`**: class pages get a plain, correct title (`\title{File}`,
  `\title{Dataset}`). Method pages instead get the raw template
  `Class :  method_name` — snake_case Python method name, a doubled space
  around the colon. Real example: `Dataset_GetAcl.Rd` → `Dataset :  get_acl`.
  Do not rewrite this — like `\name{}`/`\alias{}`/`\usage{}`, it's defined by
  the generator/code rather than prose this skill translates. Leave it as-is
  even in the raw `Class :  method_name` form, and leave it as-is (along with
  the rest of the page).
- **`\description{}`**: watch for decorator/wrapper boilerplate that isn't a
  real description at all — real example, 
`\description{Wrapper for the function to be traced.}` says nothing about
  what the function does. This placeholder means the generator failed to
  introspect the underlying Python method for this page at all — check
  `\usage{}` on the same page; it's typically also missing every parameter
  but `instance` (compare against the class's other method pages, which
  normally list the full signature, e.g. `Dataset_GetAcl.Rd`'s
  `synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)`).
  Do not hand-author `\usage{}`/`\arguments{}` content to fill this gap —
  a guessed signature can silently omit or misname a real parameter, and
  the resulting Rd would look authoritative while being wrong. Instead,
  flag the page to the developer as a generation failure (name the file and
  quote the placeholder text) and leave the file unedited; regenerating the
  page from the Python source is the correct fix, not writing replacement
  prose by hand.
- **`\keyword{}`**: top-level `syn*` function pages are routinely left with
  an empty `\keyword{}` tag (currently 18 occurrences in `auto-man/`,
  e.g. `synGet.Rd`, `synStore.Rd`, `synDelete.Rd`, `synLogin.Rd`), while
  class-method pages get a real `\keyword{ClassName}`. An empty tag should be deleted.
- **`\arguments{}`**: every `\item{name}{...}` must have a matching parameter
  in the `\usage{}` line, same names, same order — diff the two lists
  directly rather than eyeballing them.
- **`\value{}` / `\note{}` / `\seealso{}`**: these are optional, but if
  present they must read as complete sections, not a placeholder or a
  fragment. An empty tag (e.g. `\value{}`) is the same defect as the
  `\keyword{}` case above. Also watch for text that opens mid-sentence
  because a preceding line was stripped out — real example, `Dataset_GetAcl.Rd`'s
  `\note{}` begins "on it, this will look up the ACL on the benefactor of the
  entity..." with no subject for "on it" — the lead-in sentence is missing
  and needs to be reconstructed or removed.
- **`\examples{}`**: check the brace balance explicitly rather than trusting
  indentation — the whole block should close as `\examples{ \dontrun{ ... } }`,
  i.e. exactly two closing braces at the end, one per opening tag.

## Validate before calling it done

After editing, confirm the file still parses as valid Rd:

```r
tools::parse_Rd("man/<File>.Rd")
```

This only checks Rd-level structure (balanced braces, valid tags) — it
doesn't check that the R code inside `\dontrun{}` runs, or that a claim about
R behavior is accurate. This environment has no Synapse credentials or
network access, so translated content is verified to be *syntactically valid
and consistent with the real, currently-generated API surface*, not proven
to execute end-to-end. Say so explicitly rather than claiming it's tested,
and suggest the user smoke-test it before release.

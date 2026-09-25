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
  `dataset.get_acl(...)`), the real generic name to call or refer to in
  prose lives in the sibling draft `auto-man/<Class>_<Method>.Rd`'s
  `\name{}` — the shared, unqualified name (e.g. `synGetAcl`), not the
  class-qualified file name. This is `\name{}` specifically, not `\alias{}`:
  that same page's `\alias{}` is the class-qualified form (`Table_synGetAcl`),
  not the bare name — see "Cross-reference other functions" below for how
  that changes what goes inside `\link[=X]{}`.
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

**Typos vs. factual errors in the Python prose.** An unambiguous
spelling/grammar typo in the underlying Python docstring (e.g. `addiitional`
→ `additional`, `contruction` → `construction`, `mnay` → `many`,
subject-verb slips like "The API have a limit" → "The API has a limit") is
safe to fix silently while translating the surrounding text — leaving it
untouched while everything around it gets cleaned up reads as an oversight,
not a deliberate choice. This is different from prose that's factually
*wrong* relative to the code sitting right below it — real example,
`table_components.py`'s `upsert_rows_async` Example 2 ("Deleting data from a
specific cell") had an intro comment copy-pasted from Example 1, describing
values being set to `22`/`33` when the actual code nulls out cells to
demonstrate deletion. Verify against the code before rewriting a description
like this, and say explicitly in your response that you corrected it — don't
just silently patch over a factual mismatch the way you would a typo.

## Section by section

### Description, Arguments, Value and Returns

These already went through automated markup conversion (markdown →
Rd), so don't restructure formatting that already works. Look specifically
for leftover **Python vocabulary and syntax** in the prose:

- **Booleans/None**: `True`/`False`/`None` in prose → `TRUE`/`FALSE`/`NULL`.
  Real example, `Dataset_GetAcl.Rd`: *"If True (default), check the
  benefactor... If False, only check the entity itself."* This is for
  prose/argument-default `None` — a Python `None` used as an actual **data
  value** (e.g. a dict entry standing for a missing table cell in an
  example) is different: translate it to R's `NA`, not `NULL`. Real
  example, `table_components.py`'s `upsert_rows_async` example: `'col2':
  [None, 2]` (nulling out a cell) → `col2 = c(NA, 2)`, not `NULL`.
- **Markdown bold leftover**: `**text**` markdown bold syntax sometimes
  survives the markdown→Rd conversion untouched (real example,
  `Table_DeletePermissions.Rd`'s `**Special notice for Projects:**`).
  Convert to `\strong{text}` — verified as a real, correctly-rendering Rd
  macro (`tools::Rd2txt`/`Rd2HTML` both render it as bold), not a fabricated
  tag.
- **Mermaid diagrams**: a docstring's fenced ` ```mermaid ` code block (e.g.
  `Table_StoreRows.Rd`, `Table_UpsertRows.Rd`) gets mangled by the
  markdown→Rd conversion — the triple-backtick fence and inline
  single-backticks inside the diagram get scrambled into malformed
  sequences like `` ``\code{mermaid `` and `` }`\code{ ``. Rd has no native
  diagram rendering, so reconstruct the block as a `\preformatted{}` tag
  using the diagram's actual source lines from the Python docstring
  (dropping the markdown backtick-emphasis around identifiers inside the
  diagram, e.g. `` `file_handle_id` `` → `file_handle_id`, since
  `\preformatted{}` is verbatim text, not markdown).
- **Multi-line prose and itemized (`- `) lists need `\cr` in exactly one
  place, not sprayed everywhere**: Rd collapses a bare line break the way
  LaTeX/nroff does — any two lines with no blank line and no `\cr` between
  them get joined into one run-on paragraph. This bites a Python docstring's
  `Raises:` list (`ValueError: ...` / `SynapseHTTPError: ...` /
  `Exception: ...`) or a return-shape breakdown (`- entity_acls: ...` /
  `- Each EntityAcl ...`) hardest, since those are meant to render as
  separate lines, not flow together. This codebase's convention for this
  kind of inline list is manual `- text` bullets, not `\itemize{}` (not used
  for this pattern anywhere in `man/`).

  **Where `\cr` goes is narrow.** It belongs *only* on the last physical
  line of a list item, and *only* when that item isn't already followed by
  a blank line or (inside a `\section{Methods}{}` bullet list) a fresh
  `\item` — both of those already force separation on their own, so a `\cr`
  there is redundant, not wrong, but unnecessary. It does **not** belong on:
  a line that's just a word-wrapped continuation of the same sentence (let
  those flow together with no `\cr` — the wrap point in the source file is
  not a real line break, and this holds even for plain flowing prose that
  isn't a list at all, e.g. `Dataset_GetAcl.Rd`'s benefactor `\note{}`).
  Verified empirically with `tools::Rd2txt("path.Rd")` on a minimal test
  file: a genuine blank source line, with no `\cr` at all, correctly starts
  a new rendered paragraph even *inside* an `\itemize{}` `\item` body — so
  paragraph breaks never need `\cr`, only item-to-item breaks with no blank
  line between them do.

  Concretely, for a bullet like `Table_StoreRows.Rd`'s:
  ```
  - Synapse limits the number of rows that may be stored in a single request to
      a CSV file that is 1GB. If you are storing a CSV file that is larger than
      ...
      number of bytes that are being sent.
  - The limit of 1GB is also enforced when storing a named list or a DataFrame.
  ```
  only the last line of the first item (`...number of bytes that are being
  sent.`) gets a trailing `\cr`, to separate it from the next `- ` item —
  the earlier wrapped lines of that same sentence get none. A first attempt
  at this exact bullet added `\cr` to every line including the wraps, which
  rendered as forced mid-sentence line breaks instead of one flowing
  paragraph — the fix was to strip those back out and keep only the one
  `\cr` at the true item boundary.

  Files with this defect, fixed this way: `Project_ListAcl.Rd`/
  `Table_ListAcl.Rd`'s `\value{}` and `\section{Errors}{}`, `Project_Walk.Rd`'s
  `\value{}` (each item there is a single physical line, so every non-last
  item gets exactly one `\cr`), `Project_DeletePermissions.Rd`/
  `Table_DeletePermissions.Rd`'s `\section{Errors}{}` (given dashes for
  consistency, since both come from the same kind of `Raises:` block), and
  `Table_StoreRows.Rd`/`Table_UpsertRows.Rd`/`Table.Rd`'s `Limitations:`/
  column-order lists inside `\description{}`. When the same prose is
  duplicated across files (a standalone `<Class>_<Method>.Rd` page *and* the
  copy embedded in `<Class>.Rd`'s Methods bullet, or the same content
  repeated across sibling classes like `Table_StoreRows.Rd`/
  `Table_UpsertRows.Rd`), check every copy landed the fix, not just the one
  you edited first — they drift apart otherwise. Automated checks
  (`tools::parse_Rd()`, `Rd2ex`) won't catch this — a run-on paragraph is
  still syntactically valid Rd — so verify by eye or by rendering with
  `tools::Rd2txt()`/`Rd2HTML()` and checking the line breaks actually show
  up where intended.
- **Leftover `ForwardRef(...)` in a type annotation**: real example,
  `Table_BindSchema.Rd`'s `synapse_client` item: `(Optional[ForwardRef('Synapse')])`.
  Generator artifact (`_format_annotation()` in `inst/python/pyPkgInfo.py`
  doesn't unwrap Python's quoted forward-reference type hints), not prose to
  interpret. Fix mechanically by stripping the wrapper: `Optional[ForwardRef('Synapse')]`
  → `Optional[Synapse]`. Expect this wherever `synapse_client` (or another
  forward-ref-typed argument) has no explicit type spelled out in its
  docstring line — it's generator-wide, not page-specific.
- **Collections**: "dict"/"dictionary"/"OrderedDict" → "named list" (what the
  R argument actually accepts); Python "tuple" → R "vector" or "list"
  depending on what's actually returned/accepted.
- **Plain Python primitive type annotations in `\item{}` tags**: the
  parenthetical at the start of an argument's description (`(str)`, `(int)`,
  `(bool)`, `(float)`) is the Python type name and needs the R equivalent:
  `str` → `character`, `int` → `integer`, `bool` → `logical`, `float` →
  `numeric`. This is easy to skip past *because* nothing else about a plain
  `(str)` looks broken — unlike a stray `ForwardRef(...)` wrapper or a dict/
  tuple, it reads as already-fine prose. Real examples caught only after
  merge, by a later review pass rather than during translation:
  `Team_FromName.Rd`/`Team_GetUserMembershipStatus.Rd`'s `(str)` args,
  `Team_FromId.Rd`'s `(int)` arg. `Union[str, int]`-style compound
  annotations (e.g. `Team_InviteToTeam.Rd`'s user-identifier argument) have no
  single R type name — describe the accepted values in plain English instead
  (e.g. "a username or a numeric user ID"), not Python syntax. Check every
  `\item{}` in `\arguments{}` for this, not just the ones another bullet here
  already flags for a different reason. When several sibling pages share the
  same underlying Python docstring/argument (common across the functional
  interface for one class, e.g. the `Team_*.Rd` family), the same leftover
  annotation is duplicated across all of them — fixing it on one page doesn't
  fix the others, so grep across the set:
  `grep -rn "(str)\|(int)\|(bool)\|(float)\|Union\[" man/<Class>_*.Rd`.
- **Method-call syntax embedded in prose**: Python `Class.method(...)` or
  `.method()` referring to a Python API call needs either (a) the verified R
  equivalent (`synMethodName(...)`) if one is actually exposed, or (b) plain
  English if it isn't — see the `allow_client_caching` trap above. Same
  applies to `\code{.reorder_column()}`-style leftover dot-method mentions in
  `\section{Methods}{}` text — the real R callable is `synReorderColumn()`,
  not `.reorder_column()`.
- **Cross-reference functions only when a real Rd target exists**: after
  verifying the R callable name, prefer a link over plain `\code{}`:
  `\code{\link[=X]{synX}()}` instead of `\code{synX()}`.

  Resolve `X` class-aware by checking both plain and class-qualified aliases
  in `auto-man/` and `man/`:
  - plain function: `grep -rl "\\\\alias{synX}$" auto-man/*.Rd man/*.Rd`
  - shared method on current class: `grep -rl "\\\\alias{<CurrentClass>_synX}$" auto-man/*.Rd man/*.Rd`

  For shared methods, the link target is **always** class-qualified
  (`Table_synX`, `Project_synX`, ...), never bare `synX`. These pages usually
  have `\name{synX}` but only `\alias{<Class>_synX}` entries, so
  `\link[=synX]{synX}` will not resolve. Verify aliases with:
  `grep -n "^\\\\alias{" man/<Class>_<Method>.Rd` (or `auto-man/...`).

  Apply class-qualified links everywhere that shared method name appears:
  - class-page `\section{Methods}{}` bullets (except constructor bullets that
    already use `\link{ClassName}`)
  - prose references, including self-references and sibling-method references

  Formatting rule: put only the bare function name inside
  `\link[=X]{...}`; keep trailing `()` and surrounding words outside the
  `\link{}` but inside outer `\code{}`.
- **Exception language**: "will raise a ValueError"/"raises TypeError" →
  describe it in R terms ("will raise an error"), since R doesn't have
  Python's exception classes.
- **Leftover mkdocstrings cross-refs**: `.convertMkdocstringsCrossRefs` in
  `R/PythonPkgWrapperUtils.R` only handles the *bare* form
  `[qualified.name][]`. The *aliased* form `[display text][qualified.path]`
  is **not** auto-converted and leaks straight through — real example still
  visible in `Dataset_GetAcl.Rd`: `[ACL][synapseclient.core.models.permission.Permissions.access_types]`.
  Fix these by hand: `\code{\link[=synX]{display text}}` if `synX` is a
  real, verified R page. If not, don't just drop to plain text — check first
  whether the referenced member is really a **REST/Java-modeled concept**
  wearing a Python name, not a Python-only one. `Permissions.access_types` is
  exactly this — it's the `ACCESS_TYPE` enum (`READ`, `WRITE`,
  `CHANGE_PERMISSIONS`, ...), a REST API concept the Python class merely
  re-exposes, so it belongs on `rest-docs`, not `python-docs`, per the REST
  API / Java-model rule below — matching the identical concept already
  linked (still in raw, untranslated form) in
  `auto-man/SchemaOrganization_UpdateAcl.Rd`'s `access_type` argument. The
  verified correct target is
  `\href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}`.
  Get this check wrong and the grep-for-an-existing-link fallback below will
  cheerfully hand you a real but *wrong* page: `Table_GetAcl.Rd`/
  `Project_GetAcl.Rd` were originally (mis)translated exactly this way — by
  grepping for an existing `python-docs.synapse.org` link to the
  `Permissions` class and reusing
  `https://python-docs.synapse.org/reference/permissions/` — a real page,
  but for the wrong thing: the general `Permissions` class, not the
  `access_types` enum this specific member is about. So before grepping
  `synapsePythonClient/synapseclient/` for an existing
  `https://python-docs.synapse.org/...` link to that same class/module in
  another docstring and reusing that exact full path verbatim (a docstring
  that already links to the page is ground truth for its real published
  URL, not a path to re-derive) — confirm any hit actually documents the
  *specific member* in the qualified path, not just the same top-level class
  under a broader/different meaning. Only if the REST-concept check doesn't
  apply and no matching `python-docs` link turns up, fall back to checking
  whether `qualified.path`'s class/module has a page under
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
  and sanity-check any link you carry forward isn't truncated — one that cuts
  off mid-path (`https://rest-docs.synapse.org/rest/org/` with no class after
  it) is a silent 404 rather than a visible error.
- **Empty/missing descriptions**: some constructor arguments have no
  description at all (e.g. `view_type_mask` in
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

**Shared mixin-method examples may not demonstrate the class you're
translating.** Methods like `bind_schema`/`unbind_schema`/`get_schema`/
`get_schema_derived_keys`/`validate_schema` live on a shared mixin
(`synapseclient/models/mixins/json_schema.py`) and are exposed per-class
through the functional interface (`Table_BindSchema.Rd`, `Folder_BindSchema.Rd`,
`File_BindSchema.Rd`, ...). Since there is exactly one underlying Python
docstring per method, its one `Example` gets copy-pasted verbatim into every
class's generated page — and that shared example only demonstrates a subset
of the classes the method actually applies to. Real case: the mixin's
docstring only ever shows `Folder` + `File`, even though `Table`, `Project`,
`EntityView`, `Dataset`, etc. each get their own page for the same method. So
`Table_BindSchema.Rd` shipped with an example that never constructs a
`Table` at all — directly contradicting its own `\arguments{}`
(`instance: (Table) ...`) and `\keyword{Table}`.

When translating this kind of page, don't carry the shared example over
as-is — rewrite the entity-construction-and-usage portion to actually build
and use an instance of the page's own class, e.g. `Table(name = ..., parent_id
= ...) |> synStore()` in place of the shared example's `Folder(...)` /
`File(...)` pair, dropping variables that were only needed for the dropped
class (`FOLDER_NAME`, `FILE_PATH`). Keep the rest of the shared workflow
(org/schema setup, teardown) intact — only the part that names a specific
entity type needs to change. Verified fix applied this way to
`Table_BindSchema.Rd`, `Table_GetSchema.Rd`,
`Table_GetSchemaDerivedKeys.Rd`, `Table_UnbindSchema.Rd`, and
`Table_ValidateSchema.Rd`. Check sibling pages for the same method (e.g.
`grep -rl "test_folder\|FOLDER_NAME" man/*.Rd` to find pages still carrying
the stale Folder/File example) since each one needs this same treatment
independently — fixing one page's copy doesn't fix the others.

1. **Drop imports, add `library(synapser)`.** Python's `from synapseclient
   import Synapse`, `from synapseclient.models import X, Y` — delete; R
   examples instead start with a single `library(synapser)` call, matching
   `vignettes/tables.Rmd` and `vignettes/data_upload_download.Rmd` (both
   load the package once, before `synLogin()`).
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
7. **Integer literals need `L`**: R distinguishes integer (`42L`) from
   double (`42`) literals; Python doesn't. When a whole-number literal is
   passed as an *argument value* corresponding to an `int`-typed parameter
   (per the page's own type tag, e.g. `(int)` on `index`, `principal_id`,
   `job_timeout`), append `L` — `index=0` → `index = 0L`,
   `principal_id=273948` → `principal_id = 273948L`. This is about argument
   values specifically, not general data (e.g. don't force `L` onto
   `data.frame()` column values just because they happen to be whole
   numbers). Easy to miss since both forms parse as valid R — get it right
   the first time rather than relying on a follow-up pass.
8. **Python enum member access → bare R string**: `EnumClass.MEMBER_NAME`
   (e.g. `SchemaStorageStrategy.INFER_FROM_DATA`, `ColumnType.STRING`) → the
   plain string `"MEMBER_NAME"` in R, not an enum-accessor object — verify
   first that no dedicated R page exists for that enum class (e.g. no
   `auto-man/SchemaStorageStrategy.Rd`), confirming it isn't exposed as an R
   object with its own accessor.
9. **String formatting**: f-strings/`.format()`/`%`-formatting →
   `sprintf(...)`. **Every `%` in the result must be written `\%`.** `%` opens
   a comment in Rd everywhere, including inside `\examples{}` and
   `\dontrun{}`, so a bare one swallows the rest of its line — `sprintf("%s",
   x)` loses its closing quote and the examples block stops rendering
   entirely. `tools::parse_Rd()` still succeeds and `R CMD check` never parses
   a `\dontrun{}` body, so nothing flags it. This applies to every `%` on the
   page, not just `sprintf()` formats: `50%` in a description needs `50\%`
   too.
10. **Tabular input data**: `pd.DataFrame(...)` used to build *input* → R
    `data.frame(...)`. Don't touch DataFrames the API actually *returns*.
    Pandas boolean-mask cell assignment follows the same input-data
    translation: `df.loc[df['col'] == 'A', 'col2'] = 22` → R's bracket
    indexing, `df[df$col == "A", "col2"] = 22`.
11. **Drop async/sync duplication**: synapser only exposes the synchronous
    call — there's no R equivalent of `async def main(): ... /
    asyncio.run(main())`. Translate one R example, not a sync+async pair.
12. **No Rd markup inside `\examples{}`**: it's parsed as raw verbatim text,
    so a stray `\code{x}`/`\href{}{}` left from the docstring renders as
    literal backslashes — strip to plain text.
13. **Keep the itemization convention**: `## Example N: Title` comments, not
    real `\itemize{}` (illegal inside `\examples{}`, hard-errors R's parser).
14. **Keep `\dontrun{}`**: these touch a live Synapse instance and need real
    credentials.
15. **Assignment and spacing**: match `vignettes/tables.Rmd`'s style — `=`
    for assignment (`project = Project(...) |> synStore()`, `results =
    synQuery(...)`), not `<-`, with spaces around `=` in both assignment and
    named arguments (`name = "Name"`, not `name="Name"`).
16. **Quote style**: string literals use double quotes, matching every
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

- **Leading `%` banner comment**: a freshly generated draft opens with
  ```
  %
  %  Auto-generated file, do not modify.
  %  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
  %  Use Git to identify changes in this file which suggest where to change your edited copy.
  %
  ```
  This is the generator telling you not to hand-edit the `auto-man/` draft in
  place — once the page has been copied into `man/` and is getting the
  curation this skill performs, that warning no longer applies and the banner
  itself says to remove it ("remove this warning, and edit freely"), matching
  `CONTRIBUTING.md`'s documented `auto-man/` → `man/` review step. Delete these
  five lines as part of the translation; don't leave them sitting above
  `\name{}` in a page you've otherwise curated.
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
- **Kwargs merged onto the preceding argument**: when a Python method's
  last parameter is `**kwargs`, the R wrapper generator typically drops it
  from `\usage{}` (no real R argument for it), but its description sometimes
  survives glued onto the *previous* named argument's `\item{}` body via
  `\cr\cr` instead of being cleanly omitted — real examples, `Table_Query.Rd`
  (glued onto `header`) and `Table_UpsertRows.Rd` (glued onto
  `synapse_client`). Check whether the trailing sentence actually describes
  the item it's attached to; if it's really describing `**kwargs` passed to
  some other function, drop that sentence — there's no R parameter to
  document.
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

That alone is not enough. It passes on a page whose `\examples{}` block has
been truncated by an unescaped `%`, and on a `\usage{}` line that isn't valid
R. Check both of those directly:

```r
# \usage{} must be parseable R -- catches invalid argument names
parsed <- tools::parse_Rd("man/<File>.Rd")
tags <- vapply(parsed, function(x) attr(x, "Rd_tag"), character(1))
parse(text = paste(unlist(parsed[tags == "\\usage"][[1]]), collapse = ""))

# \examples{} must be parseable R -- catches unescaped `%`.
# Rd2ex converts the \examples{} block into a plain .R script. 
# Rd2ex comments out a \dontrun{} body with "##D ", and add markers ###
# so strip that first.
out <- tempfile(); tools::Rd2ex("man/<File>.Rd", out)
lines <- readLines(out, warn = FALSE)
lines <- sub("^##D ?", "", lines[!grepl("^###", lines)])
parse(text = paste(lines[!grepl("^## (Not run|End\\()", lines)], collapse = "\n"))
```

`tests/testthat/test_docExamples.R` runs both checks across every page in
`man/`, so `devtools::test(filter = "docExamples")` covers this too.

These still only check syntax — they don't check that the R code inside
`\dontrun{}` runs, or that a claim about R behavior is accurate. In
particular, they will not catch an argument that doesn't exist: verify every
argument name you write against the page's own `\usage{}` line. This environment has no Synapse credentials or network access, so translated content is verified to be *syntactically valid and consistent with the real, currently-generated API surface*, not proven to execute end-to-end. Say so explicitly rather than claiming it's tested, and suggest the user smoke-test it before release.
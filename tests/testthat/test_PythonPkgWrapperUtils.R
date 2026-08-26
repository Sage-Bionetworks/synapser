# One way to run the test is using devtools::test(filter = "PythonPkgWrapperUtils")
# from the synapser package directory.
context("test PythonPkgWrapperUtils")

# ---------------------------------------------------------------------------
# capitalizeFirstLetter
# ---------------------------------------------------------------------------

test_that("capitalizeFirstLetter capitalizes single lowercase word", {
  expect_equal("Hello", capitalizeFirstLetter("hello"))
})

test_that("capitalizeFirstLetter leaves already-capitalized word unchanged", {
  expect_equal("Hello", capitalizeFirstLetter("Hello"))
})

test_that("capitalizeFirstLetter handles single character", {
  expect_equal("A", capitalizeFirstLetter("a"))
})

test_that("capitalizeFirstLetter only changes the first character", {
  expect_equal("HELLO", capitalizeFirstLetter("hELLO"))
})

# ---------------------------------------------------------------------------
# snakeToCamel
# ---------------------------------------------------------------------------

test_that("snakeToCamel converts snake_case to CamelCase", {
  expect_equal("FindEntityId", snakeToCamel("find_entity_id"))
})

test_that("snakeToCamel capitalizes a single word", {
  expect_equal("Get", snakeToCamel("get"))
})

test_that("snakeToCamel handles two-part name", {
  expect_equal("IsSynapseId", snakeToCamel("is_synapse_id"))
})

test_that("snakeToCamel handles three-part download_list_files style names", {
  expect_equal("DownloadListFiles", snakeToCamel("download_list_files"))
})

# ---------------------------------------------------------------------------
# addPrefix
# ---------------------------------------------------------------------------

test_that("addPrefix prepends prefix to camelCase name", {
  expect_equal("synGet", addPrefix("get", "syn"))
})

test_that("addPrefix converts snake_case before prepending", {
  expect_equal("synFindEntityId", addPrefix("find_entity_id", "syn"))
})

test_that("addPrefix works with three-part snake_case", {
  expect_equal("synDownloadListFiles", addPrefix("download_list_files", "syn"))
})

# ---------------------------------------------------------------------------
# removeNulls
# ---------------------------------------------------------------------------

test_that("removeNulls removes NULL elements from a list", {
  expect_equal(
    list("a", "b", "c"),
    removeNulls(list("a", NULL, "b", NULL, "c"))
  )
})

test_that("removeNulls returns list unchanged when no NULLs present", {
  input <- list("a", "b", "c")
  expect_equal(input, removeNulls(input))
})

test_that("removeNulls returns empty list when all elements are NULL", {
  expect_equal(list(), removeNulls(list(NULL, NULL)))
})

# ---------------------------------------------------------------------------
# determineArgsAndKwArgs
# ---------------------------------------------------------------------------

test_that("determineArgsAndKwArgs separates positional and keyword args", {
  result <- determineArgsAndKwArgs("syn123", limit = 10L, includeTypes = "file")
  expect_equal(list("syn123"), result$args)
  expect_equal(list(limit = 10L, includeTypes = "file"), result$kwargs)
})

test_that("determineArgsAndKwArgs handles only positional args", {
  result <- determineArgsAndKwArgs("a", "b", "c")
  expect_equal(list("a", "b", "c"), result$args)
  expect_equal(list(), result$kwargs)
})

test_that("determineArgsAndKwArgs handles only keyword args", {
  result <- determineArgsAndKwArgs(entity = "syn123", downloadFile = TRUE)
  expect_equal(list(), result$args)
  expect_equal(list(entity = "syn123", downloadFile = TRUE), result$kwargs)
})

test_that("determineArgsAndKwArgs handles no args", {
  result <- determineArgsAndKwArgs()
  expect_equal(list(), result$args)
  expect_equal(list(), result$kwargs)
})

test_that("determineArgsAndKwArgs handles NULL positional arg", {
  result <- determineArgsAndKwArgs(NULL)
  expect_equal(list(NULL), result$args)
  expect_equal(list(), result$kwargs)
})

test_that("determineArgsAndKwArgs handles NULL keyword arg", {
  result <- determineArgsAndKwArgs(entity = NULL)
  expect_equal(list(), result$args)
  expect_equal(list(entity = NULL), result$kwargs)
})

test_that("determineArgsAndKwArgs errors when positional follows keyword", {
  expect_error(determineArgsAndKwArgs(a = "x", "y"))
})

test_that("determineArgsAndKwArgs last value wins on duplicate keyword argument", {
  result <- determineArgsAndKwArgs(entity = "syn123", entity = "syn456")
  expect_equal(list(entity = "syn456"), result$kwargs)
})

# ---------------------------------------------------------------------------
# .createFormalArgs
# ---------------------------------------------------------------------------

test_that(".createFormalArgs returns empty list for no-param function", {
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  expect_length(.createFormalArgs(pyParams), 0)
})

test_that(".createFormalArgs creates required args with no defaults", {
  pyParams <- list(
    args = c("x", "y"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )

  result <- .createFormalArgs(pyParams)

  expect_named(result, c("x", "y"))
  expect_identical(result$x, quote(expr = ))
  expect_identical(result$y, quote(expr = ))
})

test_that(".createFormalArgs strips self from arg list", {
  pyParams <- list(
    args = list("self", "x"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  result <- .createFormalArgs(pyParams)
  expect_true("x" %in% names(result))
  expect_false("self" %in% names(result))
})

test_that(".createFormalArgs assigns defaults to trailing args", {
  pyParams <- list(
    args = c("x", "y", "z"),
    defaults = list(10, "hello"),
    varargs = NULL,
    keywords = NULL
  )

  result <- .createFormalArgs(pyParams)

  expect_named(result, c("x", "y", "z"))
  expect_identical(result$x, quote(expr = ))
  expect_identical(result$y, 10)
  expect_identical(result$z, "hello")
})

test_that(".createFormalArgs adds dots when varargs is present", {
  pyParams <- list(
    args = c("x"),
    defaults = list(),
    varargs = "args",
    keywords = NULL
  )

  result <- .createFormalArgs(pyParams)

  expect_named(result, c("x", "..."))
  expect_identical(result$x, quote(expr = ))
  expect_identical(result$..., quote(expr = ))
})

test_that(".createFormalArgs adds dots when keywords is present", {
  pyParams <- list(
    args = c("x"),
    defaults = list(),
    varargs = NULL,
    keywords = "kwargs"
  )

  result <- .createFormalArgs(pyParams)

  expect_named(result, c("x", "..."))
  expect_identical(result$x, quote(expr = ))
  expect_identical(result$..., quote(expr = ))
})

test_that(".createFormalArgs handles no args but varargs present", {
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = "args",
    keywords = NULL
  )

  result <- .createFormalArgs(pyParams)

  expect_named(result, "...")
  expect_identical(result$..., quote(expr = ))
})
# ---------------------------------------------------------------------------
# applyFunctionNameMapping
# ---------------------------------------------------------------------------

test_that("applyFunctionNameMapping returns default name when no mapping", {
  expect_equal(
    "synFindEntityId",
    applyFunctionNameMapping("synFindEntityId", NULL)
  )
})

test_that("applyFunctionNameMapping applies explicit mapping", {
  mapping <- list(explicit = list("synFromPathFile" = "synGetFileFromPath"))
  expect_equal(
    "synGetFileFromPath",
    applyFunctionNameMapping("synFromPathFile", mapping)
  )
})

test_that("applyFunctionNameMapping returns default when name not in map", {
  mapping <- list(explicit = list("synFromPathFile" = "synGetFileFromPath"))
  expect_equal("synUnmapped", applyFunctionNameMapping("synUnmapped", mapping))
})

test_that("applyFunctionNameMapping applies all predefined Synapse class mappings", {
  mapping <- .functionNameMappingSynapse()
  expect_equal(
    "synRestGet",
    applyFunctionNameMapping("synRestGetAsync", mapping)
  )
  expect_equal(
    "synRestPut",
    applyFunctionNameMapping("synRestPutAsync", mapping)
  )
  expect_equal(
    "synRestPost",
    applyFunctionNameMapping("synRestPostAsync", mapping)
  )
  expect_equal(
    "synRestDelete",
    applyFunctionNameMapping("synRestDeleteAsync", mapping)
  )
})

test_that("applyFunctionNameMapping applies all predefined synapseclient.models mappings", {
  mapping <- .functionNameMappingSynapseclientModels()
  expect_equal(
    "synDisassociateActivityFromEntity",
    applyFunctionNameMapping("synDisassociateFromEntity", mapping)
  )
  expect_equal(
    "synGetFromPath",
    applyFunctionNameMapping("synFromPath", mapping)
  )
  expect_equal(
    "synInviteToTeam",
    applyFunctionNameMapping("synInvite", mapping)
  )
  expect_equal(
    "synGetTeamMembers",
    applyFunctionNameMapping("synMembers", mapping)
  )
  expect_equal(
    "synGetOpenInvitations",
    applyFunctionNameMapping("synOpenInvitations", mapping)
  )
})


# ---------------------------------------------------------------------------
# .replaceAuthMessage
# ---------------------------------------------------------------------------

test_that(".replaceAuthMessage replaces Python auth error with R-friendly message", {
  pythonMsg <- paste0(
    "You have not provided valid credentials for Synapse.",
    " Please provide your credentials for more information."
  )
  result <- .replaceAuthMessage(pythonMsg)
  expect_true(grepl("synLogin()", result, fixed = TRUE))
  expect_true(grepl("manageSynapseCredentials", result, fixed = TRUE))
})

test_that(".replaceAuthMessage leaves unrelated text unchanged", {
  unrelated <- "Some other error occurred."
  expect_equal(unrelated, .replaceAuthMessage(unrelated))
})

test_that(".replaceAuthMessage replaces multi-line Python auth error with R-friendly message", {
  # (?s) dotall flag is required so .* matches across embedded newlines in the
  # real Python auth exception text.
  pythonMsg <- paste0(
    "You have not provided valid credentials for Synapse.\n",
    "Visit https://synapse.org to create a personal access token.\n",
    "Please provide your credentials for more information."
  )
  result <- .replaceAuthMessage(pythonMsg)
  expect_true(grepl("synLogin()", result, fixed = TRUE))
  expect_false(grepl("Visit https://synapse.org", result, fixed = TRUE))
})

# ---------------------------------------------------------------------------
# cleanUpStackTrace
# ---------------------------------------------------------------------------

test_that("cleanUpStackTrace returns the result of the callable", {
  expect_equal(42L, cleanUpStackTrace(function() 42L, list()))
})

test_that("cleanUpStackTrace passes args to the callable", {
  expect_equal(42L, cleanUpStackTrace(function(x, y) x + y, list(10L, 32L)))
})

test_that("cleanUpStackTrace propagates errors from the callable", {
  expect_error(
    cleanUpStackTrace(function() stop("expected test error"), list()),
    "expected test error"
  )
})

test_that("cleanUpStackTrace extracts message after boundary marker in non-verbose mode", {
  old_verbose <- getOption("verbose")
  on.exit(options(verbose = old_verbose))
  options(verbose = FALSE)

  callable <- function() {
    stop("python traceback\nexception-message-boundary\nclean user message")
  }
  err <- tryCatch(
    cleanUpStackTrace(callable, list()),
    error = function(e) e$message
  )
  expect_true(grepl("clean user message", err))
  expect_false(grepl("python traceback", err))
})

test_that("cleanUpStackTrace preserves full error when verbose is TRUE", {
  old_verbose <- getOption("verbose")
  on.exit(options(verbose = old_verbose))
  options(verbose = TRUE)

  callable <- function() {
    stop("python traceback\nexception-message-boundary\nclean user message")
  }
  err <- tryCatch(
    cleanUpStackTrace(callable, list()),
    error = function(e) e$message
  )
  expect_true(grepl("python traceback", err))
  expect_true(grepl("clean user message", err))
})

test_that("cleanUpStackTrace does not split error without a boundary marker", {
  old_verbose <- getOption("verbose")
  on.exit(options(verbose = old_verbose))
  options(verbose = FALSE)

  callable <- function() stop("just a plain error")
  err <- tryCatch(
    cleanUpStackTrace(callable, list()),
    error = function(e) e$message
  )
  expect_true(grepl("just a plain error", err))
})

# ---------------------------------------------------------------------------
# defineEnum / autoGenerateEnum
# ---------------------------------------------------------------------------

test_that("defineEnum calls callback with correct name, keys, and values", {
  received <- list()
  mockCallback <- function(name, keys, values) {
    received <<- list(name = name, keys = keys, values = values)
  }
  defineEnum(mockCallback, "MyEnum", c("KEY1", "KEY2"), c(1L, 2L))
  expect_equal("MyEnum", received$name)
  expect_equal(c("KEY1", "KEY2"), received$keys)
  expect_equal(c(1L, 2L), received$values)
})

test_that("autoGenerateEnum calls defineEnum for every entry in enumInfo", {
  received <- list()
  mockCallback <- function(name, keys, values) {
    received[[name]] <<- list(keys = keys, values = values)
  }
  enumInfo <- list(
    list(name = "Enum1", keys = c("A"), values = c(1L)),
    list(name = "Enum2", keys = c("X", "Y"), values = c(10L, 20L))
  )
  autoGenerateEnum(mockCallback, enumInfo)
  expect_true("Enum1" %in% names(received))
  expect_true("Enum2" %in% names(received))
  expect_equal(c("X", "Y"), received$Enum2$keys)
  expect_equal(c(10L, 20L), received$Enum2$values)
})

test_that("autoGenerateEnum is a no-op for empty enumInfo", {
  called <- FALSE
  mockCallback <- function(name, keys, values) {
    called <<- TRUE
  }
  autoGenerateEnum(mockCallback, list())
  expect_false(called)
})

# ---------------------------------------------------------------------------
# .splitGoogleStyleSections
# ---------------------------------------------------------------------------

test_that(".splitGoogleStyleSections returns empty description and no sections for NULL", {
  result <- .splitGoogleStyleSections(NULL)
  expect_equal("", result$description)
  expect_equal(list(), result$sections)
})

test_that(".splitGoogleStyleSections returns empty description and no sections for empty string", {
  result <- .splitGoogleStyleSections("")
  expect_equal("", result$description)
  expect_equal(list(), result$sections)
})

test_that(".splitGoogleStyleSections treats all text as description when there are no headers", {
  raw <- "Just a plain description.\nWith a second line."
  result <- .splitGoogleStyleSections(raw)
  expect_equal(raw, result$description)
  expect_equal(list(), result$sections)
})

test_that(".splitGoogleStyleSections splits description from a single trailing section", {
  raw <- "Summary line.\nArguments:\n    name: the entity name"
  result <- .splitGoogleStyleSections(raw)
  expect_equal("Summary line.", result$description)
  expect_equal(1L, length(result$sections))
  expect_equal("Arguments", result$sections[[1]]$header)
  expect_equal("", result$sections[[1]]$title)
  expect_equal("    name: the entity name", result$sections[[1]]$body)
})

test_that(".splitGoogleStyleSections captures an inline title on the header line", {
  raw <- "A function.\nExample: Using this function\n    do_thing()"
  result <- .splitGoogleStyleSections(raw)
  expect_equal("Using this function", result$sections[[1]]$title)
  expect_equal("    do_thing()", result$sections[[1]]$body)
})

test_that(".splitGoogleStyleSections splits multiple sections at each header boundary", {
  raw <- paste(
    "Summary.",
    "Arguments:",
    "    name: the name",
    "Returns:",
    "    the result",
    sep = "\n"
  )
  result <- .splitGoogleStyleSections(raw)
  expect_equal(2L, length(result$sections))
  expect_equal("Arguments", result$sections[[1]]$header)
  expect_equal("    name: the name", result$sections[[1]]$body)
  expect_equal("Returns", result$sections[[2]]$header)
  expect_equal("    the result", result$sections[[2]]$body)
})

test_that(".splitGoogleStyleSections lets the last section's body run to the end of the docstring", {
  raw <- "Raises:\n    ValueError: bad input\n    TypeError: also bad"
  result <- .splitGoogleStyleSections(raw)
  expect_equal(
    "    ValueError: bad input\n    TypeError: also bad",
    result$sections[[1]]$body
  )
})

test_that(".splitGoogleStyleSections gives an empty body to a header with no following lines", {
  raw <- "Summary.\nNote:"
  result <- .splitGoogleStyleSections(raw)
  expect_equal("", result$sections[[1]]$body)
})

test_that(".splitGoogleStyleSections normalises CRLF to LF before splitting", {
  raw <- "Summary line.\r\nArguments:\r\n    x: foo"
  result <- .splitGoogleStyleSections(raw)
  expect_equal("Summary line.", result$description)
  expect_equal("    x: foo", result$sections[[1]]$body)
})

test_that(".splitGoogleStyleSections keeps repeated Example headers as separate sections", {
  raw <- paste(
    "A function.",
    "Example: First one",
    "    first()",
    "Example: Second one",
    "    second()",
    sep = "\n"
  )
  result <- .splitGoogleStyleSections(raw)
  expect_equal(2L, length(result$sections))
  expect_equal("First one", result$sections[[1]]$title)
  expect_equal("Second one", result$sections[[2]]$title)
})

# ---------------------------------------------------------------------------
# .sectionsWithHeader
# ---------------------------------------------------------------------------

test_that(".sectionsWithHeader returns an empty list when sections is empty", {
  expect_equal(list(), .sectionsWithHeader(list(), c("Returns")))
})

test_that(".sectionsWithHeader returns an empty list when no header matches", {
  sections <- list(list(header = "Arguments", title = "", body = "x"))
  expect_equal(list(), .sectionsWithHeader(sections, c("Returns", "Return")))
})

test_that(".sectionsWithHeader keeps only sections whose header is in the headers list", {
  sections <- list(
    list(header = "Arguments", title = "", body = "args body"),
    list(header = "Returns", title = "", body = "returns body"),
    list(header = "Raises", title = "", body = "raises body")
  )
  result <- .sectionsWithHeader(sections, c("Returns", "Return"))
  expect_equal(1L, length(result))
  expect_equal("Returns", result[[1]]$header)
  expect_equal("returns body", result[[1]]$body)
})

test_that(".sectionsWithHeader matches on any of several header name aliases", {
  sections <- list(
    list(header = "Return", title = "", body = "singular"),
    list(header = "Yields", title = "", body = "yielded")
  )
  result <- .sectionsWithHeader(sections, c("Returns", "Return", "Yields"))
  expect_equal(2L, length(result))
})

test_that(".sectionsWithHeader preserves the original order of matching sections", {
  sections <- list(
    list(header = "Example", title = "First", body = "1"),
    list(header = "Arguments", title = "", body = "args"),
    list(header = "Example", title = "Second", body = "2")
  )
  result <- .sectionsWithHeader(sections, c("Example", "Examples"))
  expect_equal(2L, length(result))
  expect_equal("First", result[[1]]$title)
  expect_equal("Second", result[[2]]$title)
})

# ---------------------------------------------------------------------------
# getDescription
# ---------------------------------------------------------------------------

test_that("getDescription returns empty string for NULL", {
  expect_equal("", getDescription(NULL))
})

test_that("getDescription returns empty string for empty string", {
  expect_equal("", getDescription(""))
})

test_that("getDescription returns full text when no Sphinx tokens", {
  doc <- "This is a plain description."
  expect_equal(doc, getDescription(doc))
})

test_that("getDescription stops before an Arguments: section", {
  doc <- "Summary line.\nArguments:\n    name: the name"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before an Attributes: section", {
  doc <- "Summary line.\nAttributes:\n    name: the name"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before a Returns: section", {
  doc <- "Summary line.\nReturns:\n    the result"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before a Raises: section", {
  doc <- "Summary line.\nRaises:\n    ValueError: bad input"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription normalises CRLF to LF", {
  doc <- "Summary line.\r\nArguments:\n    x: foo"
  expect_equal("Summary line.", getDescription(doc))
})

# ---------------------------------------------------------------------------
# getReturned
# ---------------------------------------------------------------------------

test_that("getReturned returns \"NULL\" for NULL", {
  expect_equal("NULL", getReturned(NULL))
})

test_that("getReturned returns \"NULL\" for empty string", {
  expect_equal("NULL", getReturned(""))
})

test_that("getReturned returns \"NULL\" when no Returns: section", {
  expect_equal("NULL", getReturned("A description with no return section."))
})

test_that("getReturned extracts a Returns: section body", {
  doc <- "A function.\nReturns:\n    the result value"
  expect_true(grepl("the result value", getReturned(doc)))
})

test_that("getReturned works with the Return: (no s) header form", {
  doc <- "A function.\nReturn:\n    the result value"
  expect_true(grepl("the result value", getReturned(doc)))
})

test_that("getReturned stops at the next section header", {
  doc <- "A function.\nReturns:\n    the result\nRaises:\n    ValueError: bad input"
  result <- getReturned(doc)
  expect_false(grepl("ValueError", result))
  expect_true(grepl("the result", result))
})

# ---------------------------------------------------------------------------
# getErrors
# ---------------------------------------------------------------------------

test_that("getErrors returns empty string for NULL", {
  expect_equal("", getErrors(NULL))
})

test_that("getErrors returns empty string when no Raises: section", {
  expect_equal("", getErrors("A plain description."))
})

test_that("getErrors extracts a Raises: section body", {
  doc <- "A function.\nRaises:\n    ValueError: if the input is bad"
  result <- getErrors(doc)
  expect_true(grepl("ValueError", result))
})

# ---------------------------------------------------------------------------
# getNote
# ---------------------------------------------------------------------------

test_that("getNote returns empty string for NULL", {
  expect_equal("", getNote(NULL))
})

test_that("getNote returns empty string when no Note:/Notes: section", {
  expect_equal("", getNote("A plain description."))
})

test_that("getNote extracts a Note: section body", {
  doc <- "A function.\nNote:\n    This is a caveat."
  expect_true(grepl("caveat", getNote(doc)))
})

test_that("getNote also matches the plural Notes: header", {
  doc <- "A function.\nNotes:\n    This is a caveat."
  expect_true(grepl("caveat", getNote(doc)))
})

# ---------------------------------------------------------------------------
# .cleanExampleBody
# ---------------------------------------------------------------------------

test_that(".cleanExampleBody leaves an unfenced body unchanged", {
  text <- "code_here()"
  expect_equal("code_here()", .cleanExampleBody(text))
})

test_that(".cleanExampleBody comments out description lines before the first fence", {
  text <- "This explains the example.\n```python\ncode_here()\n```"
  result <- .cleanExampleBody(text)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal("# This explains the example.", lines[1])
})

test_that(".cleanExampleBody preserves leading indentation when commenting", {
  text <- "    indented description\n```\ncode()\n```"
  result <- .cleanExampleBody(text)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal("    # indented description", lines[1])
})

test_that(".cleanExampleBody removes fence marker lines entirely", {
  text <- "desc\n```python\ncode_here()\n```"
  result <- .cleanExampleBody(text)
  expect_false(grepl("```", result, fixed = TRUE))
  expect_true(grepl("code_here\\(\\)", result))
})

test_that(".cleanExampleBody leaves blank lines before the fence uncommented", {
  text <- "desc line\n\n```\ncode()\n```"
  result <- .cleanExampleBody(text)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal("# desc line", lines[1])
  expect_equal("", lines[2])
})

test_that(".cleanExampleBody does not comment code lines when there is no description before the fence", {
  text <- "```python\ncode_here()\n```"
  result <- .cleanExampleBody(text)
  expect_equal("code_here()", result)
})

test_that(".cleanExampleBody does not comment text that comes after the fenced block", {
  text <- "```\ncode()\n```\nAfter-block text"
  result <- .cleanExampleBody(text)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal("After-block text", lines[length(lines)])
})

test_that(".cleanExampleBody removes standalone &nbsp; lines", {
  text <- "desc\n&nbsp;\ncode()"
  result <- .cleanExampleBody(text)
  expect_false(grepl("&nbsp;", result, fixed = TRUE))
  expect_true(grepl("desc", result))
  expect_true(grepl("code\\(\\)", result))
})

test_that(".cleanExampleBody excludes an &nbsp; line from being commented as description", {
  text <- "&nbsp;\n```\ncode()\n```"
  result <- .cleanExampleBody(text)
  expect_false(grepl("#", result, fixed = TRUE))
})

test_that(".cleanExampleBody comments each description line independently", {
  text <- "First line.\nSecond line.\n```\ncode()\n```"
  result <- .cleanExampleBody(text)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal("# First line.", lines[1])
  expect_equal("# Second line.", lines[2])
})

# ---------------------------------------------------------------------------
# getExampleSections
# ---------------------------------------------------------------------------

test_that("getExampleSections returns an empty list for NULL", {
  expect_equal(list(), getExampleSections(NULL))
})

test_that("getExampleSections returns an empty list when there's no Example section", {
  expect_equal(list(), getExampleSections("A plain description."))
})

test_that("getExampleSections keeps each repeated Example: header as its own entry", {
  doc <- paste(
    "A function.",
    "Example: First one",
    "    first()",
    "Example: Second one",
    "    second()",
    sep = "\n"
  )
  result <- getExampleSections(doc)
  expect_equal(2L, length(result))
  expect_equal("First one", result[[1]]$title)
  expect_true(grepl("first\\(\\)", result[[1]]$body))
  expect_equal("Second one", result[[2]]$title)
  expect_true(grepl("second\\(\\)", result[[2]]$body))
})

test_that("getExampleSections leaves title empty when the header has none", {
  doc <- "A function.\nExample:\n    code_here()"
  result <- getExampleSections(doc)
  expect_equal("", result[[1]]$title)
})

test_that("getExampleSections comments out the description before a fenced code block", {
  doc <- paste(
    "A function.",
    "Example: Title",
    "    This example shows how you may do the thing.",
    "",
    "    ```python",
    "    code_here()",
    "    ```",
    sep = "\n"
  )
  result <- getExampleSections(doc)
  bodyLines <- strsplit(result[[1]]$body, "\n", fixed = TRUE)[[1]]
  descriptionLine <- bodyLines[grepl("This example shows", bodyLines)]
  codeLine <- bodyLines[grepl("code_here\\(\\)", bodyLines)]
  expect_true(grepl("^\\s*# This example shows", descriptionLine))
  expect_false(grepl("#", codeLine))
})

test_that("getExampleSections leaves an unfenced body uncommented", {
  doc <- "A function.\nExample: Title\n    code_here()"
  result <- getExampleSections(doc)
  expect_false(grepl("#", result[[1]]$body))
})

# ---------------------------------------------------------------------------
# .buildExamplesRdContent
# ---------------------------------------------------------------------------

test_that(".buildExamplesRdContent returns empty string for no sections", {
  expect_equal("", .buildExamplesRdContent(list()))
})

test_that(".buildExamplesRdContent wraps code in a real \\dontrun{} block", {
  result <- .buildExamplesRdContent(list(list(title = "", body = "do_thing()")))
  lines <- strsplit(result, "\n")[[1]]
  expect_equal("\\dontrun{", lines[1])
  expect_equal("do_thing()", lines[2])
  expect_equal("}", lines[length(lines)])
})

test_that(".buildExamplesRdContent does not number a single example", {
  result <- .buildExamplesRdContent(list(list(
    title = "Doing the thing",
    body = "do_thing()"
  )))
  expect_false(grepl("Example 1", result))
  expect_true(grepl("Doing the thing", result))
})

test_that(".buildExamplesRdContent numbers multiple examples with their titles", {
  sections <- list(
    list(title = "First one", body = "first()"),
    list(title = "Second one", body = "second()")
  )
  result <- .buildExamplesRdContent(sections)
  expect_true(grepl("Example 1: First one", result))
  expect_true(grepl("Example 2: Second one", result))
})

test_that(".buildExamplesRdContent numbers multiple examples even without titles", {
  sections <- list(
    list(title = "", body = "first()"),
    list(title = "", body = "second()")
  )
  result <- .buildExamplesRdContent(sections)
  expect_true(grepl("Example 1\\b", result))
  expect_true(grepl("Example 2\\b", result))
})

test_that(".buildExamplesRdContent never emits a raw \\itemize tag (invalid inside \\examples)", {
  sections <- list(
    list(title = "First one", body = "first()"),
    list(title = "Second one", body = "second()")
  )
  result <- .buildExamplesRdContent(sections)
  expect_false(grepl("\\\\itemize", result))
})


# ---------------------------------------------------------------------------
# insertLatexNewLines
# ---------------------------------------------------------------------------

test_that("insertLatexNewLines replaces newlines with \\cr newlines", {
  raw <- "line1\nline2"
  result <- insertLatexNewLines(raw)
  expect_equal("line1\\cr\nline2", result)
})

test_that("insertLatexNewLines leaves string without newlines unchanged", {
  raw <- "no newlines here"
  expect_equal(raw, insertLatexNewLines(raw))
})

test_that("insertLatexNewLines handles multiple newlines", {
  raw <- "a\nb\nc"
  result <- insertLatexNewLines(raw)
  expect_equal("a\\cr\nb\\cr\nc", result)
})

# ---------------------------------------------------------------------------
# .resolveCrossRefRName
# ---------------------------------------------------------------------------

test_that(".resolveCrossRefRName strips the _async suffix and CamelCases the name", {
  expect_equal(
    "synStore",
    .resolveCrossRefRName("synapseclient.models.File.store_async")
  )
})

test_that(".resolveCrossRefRName leaves a name without _async unchanged before prefixing", {
  expect_equal(
    "synGet",
    .resolveCrossRefRName("synapseclient.models.File.get")
  )
})

test_that(".resolveCrossRefRName converts a multi-word snake_case name", {
  expect_equal(
    "synDisassociateFromEntity",
    .resolveCrossRefRName(
      "synapseclient.models.Activity.disassociate_from_entity_async"
    )
  )
})

test_that(".resolveCrossRefRName handles a qualified name with no dots", {
  expect_equal("synGetAcl", .resolveCrossRefRName("get_acl"))
})

test_that(".resolveCrossRefRName applies functionNameMapping's explicit override", {
  mapping <- list(
    explicit = list(
      "synDisassociateFromEntity" = "synDisassociateActivityFromEntity"
    )
  )
  result <- .resolveCrossRefRName(
    "synapseclient.models.Activity.disassociate_from_entity_async",
    mapping
  )
  expect_equal("synDisassociateActivityFromEntity", result)
})

# ---------------------------------------------------------------------------
# .convertMkdocstringsCrossRefs
# ---------------------------------------------------------------------------

test_that(".convertMkdocstringsCrossRefs leaves text without a cross-reference unchanged", {
  text <- "Just a plain sentence."
  expect_equal(text, .convertMkdocstringsCrossRefs(text))
})

test_that(".convertMkdocstringsCrossRefs converts a bare cross-reference to a linked syn name", {
  result <- .convertMkdocstringsCrossRefs(
    "See [synapseclient.models.File.store_async][]."
  )
  expect_false(grepl("[synapseclient", result, fixed = TRUE))
  expect_true(grepl("\\\\link\\[=synStore\\]\\{synStore\\}", result))
})

test_that(".convertMkdocstringsCrossRefs applies functionNameMapping to the resolved name", {
  mapping <- list(
    explicit = list(
      "synDisassociateFromEntity" = "synDisassociateActivityFromEntity"
    )
  )
  result <- .convertMkdocstringsCrossRefs(
    "[synapseclient.models.Activity.disassociate_from_entity_async][]",
    mapping
  )
  expect_true(grepl("synDisassociateActivityFromEntity", result))
})

test_that(".convertMkdocstringsCrossRefs converts multiple cross-references in the same text", {
  result <- .convertMkdocstringsCrossRefs(
    "See [synapseclient.models.File.get][] and [synapseclient.models.File.store_async][]."
  )
  expect_true(grepl("synGet", result))
  expect_true(grepl("synStore", result))
})

# ---------------------------------------------------------------------------
# .convertMarkdownLinks
# ---------------------------------------------------------------------------

test_that(".convertMarkdownLinks leaves text without a link unchanged", {
  text <- "Just a plain sentence."
  expect_equal(text, .convertMarkdownLinks(text))
})

test_that(".convertMarkdownLinks converts a single markdown link to \\href", {
  result <- .convertMarkdownLinks("See [the docs](https://example.com/docs) for more.")
  expect_true(grepl(
    "\\\\href\\{https://example\\.com/docs\\}\\{the docs\\}",
    result
  ))
})

test_that(".convertMarkdownLinks converts multiple links in the same text", {
  result <- .convertMarkdownLinks("[one](https://a.com) and [two](https://b.com)")
  expect_true(grepl("\\\\href\\{https://a\\.com\\}\\{one\\}", result))
  expect_true(grepl("\\\\href\\{https://b\\.com\\}\\{two\\}", result))
})

# ---------------------------------------------------------------------------
# .convertInlineCode
# ---------------------------------------------------------------------------

test_that(".convertInlineCode leaves text without backticks unchanged", {
  text <- "Just a plain sentence."
  expect_equal(text, .convertInlineCode(text))
})

test_that(".convertInlineCode converts a single code span to \\code", {
  result <- .convertInlineCode("Set `synapse_store` to False.")
  expect_true(grepl("\\\\code\\{synapse_store\\}", result))
})

test_that(".convertInlineCode converts multiple code spans in the same text", {
  result <- .convertInlineCode("`foo` and `bar`")
  expect_true(grepl("\\\\code\\{foo\\}", result))
  expect_true(grepl("\\\\code\\{bar\\}", result))
})

test_that(".convertInlineCode converts a code span already nested inside \\href text", {
  result <- .convertInlineCode("\\href{https://example.com/}{`synStore`}")
  expect_equal("\\href{https://example.com/}{\\code{synStore}}", result)
})

# ---------------------------------------------------------------------------
# formatArgsForArgumentSection
# ---------------------------------------------------------------------------

test_that("formatArgsForArgumentSection returns empty string for no args", {
  expect_equal("", formatArgsForArgumentSection(list(), list()))
})

test_that("formatArgsForArgumentSection produces \\item entries for each arg", {
  argNames <- list("entity", "version")
  argDesc <- list(
    entity = list(type = "", description = "The entity"),
    version = list(type = "", description = "Version number")
  )
  result <- formatArgsForArgumentSection(argNames, argDesc)
  expect_true(grepl("\\\\item\\{entity\\}", result))
  expect_true(grepl("\\\\item\\{version\\}", result))
})

test_that("formatArgsForArgumentSection uses empty description when arg not in docstring", {
  argNames <- list("entity")
  result <- formatArgsForArgumentSection(argNames, list())
  expect_true(grepl("\\\\item\\{entity\\}\\{\\}", result))
})

test_that("formatArgsForArgumentSection skips self as first arg", {
  argNames <- list("self", "entity")
  result <- formatArgsForArgumentSection(argNames, list())
  expect_false(grepl("\\{self\\}", result))
  expect_true(grepl("\\{entity\\}", result))
})

test_that("formatArgsForArgumentSection marks extra docstring args as optional named parameters", {
  argNames <- list("entity")
  argDesc <- list(
    entity = list(type = "", description = "The entity"),
    extraArg = list(type = "", description = "An optional kwarg")
  )
  result <- formatArgsForArgumentSection(argNames, argDesc)
  expect_true(grepl("optional named parameter", result))
  expect_true(grepl("extraArg", result))
})

# ---------------------------------------------------------------------------
# .formatDefaultValueForUsage
# ---------------------------------------------------------------------------

test_that(".formatDefaultValueForUsage renders NULL as the literal NULL", {
  expect_equal("NULL", .formatDefaultValueForUsage(NULL))
})

test_that(".formatDefaultValueForUsage deparses a plain string default", {
  expect_equal(deparse("hello"), .formatDefaultValueForUsage("hello"))
})

test_that(".formatDefaultValueForUsage deparses a string containing quotes", {
  value <- "a \"quoted\" value"
  expect_equal(deparse(value), .formatDefaultValueForUsage(value))
})

test_that(".formatDefaultValueForUsage renders a trailing-backslash string as a raw string", {
  value <- "C:\\Users\\"
  result <- .formatDefaultValueForUsage(value)
  expect_equal(sprintf('r"(%s)"', value), result)
  expect_true(startsWith(result, 'r"('))
})

test_that(".formatDefaultValueForUsage does not use a raw string when the backslash is not trailing", {
  value <- "back\\slash in the middle"
  expect_equal(deparse(value), .formatDefaultValueForUsage(value))
})

test_that(".formatDefaultValueForUsage appends an L suffix to an integer default", {
  expect_equal("5L", .formatDefaultValueForUsage(5L))
})

test_that(".formatDefaultValueForUsage appends an L suffix to a negative integer default", {
  expect_equal("-3L", .formatDefaultValueForUsage(-3L))
})

test_that(".formatDefaultValueForUsage renders an empty list default as list()", {
  expect_equal("list()", .formatDefaultValueForUsage(list()))
})

test_that(".formatDefaultValueForUsage renders a logical default via plain sprintf", {
  expect_equal("FALSE", .formatDefaultValueForUsage(FALSE))
  expect_equal("TRUE", .formatDefaultValueForUsage(TRUE))
})

test_that(".formatDefaultValueForUsage renders a numeric default via plain sprintf", {
  expect_equal("3.14", .formatDefaultValueForUsage(3.14))
})

# ---------------------------------------------------------------------------
# usage
# ---------------------------------------------------------------------------

test_that("usage produces empty-parens string for no-arg function", {
  args <- list(args = list(), defaults = list())
  expect_equal("myFunc()", usage("myFunc", args, list()))
})

test_that("usage lists all args with no defaults", {
  args <- list(args = list("entity", "version"), defaults = list())
  expect_equal("myFunc(entity, version)", usage("myFunc", args, list()))
})

test_that("usage appends =value for defaulted args", {
  args <- list(
    args = list("entity", "version", "followLink"),
    defaults = list(NULL, FALSE)
  )
  result <- usage("myFunc", args, list())
  expect_true(grepl("version=NULL", result))
  expect_true(grepl("followLink=FALSE", result))
})

test_that("usage skips self as first arg", {
  args <- list(args = list("self", "entity"), defaults = list())
  expect_equal("myMethod(entity)", usage("myMethod", args, list()))
})

test_that("usage skips typ as first arg", {
  args <- list(args = list("typ", "entity"), defaults = list())
  expect_equal("myMethod(entity)", usage("myMethod", args, list()))
})

test_that("usage appends extra docstring kwargs as arg=NULL", {
  args <- list(args = list("entity"), defaults = list())
  argDesc <- list(entity = "the entity", extraParam = "a kwarg")
  result <- usage("myFunc", args, argDesc)
  expect_true(grepl("extraParam=NULL", result))
})

# ---------------------------------------------------------------------------
# .storeArgText
# ---------------------------------------------------------------------------

test_that(".storeArgText returns result unchanged when currentName is NULL", {
  result <- list(existing = list(type = "", description = "kept"))
  updated <- .storeArgText(result, NULL, "", character(0))
  expect_equal(result, updated)
})

test_that(".storeArgText stores a single line as the description", {
  result <- .storeArgText(list(), "entity", "", "the entity name")
  expect_equal("", result$entity$type)
  expect_equal("the entity name", result$entity$description)
})

test_that(".storeArgText preserves the given type", {
  result <- .storeArgText(list(), "entity", "str", "the entity name")
  expect_equal("str", result$entity$type)
})

test_that(".storeArgText joins multiple lines with a space (soft line-wrap)", {
  result <- .storeArgText(list(), "entity", "", c("the synapse", "entity to store"))
  expect_equal("the synapse entity to store", result$entity$description)
})

test_that(".storeArgText preserves a blank-line paragraph break", {
  result <- .storeArgText(
    list(),
    "entity",
    "",
    c("first paragraph", "", "second paragraph")
  )
  expect_equal("first paragraph\n\nsecond paragraph", result$entity$description)
})

test_that(".storeArgText trims leading and trailing whitespace from the description", {
  result <- .storeArgText(list(), "entity", "", "  padded text  ")
  expect_equal("padded text", result$entity$description)
})

test_that(".storeArgText returns an empty description for empty currentLines", {
  result <- .storeArgText(list(), "entity", "", character(0))
  expect_equal("", result$entity$description)
})

test_that(".storeArgText adds to an existing result without dropping prior entries", {
  result <- list(other = list(type = "", description = "unrelated"))
  updated <- .storeArgText(result, "entity", "", "the entity")
  expect_true("other" %in% names(updated))
  expect_equal("unrelated", updated$other$description)
  expect_equal("the entity", updated$entity$description)
})

# ---------------------------------------------------------------------------
# .parseArgSectionBody
# ---------------------------------------------------------------------------

test_that(".parseArgSectionBody returns an empty list for NULL", {
  expect_equal(list(), .parseArgSectionBody(NULL))
})

test_that(".parseArgSectionBody returns an empty list for a blank body", {
  expect_equal(list(), .parseArgSectionBody("   \n  \n"))
})

test_that(".parseArgSectionBody parses a single argument with no type", {
  result <- .parseArgSectionBody("    name: the entity name")
  expect_equal("", result$name$type)
  expect_equal("the entity name", result$name$description)
})

test_that(".parseArgSectionBody parses a type annotation in parentheses", {
  result <- .parseArgSectionBody("    name (str): the entity name")
  expect_equal("str", result$name$type)
  expect_equal("the entity name", result$name$description)
})

test_that(".parseArgSectionBody parses multiple arguments at the same indent", {
  body <- "    entity: the synapse entity\n    version: the version number"
  result <- .parseArgSectionBody(body)
  expect_true(all(c("entity", "version") %in% names(result)))
  expect_equal("the synapse entity", result$entity$description)
  expect_equal("the version number", result$version$description)
})

test_that(".parseArgSectionBody joins a deeper-indented continuation line with a space", {
  body <- "    entity: the synapse\n        entity to store"
  result <- .parseArgSectionBody(body)
  expect_equal("the synapse entity to store", result$entity$description)
})

test_that(".parseArgSectionBody preserves a blank-line paragraph break in the description", {
  body <- "    entity: first paragraph\n\n        second paragraph"
  result <- .parseArgSectionBody(body)
  expect_true(grepl("first paragraph\n\nsecond paragraph", result$entity$description))
})

test_that(".parseArgSectionBody detects the base indent from the first non-blank line", {
  body <- "        entity: the synapse entity"
  result <- .parseArgSectionBody(body)
  expect_equal("the synapse entity", result$entity$description)
})

test_that(".parseArgSectionBody stores the last argument even with no trailing match after it", {
  body <- "    first: the first arg\n    second: the second arg"
  result <- .parseArgSectionBody(body)
  expect_equal("the second arg", result$second$description)
})

# ---------------------------------------------------------------------------
# parseArgDescriptionsFromDetails
# ---------------------------------------------------------------------------

test_that("parseArgDescriptionsFromDetails returns empty list for plain description", {
  result <- parseArgDescriptionsFromDetails("Just a description, no params.")
  expect_equal(0L, length(result))
})

test_that("parseArgDescriptionsFromDetails extracts a single Arguments: entry", {
  doc <- "A function.\nArguments:\n    name: the entity name"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("name" %in% names(result))
  expect_true(grepl("entity name", result$name$description))
})

test_that("parseArgDescriptionsFromDetails extracts multiple Arguments: entries", {
  doc <- "Arguments:\n    entity: the synapse entity\n    version: the version number"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("entity" %in% names(result))
  expect_true("version" %in% names(result))
})

test_that("parseArgDescriptionsFromDetails stops an entry's text at the next section header", {
  doc <- "Arguments:\n    name: the name\nReturns:\n    Extra text that should be excluded"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_false(grepl("Extra text", result$name$description))
})

test_that("parseArgDescriptionsFromDetails accepts Attributes: as well as Arguments:", {
  doc <- "Attributes:\n    entity: the synapse entity"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("entity" %in% names(result))
})

test_that("parseArgDescriptionsFromDetails joins a soft-wrapped continuation line with a space", {
  doc <- "Arguments:\n    entity: the synapse\n        entity to store"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true(grepl("the synapse entity to store", result$entity$description))
})

# ---------------------------------------------------------------------------
# generateFunctionalInterfaceInfo
# ---------------------------------------------------------------------------

test_that("generateFunctionalInterfaceInfo returns empty list for class with no methods", {
  classInfo <- list(list(
    name = "MyClass",
    methods = NULL,
    constructorArgs = list(),
    doc = ""
  ))
  expect_equal(list(), generateFunctionalInterfaceInfo(classInfo))
})

test_that("generateFunctionalInterfaceInfo skips the constructor method", {
  classInfo <- list(list(
    name = "MyClass",
    methods = list(list(
      name = "MyClass",
      doc = "",
      args = list(
        args = list("self"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  expect_equal(list(), generateFunctionalInterfaceInfo(classInfo))
})

test_that("generateFunctionalInterfaceInfo creates correct generic name with syn prefix", {
  classInfo <- list(list(
    name = "File",
    methods = list(list(
      name = "get",
      doc = "",
      args = list(
        args = list("self", "synapse_id"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  result <- generateFunctionalInterfaceInfo(classInfo, functionPrefix = "syn")
  expect_equal(1L, length(result))
  expect_equal("synGet", result[[1]]$rName)
  expect_equal("File", result[[1]]$targetClass)
  expect_true("synapse_id" %in% result[[1]]$args$args)
})

test_that("generateFunctionalInterfaceInfo sets a Class-qualified fileName distinct from rName", {
  classInfo <- list(list(
    name = "File",
    methods = list(list(
      name = "get_acl",
      doc = "",
      args = list(
        args = list("self"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  result <- generateFunctionalInterfaceInfo(classInfo, functionPrefix = "syn")
  expect_equal("synGetAcl", result[[1]]$rName)
  expect_equal("File_GetAcl", result[[1]]$fileName)
})

test_that("generateFunctionalInterfaceInfo gives two classes sharing a method the same rName but different fileName", {
  classInfo <- list(
    list(
      name = "File",
      methods = list(list(
        name = "get_acl",
        doc = "",
        args = list(
          args = list("self"),
          defaults = list(),
          varargs = NULL,
          keywords = NULL
        )
      )),
      constructorArgs = list(),
      doc = ""
    ),
    list(
      name = "Folder",
      methods = list(list(
        name = "get_acl",
        doc = "",
        args = list(
          args = list("self"),
          defaults = list(),
          varargs = NULL,
          keywords = NULL
        )
      )),
      constructorArgs = list(),
      doc = ""
    )
  )
  result <- generateFunctionalInterfaceInfo(classInfo, functionPrefix = "syn")
  expect_equal(2L, length(result))
  expect_equal(result[[1]]$rName, result[[2]]$rName)
  expect_false(result[[1]]$fileName == result[[2]]$fileName)
  expect_equal("File_GetAcl", result[[1]]$fileName)
  expect_equal("Folder_GetAcl", result[[2]]$fileName)
})

test_that("generateFunctionalInterfaceInfo's fileName reflects the mapped rName, not the default", {
  classInfo <- list(list(
    name = "Team",
    methods = list(list(
      name = "invite",
      doc = "",
      args = list(
        args = list("self"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  mapping <- list(explicit = list("synInvite" = "synInviteToTeam"))
  result <- generateFunctionalInterfaceInfo(
    classInfo,
    functionPrefix = "syn",
    functionNameMapping = mapping
  )
  expect_equal("synInviteToTeam", result[[1]]$rName)
  expect_equal("Team_InviteToTeam", result[[1]]$fileName)
})

test_that("generateFunctionalInterfaceInfo strips self and prepends instance in its place", {
  classInfo <- list(list(
    name = "File",
    methods = list(list(
      name = "store",
      doc = "",
      args = list(
        args = list("self", "force"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  result <- generateFunctionalInterfaceInfo(classInfo)
  args <- result[[1]]$args$args
  expect_false("self" %in% args)
  expect_equal("instance", args[[1]])
  expect_true("force" %in% args)
})

test_that("generateFunctionalInterfaceInfo supplies a class-specific description for instance", {
  classInfo <- list(list(
    name = "File",
    methods = list(list(
      name = "store",
      doc = "",
      args = list(
        args = list("self", "force"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  result <- generateFunctionalInterfaceInfo(classInfo)
  expect_true(grepl("File", result[[1]]$argDescriptions$instance$description))
})

test_that("generateFunctionalInterfaceInfo applies function name mapping", {
  classInfo <- list(list(
    name = "Team",
    methods = list(list(
      name = "invite",
      doc = "",
      args = list(
        args = list("self"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  mapping <- list(explicit = list("synInvite" = "synInviteToTeam"))
  result <- generateFunctionalInterfaceInfo(
    classInfo,
    functionPrefix = "syn",
    functionNameMapping = mapping
  )
  expect_equal("synInviteToTeam", result[[1]]$rName)
})

test_that("generateFunctionalInterfaceInfo sets functionContainerName to ClassName.methodName", {
  classInfo <- list(list(
    name = "File",
    methods = list(list(
      name = "get_acl",
      doc = "",
      args = list(
        args = list("self"),
        defaults = list(),
        varargs = NULL,
        keywords = NULL
      )
    )),
    constructorArgs = list(),
    doc = ""
  ))
  result <- generateFunctionalInterfaceInfo(classInfo, functionPrefix = "syn")
  expect_equal("File.get_acl", result[[1]]$functionContainerName)
})

test_that("generateFunctionalInterfaceInfo iterates all classes and all methods", {
  classInfo <- list(
    list(
      name = "File",
      methods = list(
        list(
          name = "get_acl",
          doc = "",
          args = list(
            args = list("self"),
            defaults = list(),
            varargs = NULL,
            keywords = NULL
          )
        ),
        list(
          name = "snapshot",
          doc = "",
          args = list(
            args = list("self"),
            defaults = list(),
            varargs = NULL,
            keywords = NULL
          )
        )
      ),
      constructorArgs = list(),
      doc = ""
    ),
    list(
      name = "Project",
      methods = list(
        list(
          name = "delete",
          doc = "",
          args = list(
            args = list("self"),
            defaults = list(),
            varargs = NULL,
            keywords = NULL
          )
        )
      ),
      constructorArgs = list(),
      doc = ""
    )
  )
  result <- generateFunctionalInterfaceInfo(classInfo, functionPrefix = "syn")
  rNames <- sapply(result, function(x) x$rName)
  targetClasses <- sapply(result, function(x) x$targetClass)

  expect_equal(3L, length(result))
  expect_true("synGetAcl" %in% rNames)
  expect_true("synSnapshot" %in% rNames)
  expect_true("synDelete" %in% rNames)
  expect_equal(2L, sum(targetClasses == "File"))
  expect_equal(1L, sum(targetClasses == "Project"))
})

# ---------------------------------------------------------------------------
# .removeEmptyRdSections
# ---------------------------------------------------------------------------

test_that(".removeEmptyRdSections strips an empty \\details{} block", {
  content <- "before\n\\details{}\nafter"
  expect_equal("before\nafter", .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections strips a whitespace-only \\note{} block", {
  content <- "before\n\\note{   }\nafter"
  expect_equal("before\nafter", .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections strips an empty \\seealso{} block", {
  content <- "before\n\\seealso{}\nafter"
  expect_equal("before\nafter", .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections strips an \\examples{} block containing only blank lines", {
  content <- "before\n\\examples{\n  \n}\nafter"
  expect_equal("before\nafter", .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections strips an empty \\section{Errors}{} block", {
  content <- "before\n\\section{Errors}{}\nafter"
  expect_equal("before\nafter", .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections leaves a \\details{} block with real content untouched", {
  content <- "\\details{Has real content}"
  expect_equal(content, .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections leaves an empty section with an unrelated name untouched", {
  content <- "\\section{Methods}{}"
  expect_equal(content, .removeEmptyRdSections(content))
})

test_that(".removeEmptyRdSections strips several empty sections from the same content", {
  content <- paste(
    "before",
    "\\details{}",
    "\\note{   }",
    "\\seealso{}",
    "\\examples{\n  \n}",
    "\\section{Errors}{}",
    "\\section{Methods}{}",
    "\\details{Has real content}",
    "after",
    sep = "\n"
  )
  result <- .removeEmptyRdSections(content)
  expect_equal(
    "before\n\\section{Methods}{}\n\\details{Has real content}\nafter",
    result
  )
})

# ---------------------------------------------------------------------------
# .buildMethodsListContent
# ---------------------------------------------------------------------------

test_that(".buildMethodsListContent replaces the constructor's own description", {
  methods <- list(
    list(
      name = "File",
      description = "Should be ignored for the constructor entry",
      args = list(args = list(), defaults = list()),
      argDescriptionsFromDoc = list()
    )
  )
  result <- .buildMethodsListContent(methods, "File", NULL)
  expect_equal(
    "\\item \\code{File()}: Constructor for \\code{\\link{File}}",
    result
  )
})

test_that(".buildMethodsListContent runs a non-constructor method's doc through the Google-docstring pipeline", {
  methods <- list(
    list(
      name = "get_acl",
      description = "Gets the ACL.\nReturns:\n    the ACL",
      args = list(args = list("self", "recursive"), defaults = list(FALSE)),
      argDescriptionsFromDoc = list()
    )
  )
  result <- .buildMethodsListContent(methods, "File", NULL)
  expect_equal(
    "\\item \\code{get_acl(recursive=FALSE)}: Gets the ACL.",
    result
  )
})

test_that(".buildMethodsListContent leaves a NULL description empty rather than erroring", {
  methods <- list(
    list(
      name = "no_desc",
      description = NULL,
      args = list(args = list(), defaults = list()),
      argDescriptionsFromDoc = list()
    )
  )
  result <- .buildMethodsListContent(methods, "File", NULL)
  expect_equal("\\item \\code{no_desc()}: ", result)
})

test_that(".buildMethodsListContent joins multiple methods with a newline, one \\item per method", {
  methods <- list(
    list(
      name = "File",
      description = "ignored",
      args = list(args = list(), defaults = list()),
      argDescriptionsFromDoc = list()
    ),
    list(
      name = "get_acl",
      description = "Gets the ACL.",
      args = list(args = list("self"), defaults = list()),
      argDescriptionsFromDoc = list()
    )
  )
  result <- .buildMethodsListContent(methods, "File", NULL)
  lines <- strsplit(result, "\n", fixed = TRUE)[[1]]
  expect_equal(2L, length(lines))
  expect_true(grepl("Constructor for \\\\code\\{\\\\link\\{File\\}\\}", lines[1]))
  expect_true(grepl("Gets the ACL\\.", lines[2]))
})

# ---------------------------------------------------------------------------
# defineConstructor (requires Python / gateway module)
# ---------------------------------------------------------------------------

test_that("defineConstructor calls setGenericCallback with the class name", {
  # stand-in for setGeneric; records registered functions by name
  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineConstructor("synapseclient.models", mockCb, "File", pyParams)

  expect_true("File" %in% names(captured))
})

test_that("defineConstructor registers a no-arg constructor with empty formals", {
  # stand-in for setGeneric; records registered functions by name
  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineConstructor("synapseclient.models", mockCb, "Project", pyParams)

  expect_length(formals(captured[["Project"]]), 1) # the ... in rFn
})

test_that("defineConstructor registers correct formals from pyParams args and defaults", {
  # stand-in for setGeneric; records registered functions by name
  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("name", "parent", "description"),
    defaults = list("text"),
    varargs = NULL,
    keywords = NULL
  )
  defineConstructor("synapseclient.models", mockCb, "Folder", pyParams)

  fn_formals <- formals(captured[["Folder"]])
  expect_named(fn_formals, c("name", "parent", "description"))
  expect_identical(fn_formals$name, quote(expr = ))
  expect_identical(fn_formals$parent, quote(expr = ))
  expect_identical(fn_formals$description, "text")
})

test_that("defineConstructor adds dots when pyParams has keywords", {
  # stand-in for setGeneric; records registered functions by name
  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("name"),
    defaults = list(),
    varargs = NULL,
    keywords = "kwargs"
  )
  defineConstructor("synapseclient.models", mockCb, "Table", pyParams)

  expect_true("..." %in% names(formals(captured[["Table"]])))
})

test_that("defineConstructor registered function prepends class name to returned object's class vector", {
  # Mock gateway$invoke so no real Python constructor is called
  # unlockBinding is needed because a prior test may have called .getGateway()
  ns <- environment(defineConstructor)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  # Ensure "sys" is in the Python namespace so py_eval("sys") succeeds
  reticulate::py_run_string("import sys")

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineConstructor("sys", mockCb, "File", pyParams)

  result <- captured[["File"]]()

  expect_equal("File", class(result)[1])
})

# ---------------------------------------------------------------------------
# defineClassMethod (requires Python / gateway module)
# ---------------------------------------------------------------------------

test_that("defineClassMethod registers function as ClassName_methodName", {
  ns <- environment(defineClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)
  # stand-in for setGeneric; records registered functions by name
  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineClassMethod("synapseclient.models", mockCb, "File", "get", pyParams)

  expect_true("File_get" %in% names(captured))
})

test_that("defineClassMethod puts instance as first formal and drops self", {
  ns <- environment(defineClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("self", "entity", "version"),
    defaults = list(NULL),
    varargs = NULL,
    keywords = NULL
  )
  defineClassMethod("synapseclient.models", mockCb, "File", "get", pyParams)

  fn_formals <- names(formals(captured[["File_get"]]))
  expect_equal("instance", fn_formals[1])
  expect_false("self" %in% fn_formals)
  expect_true("entity" %in% fn_formals)
  expect_true("version" %in% fn_formals)
})

test_that("defineClassMethod adds dots when pyParams has keywords", {
  ns <- environment(defineClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = "kwargs"
  )
  defineClassMethod("synapseclient.models", mockCb, "File", "store", pyParams)

  expect_true("..." %in% names(formals(captured[["File_store"]])))
})

test_that("defineClassMethod R function name comes from methodName, not pythonMethodName", {
  ns <- environment(defineClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineClassMethod(
    "synapseclient.models",
    mockCb,
    "File",
    "store",
    pyParams,
    pythonMethodName = "store_async"
  )

  expect_true("File_store" %in% names(captured))
})

test_that("defineClassMethod calling wrapper with NULL instance errors with class name", {
  ns <- environment(defineClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineClassMethod("synapseclient.models", mockCb, "File", "get", pyParams)

  expect_error(captured[["File_get"]](NULL), regexp = "File")
})

# ---------------------------------------------------------------------------
# defineFunctionalClassMethod (requires Python / gateway module)
# ---------------------------------------------------------------------------

test_that("defineFunctionalClassMethod registers a generic name for the method", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineFunctionalClassMethod(
    "synapseclient.models",
    "Project",
    "store",
    pyParams
  )

  expect_true(exists("synStore", mode = "function", inherits = TRUE))
  expect_false(exists("synStoreProject", mode = "function", inherits = TRUE))
})

test_that("defineFunctionalClassMethod stores inner worker in dispatch table", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineFunctionalClassMethod("synapseclient.models", "File", "store", pyParams)

  expect_true(exists(
    "synStore_File",
    envir = .functionalMethodDispatch,
    inherits = FALSE
  ))

  worker <- get(
    "synStore_File",
    envir = .functionalMethodDispatch,
    inherits = FALSE
  )
  expect_true(is.function(worker))
  expect_equal("instance", names(formals(worker))[1])

  fake_instance <- structure(list(), class = "File") # pass a fake instance to the worker
  expect_equal(list(), worker(fake_instance))
})

test_that("defineFunctionalClassMethod generic errors with pipe-hint when called without instance", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  localNs <- new.env(parent = ns)
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  # Use get_acl — not a real registered function — so defineFunctionalClassMethod
  # registers a fresh generic rather than skipping due to the !exists() guard.
  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "synapseclient.models",
    "Project",
    "get_acl",
    pyParams
  )

  fn <- get("synGetAcl", envir = localNs)
  expect_error(
    fn(),
    regexp = "Pass an object as the first argument, e.g. ClassName\\(...\\) \\|> synGetAcl\\(\\)"
  )
})

test_that("defineFunctionalClassMethod generic errors for unregistered class", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  localNs <- new.env(parent = ns)
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "synapseclient.models",
    "Project",
    "get_acl",
    pyParams
  )

  fn <- get("synGetAcl", envir = localNs)
  obj <- structure(list(), class = "UnknownClass")
  expect_error(
    fn(obj),
    regexp = "No 'synGetAcl' method registered for class 'UnknownClass'"
  )
})

test_that("defineFunctionalClassMethod applies functionNameMapping to generic name", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  localNs <- new.env(parent = ns)
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("self"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  mapping <- list(explicit = list("synInvite" = "synInviteToTeam_test"))
  localDefineFunctionalClassMethod(
    "synapseclient.models",
    "Team",
    "invite",
    pyParams,
    functionNameMapping = mapping
  )

  expect_true(exists(
    "synInviteToTeam_test",
    envir = localNs,
    mode = "function",
    inherits = FALSE
  ))
  expect_false(exists(
    "synInviteTeam",
    envir = localNs,
    mode = "function",
    inherits = FALSE
  ))
  expect_true(exists(
    "synInviteToTeam_Team",
    envir = .functionalMethodDispatch,
    inherits = FALSE
  ))
})

test_that("defineFunctionalClassMethod static: registers plain function without instance formal", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  localNs <- new.env(parent = ns)
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("query"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "synapseclient.models",
    "Table",
    "query",
    pyParams,
    isStatic = TRUE
  )

  expect_true(exists(
    "synQuery",
    envir = localNs,
    mode = "function",
    inherits = FALSE
  ))
  expect_false("instance" %in% names(formals(get("synQuery", envir = localNs))))
  expect_true("query" %in% names(formals(get("synQuery", envir = localNs))))
})

test_that("defineFunctionalClassMethod static: forwards named formals to kwargs", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  reticulate::py_run_string("import builtins")

  localNs <- new.env(parent = ns)
  localNs$cleanUpStackTrace <- function(callable, args) args
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("query", "timeout"),
    defaults = list(250L),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "builtins",
    "dict",
    "query",
    pyParams,
    isStatic = TRUE
  )

  result <- get("synQuery", envir = localNs)(
    query = "select * from syn123 limit 2",
    timeout = 42L
  )
  expect_equal(result$kwargs$query, "select * from syn123 limit 2")
  expect_equal(result$kwargs$timeout, 42L)
})

test_that("defineFunctionalClassMethod static: forwards positional arg to args (not kwargs)", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  reticulate::py_run_string("import builtins")

  localNs <- new.env(parent = ns)
  localNs$cleanUpStackTrace <- function(callable, args) args
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("query", "timeout"),
    defaults = list(250L),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "builtins",
    "dict",
    "query",
    pyParams,
    isStatic = TRUE
  )

  result <- get("synQuery", envir = localNs)("select * from syn123")
  expect_equal(result$args[[1]], "select * from syn123")
  expect_equal(length(result$kwargs), 0L)
})

test_that("defineFunctionalClassMethod static: does not register in functional dispatch table", {
  ns <- environment(defineFunctionalClassMethod)
  original_gateway <- get(".gateway", envir = ns)
  if (bindingIsLocked(".gateway", ns)) {
    unlockBinding(".gateway", ns)
  }
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  localNs <- new.env(parent = ns)
  localDefineFunctionalClassMethod <- defineFunctionalClassMethod
  environment(localDefineFunctionalClassMethod) <- localNs

  pyParams <- list(
    args = list("query"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  localDefineFunctionalClassMethod(
    "synapseclient.models",
    "Table",
    "query",
    pyParams,
    isStatic = TRUE
  )

  expect_false(exists(
    "synQuery_Table",
    envir = .functionalMethodDispatch,
    inherits = FALSE
  ))
})

# ---------------------------------------------------------------------------
# defineFunction (requires Python / gateway module)
# ---------------------------------------------------------------------------

test_that("defineFunction registers function under the given R name", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }
  pyParams <- list(
    args = list("synapse_id"),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  defineFunction("synGet", "get", "synapseclient.operations", pyParams, mockCb)

  expect_true("synGet" %in% names(captured))
  expect_true(is.function(captured[["synGet"]]))
})

test_that("defineFunction creates formals matching pyParams args", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }
  pyParams <- list(
    args = list("entity", "version", "downloadFile"),
    defaults = list(NULL, TRUE),
    varargs = NULL,
    keywords = NULL
  )
  defineFunction("synGet", "get", "synapseclient.operations", pyParams, mockCb)

  fn_formals <- formals(captured[["synGet"]])
  expect_equal(c("entity", "version", "downloadFile"), names(fn_formals))
  expect_identical(fn_formals$version, NULL)
  expect_identical(fn_formals$downloadFile, TRUE)
})

test_that("defineFunction adds dots and preserves args when pyParams has varargs", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }

  defineFunction(
    "synStore",
    "store",
    "synapseclient.operations",
    list(
      args = list("entity"),
      defaults = list(),
      varargs = "args",
      keywords = NULL
    ),
    mockCb
  )
  varargs_formals <- names(formals(captured[["synStore"]]))
  expect_true("entity" %in% varargs_formals)
  expect_true("..." %in% varargs_formals)
})

test_that("defineFunction synStore has entity as first formal for pipe compatibility", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) {
    captured[[name]] <<- def
  }
  pyParams <- list(
    args = list("entity"),
    defaults = list(),
    varargs = NULL,
    keywords = "kwargs"
  )
  defineFunction(
    "synStore",
    "store",
    "synapseclient.operations",
    pyParams,
    mockCb
  )

  expect_equal("entity", names(formals(captured[["synStore"]]))[1])
})

test_that("defineFunction applies functionNameMapping to registered R name", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  mapping <- list(explicit = list("synRestGetAsync" = "synRestGet"))

  defineFunction(
    "synRestGetAsync",
    "rest_get_async",
    "synapseclient.Synapse",
    pyParams,
    mockCb,
    functionNameMapping = mapping
  )

  expect_true("synRestGet" %in% names(captured))
  expect_false("synRestGetAsync" %in% names(captured))
})

test_that("defineFunction falls back to original name when not in functionNameMapping", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  mapping <- list(explicit = list("synFoo" = "synBar"))

  defineFunction(
    "synGet",
    "get",
    "synapseclient.operations",
    pyParams,
    mockCb,
    functionNameMapping = mapping
  )

  expect_true("synGet" %in% names(captured))
  expect_false("synBar" %in% names(captured))
})

test_that("defineFunction with NULL functionNameMapping uses original name", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )

  defineFunction(
    "synRestGetAsync",
    "rest_get_async",
    "synapseclient.Synapse",
    pyParams,
    mockCb,
    functionNameMapping = NULL
  )

  expect_true("synRestGetAsync" %in% names(captured))
})

# ---------------------------------------------------------------------------
# autoGenerateFunctions
# ---------------------------------------------------------------------------

test_that("autoGenerateFunctions registers all functions by rName", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  functionInfo <- list(
    list(
      rName = "synGet",
      pyName = "get",
      functionContainerName = "synapseclient.operations",
      args = pyParams
    ),
    list(
      rName = "synStore",
      pyName = "store",
      functionContainerName = "synapseclient.operations",
      args = pyParams
    )
  )

  autoGenerateFunctions(mockCb, functionInfo)

  expect_true("synGet" %in% names(captured))
  expect_true("synStore" %in% names(captured))
})

test_that("autoGenerateFunctions applies functionNameMapping to matching entries", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  functionInfo <- list(
    list(
      rName = "synRestGetAsync",
      pyName = "rest_get_async",
      functionContainerName = "synapseclient.Synapse",
      args = pyParams
    ),
    list(
      rName = "synGet",
      pyName = "get",
      functionContainerName = "synapseclient.operations",
      args = pyParams
    )
  )
  mapping <- list(explicit = list("synRestGetAsync" = "synRestGet"))

  autoGenerateFunctions(mockCb, functionInfo, functionNameMapping = mapping)

  expect_true("synRestGet" %in% names(captured))
  expect_false("synRestGetAsync" %in% names(captured))
  expect_true("synGet" %in% names(captured))
})

test_that("autoGenerateFunctions with NULL functionNameMapping uses original rNames", {
  ns <- environment(defineFunction)
  original_gateway <- get(".gateway", envir = ns)
  assign(".gateway", list(invoke = function(...) list()), envir = ns)
  on.exit(assign(".gateway", original_gateway, envir = ns), add = TRUE)

  captured <- list()
  mockCb <- function(name, def) captured[[name]] <<- def
  pyParams <- list(
    args = list(),
    defaults = list(),
    varargs = NULL,
    keywords = NULL
  )
  functionInfo <- list(
    list(
      rName = "synRestGetAsync",
      pyName = "rest_get_async",
      functionContainerName = "synapseclient.Synapse",
      args = pyParams
    )
  )

  autoGenerateFunctions(mockCb, functionInfo, functionNameMapping = NULL)

  expect_true("synRestGetAsync" %in% names(captured))
})

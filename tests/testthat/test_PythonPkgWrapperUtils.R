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

test_that("applyFunctionNameMapping applies all predefined synapseClient models mappings", {
  mapping <- .synapseClientModelsMapping()
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

test_that("getDescription stops before :param: marker", {
  doc <- "Summary line.\n:param name: the name"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before :returns: marker", {
  doc <- "Summary line.\n:returns: the result"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before :return: (no s) marker", {
  doc <- "Summary line.\n:return: the result"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription stops before :type: marker", {
  doc <- "Summary line.\n:type name: str"
  expect_equal("Summary line.", getDescription(doc))
})

test_that("getDescription normalises CRLF to LF", {
  doc <- "Summary line.\r\n:param x: foo"
  expect_equal("Summary line.", getDescription(doc))
})

# ---------------------------------------------------------------------------
# getReturned
# ---------------------------------------------------------------------------

test_that("getReturned returns empty string for NULL", {
  expect_equal("", getReturned(NULL))
})

test_that("getReturned returns empty string for empty string", {
  expect_equal("", getReturned(""))
})

test_that("getReturned returns empty string when no :returns: section", {
  expect_equal("", getReturned("A description with no return section."))
})

test_that("getReturned extracts :returns: description", {
  doc <- "A function.\n:returns: the result value"
  expect_true(grepl("the result value", getReturned(doc)))
})

test_that("getReturned works with :return: (no s)", {
  doc <- "A function.\n:return: the result value"
  expect_true(grepl("the result value", getReturned(doc)))
})

test_that("getReturned stops at a double newline", {
  doc <- "A function.\n:returns: the result\n\nExtra text that should be cut"
  result <- getReturned(doc)
  expect_false(grepl("Extra text", result))
  expect_true(grepl("the result", result))
})

# ---------------------------------------------------------------------------
# getExample
# ---------------------------------------------------------------------------

test_that("getExample returns empty string for NULL", {
  expect_equal("", getExample(NULL))
})

test_that("getExample returns empty string for empty string", {
  expect_equal("", getExample(""))
})

test_that("getExample returns empty string when no example section", {
  expect_equal("", getExample("A plain description."))
})

test_that("getExample extracts content after Example::", {
  doc <- "Example::\n\n  result = do_thing()"
  result <- getExample(doc)
  expect_true(grepl("do_thing", result))
})

test_that("getExample matches lowercase example::", {
  doc <- "example::\n\n  code_here()"
  result <- getExample(doc)
  expect_true(grepl("code_here", result))
})

test_that("getExample matches Example: (single colon)", {
  doc <- "Example:\n\n  code_here()"
  result <- getExample(doc)
  expect_true(grepl("code_here", result))
})

# ---------------------------------------------------------------------------
# changeSphinxHyperlinksToLatex / convertSphinxToLatex
# ---------------------------------------------------------------------------

test_that("changeSphinxHyperlinksToLatex converts Sphinx links to \\href", {
  raw <- "`link text <http://example.com>`_"
  result <- changeSphinxHyperlinksToLatex(raw)
  expect_true(grepl(
    "\\\\href\\{http://example\\.com\\}\\{link text\\}",
    result
  ))
})

test_that("changeSphinxHyperlinksToLatex leaves plain text unchanged", {
  raw <- "No hyperlinks here."
  expect_equal(raw, changeSphinxHyperlinksToLatex(raw))
})

test_that("convertSphinxToLatex delegates to changeSphinxHyperlinksToLatex", {
  raw <- "`text <http://example.com>`_"
  expect_equal(changeSphinxHyperlinksToLatex(raw), convertSphinxToLatex(raw))
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
# pyVerbiageToLatex
# ---------------------------------------------------------------------------

test_that("pyVerbiageToLatex returns empty string for NULL", {
  expect_equal("", pyVerbiageToLatex(NULL))
})

test_that("pyVerbiageToLatex returns empty string for empty string", {
  expect_equal("", pyVerbiageToLatex(""))
})

test_that("pyVerbiageToLatex strips :py:class: and keeps only the final component", {
  result <- pyVerbiageToLatex("See :py:class:`synapseclient.entity.File`.")
  expect_false(grepl(":py:class:", result))
  expect_false(grepl("synapseclient.entity", result))
  expect_true(grepl("File", result))
})

test_that("pyVerbiageToLatex capitalizes the first letter of the final component of :py:mod:", {
  result <- pyVerbiageToLatex("Use :py:mod:`synapseclient.table`.")
  expect_false(grepl(":py:mod:", result))
  expect_true(grepl("Table", result))
})

test_that("pyVerbiageToLatex strips :py:func: and :py:meth: tags, keeping the text", {
  result_func <- pyVerbiageToLatex("Call :py:func:`synapseclient.login`.")
  expect_false(grepl(":py:func:", result_func))
  expect_true(grepl("synapseclient.login", result_func))

  result_meth <- pyVerbiageToLatex("Call :py:meth:`Synapse.login`.")
  expect_false(grepl(":py:meth:", result_meth))
  expect_true(grepl("Synapse.login", result_meth))
})

test_that("pyVerbiageToLatex converts Sphinx hyperlinks in text", {
  result <- pyVerbiageToLatex("`Synapse <http://synapse.org>`_")
  expect_true(grepl("\\\\href", result))
})

test_that("pyVerbiageToLatex converts :param: tags to plain text form", {
  result <- pyVerbiageToLatex(":param entity: the entity to get")
  expect_false(grepl(":param", result))
  expect_true(grepl("entity:", result))
})

# ---------------------------------------------------------------------------
# formatArgsForArgumentSection
# ---------------------------------------------------------------------------

test_that("formatArgsForArgumentSection returns empty string for no args", {
  expect_equal("", formatArgsForArgumentSection(list(), list()))
})

test_that("formatArgsForArgumentSection produces \\item entries for each arg", {
  argNames <- list("entity", "version")
  argDesc <- list(entity = "The entity", version = "Version number")
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
  argDesc <- list(entity = "The entity", extraArg = "An optional kwarg")
  result <- formatArgsForArgumentSection(argNames, argDesc)
  expect_true(grepl("optional named parameter", result))
  expect_true(grepl("extraArg", result))
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
# parseArgDescriptionsFromDetails
# ---------------------------------------------------------------------------

test_that("parseArgDescriptionsFromDetails returns empty list for plain description", {
  result <- parseArgDescriptionsFromDetails("Just a description, no params.")
  expect_equal(0L, length(result))
})

test_that("parseArgDescriptionsFromDetails extracts single :param: description", {
  doc <- "A function.\n:param name: the entity name"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("name" %in% names(result))
  expect_true(grepl("entity name", result$name))
})

test_that("parseArgDescriptionsFromDetails extracts multiple :param: descriptions", {
  doc <- ":param entity: the synapse entity\n:param version: the version number"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("entity" %in% names(result))
  expect_true("version" %in% names(result))
})

test_that("parseArgDescriptionsFromDetails truncates description at double newline", {
  doc <- ":param name: the name\n\nExtra text that should be excluded"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_false(grepl("Extra text", result$name))
})

test_that("parseArgDescriptionsFromDetails accepts :parameter: keyword as well", {
  doc <- ":parameter entity: the synapse entity"
  result <- parseArgDescriptionsFromDetails(doc)
  expect_true("entity" %in% names(result))
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

test_that("generateFunctionalInterfaceInfo strips self and does not add instance", {
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
  expect_false("instance" %in% args)
  expect_true("force" %in% args)
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

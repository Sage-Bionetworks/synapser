# One way to run the test is using devtools::test(filter = "docExamples")
# from the synapser package directory.
context("test generated documentation examples")

# These tests read the .Rd files and vignettes from the package source tree, so
# they only apply when that tree is reachable (it is under devtools::test() and
# under the CI build, which runs from the checkout). Walk up from the testthat
# working directory looking for DESCRIPTION.
.packageSourceRoot <- function() {
  dir <- normalizePath(".", mustWork = FALSE)
  repeat {
    if (file.exists(file.path(dir, "DESCRIPTION"))) {
      return(dir)
    }
    parent <- dirname(dir)
    if (identical(parent, dir)) {
      return(NULL)
    }
    dir <- parent
  }
}

# The R code of an .Rd file's \examples{} section. tools::Rd2ex()
# converts the \examples{} block into a plain .R script.
# comments out the body of a \dontrun{} block with a "##D " prefix, and adds
# markers ### so it has to be stripped back off before the result can be parsed as R.
.exampleCode <- function(rdFile) {
  out <- tempfile()
  on.exit(unlink(out), add = TRUE)
  tools::Rd2ex(rdFile, out)
  if (!file.exists(out)) {
    return(character())
  }
  lines <- readLines(out, warn = FALSE)
  lines <- sub("^##D ?", "", lines[!grepl("^###", lines)])
  lines[!grepl("^## (Not run|End\\()", lines)]
}

# The text of a single top-level Rd section, e.g. \usage or \value. A
# \section{<title>}{...} block (e.g. the class doc's "Methods" section) can't
# be matched by tag alone -- every \section{} shares the same "\\section"
# Rd_tag regardless of title, and the title is its own child node rather than
# part of the tag. Pass "\\section{Methods}" to select it by title instead;
# the returned text is that section's body (the second brace group).
.rdSection <- function(rdFile, tag) {
  parsed <- tools::parse_Rd(rdFile)
  tags <- vapply(parsed, function(x) attr(x, "Rd_tag"), character(1))

  if (grepl("^\\\\section\\{.*\\}$", tag)) {
    title <- sub("^\\\\section\\{(.*)\\}$", "\\1", tag)
    for (candidate in parsed[tags == "\\section"]) {
      candidateTitle <- trimws(paste(unlist(candidate[[1]]), collapse = ""))
      if (identical(candidateTitle, title)) {
        return(trimws(paste(unlist(candidate[[2]]), collapse = "")))
      }
    }
    return(NA_character_)
  }

  section <- parsed[tags == tag]
  if (!length(section)) {
    return(NA_character_)
  }
  trimws(paste(unlist(section[[1]]), collapse = ""))
}

# Maps each documented function name to the argument names in its \usage{}.
# Both positional arguments and those with defaults are collected.
.documentedFormals <- function(dirs) {
  result <- list()
  for (dir in dirs) {
    for (file in list.files(dir, pattern = "[.]Rd$", full.names = TRUE)) {
      usage <- tryCatch(.rdSection(file, "\\usage"), error = function(e) {
        NA_character_
      })
      if (is.na(usage) || !nzchar(usage)) {
        next
      }
      exprs <- tryCatch(parse(text = usage), error = function(e) NULL)
      for (expr in exprs) {
        if (!is.call(expr) || !is.name(expr[[1]])) {
          next
        }
        parts <- as.list(expr)
        names <- names(parts)
        formals <- character()
        for (i in seq_along(parts)[-1]) {
          name <- if (is.null(names)) "" else names[i]
          if (nzchar(name)) {
            formals <- c(formals, name)
          } else if (is.name(parts[[i]])) {
            formals <- c(formals, as.character(parts[[i]]))
          }
        }
        fn <- as.character(expr[[1]])
        result[[fn]] <- union(result[[fn]], formals)
      }
    }
  }
  result
}

# Names of the functions documented as returning nothing. Piping one of these
# into another call passes it NULL.
.nullReturningFunctions <- function(dirs) {
  result <- character()
  for (dir in dirs) {
    for (file in list.files(dir, pattern = "[.]Rd$", full.names = TRUE)) {
      value <- tryCatch(.rdSection(file, "\\value"), error = function(e) {
        NA_character_
      })
      if (is.na(value) || !identical(value, "None")) {
        next
      }
      name <- tryCatch(.rdSection(file, "\\name"), error = function(e) {
        NA_character_
      })
      if (!is.na(name)) result <- union(result, name)
    }
  }
  result
}

# The R code of each ```{r} chunk in an .Rmd file, with its starting line.
.vignetteChunks <- function(path) {
  lines <- readLines(path, warn = FALSE)
  lapply(grep("^```\\{r", lines), function(start) {
    close <- start +
      which(grepl("^```[[:space:]]*$", lines[(start + 1):length(lines)]))[1]
    list(
      line = start,
      code = if (close > start + 1) {
        lines[(start + 1):(close - 1)]
      } else {
        character()
      }
    )
  })
}

# Walks an expression tree, accumulating the things that parse cleanly but fail
# when the chunk is actually evaluated during a vignette build.
.collectCallProblems <- function(expr, found, nullReturning) {
  if (!is.call(expr)) {
    if (is.name(expr) && as.character(expr) %in% c("True", "False", "None")) {
      found$pythonLiterals <- c(found$pythonLiterals, as.character(expr))
    }
    return(found)
  }
  parts <- as.list(expr)
  fn <- if (is.name(parts[[1]])) as.character(parts[[1]]) else NA_character_
  names <- names(parts)
  for (i in seq_along(parts)[-1]) {
    # `df[, 1]` and `x[[i]]` legitimately carry an empty argument
    if (identical(parts[[i]], quote(expr = ))) {
      if (!is.na(fn) && !fn %in% c("[", "[[")) {
        found$emptyArguments <- c(found$emptyArguments, fn)
      }
      next
    }
    found <- .collectCallProblems(parts[[i]], found, nullReturning)
  }
  if (is.na(fn)) {
    return(found)
  }
  if (!is.null(names)) {
    supplied <- names[-1][nzchar(names[-1])]
    if (length(supplied)) {
      found$namedCalls[[length(found$namedCalls) + 1L]] <-
        list(fn = fn, args = supplied)
    }
  }
  # `x |> f() |> g()` parses to `g(f(x))`, so a piped-in NULL shows up as a
  # nested call in the first argument position
  if (length(parts) > 1 && is.call(parts[[2]]) && is.name(parts[[2]][[1]])) {
    inner <- as.character(parts[[2]][[1]])
    if (inner %in% nullReturning) {
      found$nullPipes <- c(
        found$nullPipes,
        sprintf("%s() into %s()", inner, fn)
      )
    }
  }
  found
}

.vignetteProblems <- function(path, documentedFormals, nullReturning) {
  problems <- character()
  for (chunk in .vignetteChunks(path)) {
    if (!length(chunk$code)) {
      next
    }
    exprs <- tryCatch(
      parse(text = paste(chunk$code, collapse = "\n")),
      error = function(e) NULL
    )
    if (is.null(exprs)) {
      problems <- c(problems, sprintf("L%d: chunk does not parse", chunk$line))
      next
    }
    found <- list(
      namedCalls = list(),
      emptyArguments = character(),
      pythonLiterals = character(),
      nullPipes = character()
    )
    for (expr in exprs) {
      found <- .collectCallProblems(expr, found, nullReturning)
    }
    if (length(found$emptyArguments)) {
      problems <- c(
        problems,
        sprintf(
          "L%d: empty argument passed to %s()",
          chunk$line,
          paste(unique(found$emptyArguments), collapse = ", ")
        )
      )
    }
    if (length(found$pythonLiterals)) {
      problems <- c(
        problems,
        sprintf(
          "L%d: Python literal used as an R symbol: %s",
          chunk$line,
          paste(unique(found$pythonLiterals), collapse = ", ")
        )
      )
    }
    if (length(found$nullPipes)) {
      problems <- c(
        problems,
        sprintf(
          "L%d: pipes a result documented as None: %s",
          chunk$line,
          paste(unique(found$nullPipes), collapse = ", ")
        )
      )
    }
    for (call in found$namedCalls) {
      known <- documentedFormals[[call$fn]]
      if (is.null(known)) {
        next
      }
      undocumented <- setdiff(call$args, known)
      if (length(undocumented)) {
        problems <- c(
          problems,
          sprintf(
            "L%d: %s() has no documented argument(s): %s",
            chunk$line,
            call$fn,
            paste(undocumented, collapse = ", ")
          )
        )
      }
    }
  }
  problems
}

root <- .packageSourceRoot()

# ---------------------------------------------------------------------------
# man/ -- the curated pages that ship to users
# ---------------------------------------------------------------------------

test_that("every curated .Rd example is parseable R", {
  if (is.null(root) || !dir.exists(file.path(root, "man"))) {
    skip("package source man/ directory is not available")
  }
  # `%` opens a comment in Rd everywhere, including inside \examples{}, and
  # \dontrun{} keeps R CMD check from ever parsing the block -- so an
  # unescaped `%` silently truncates the line and the page renders with its
  # examples missing rather than failing the build.
  failures <- character()
  for (file in list.files(
    file.path(root, "man"),
    pattern = "[.]Rd$",
    full.names = TRUE
  )) {
    code <- tryCatch(.exampleCode(file), error = function(e) character())
    if (!length(code)) {
      next
    }
    message <- tryCatch(
      {
        parse(text = paste(code, collapse = "\n"))
        NULL
      },
      error = function(e) sub("\n.*", "", conditionMessage(e))
    )
    if (!is.null(message)) {
      failures <- c(failures, sprintf("%s: %s", file, message))
    }
  }
  expect_equal(character(), failures, info = paste(failures, collapse = "\n"))
})

test_that("every curated .Rd \\usage{} is parseable R", {
  if (is.null(root) || !dir.exists(file.path(root, "man"))) {
    skip("package source man/ directory is not available")
  }
  # Private Python parameters such as `_last_persistent_instance` are not
  # syntactically valid R argument names, so leaving them in the generated
  # signature produces a \usage{} section that cannot be parsed.
  failures <- character()
  for (file in list.files(
    file.path(root, "man"),
    pattern = "[.]Rd$",
    full.names = TRUE
  )) {
    usage <- tryCatch(.rdSection(file, "\\usage"), error = function(e) {
      NA_character_
    })
    if (is.na(usage) || !nzchar(usage)) {
      next
    }
    message <- tryCatch(
      {
        parse(text = usage)
        NULL
      },
      error = function(e) sub("\n.*", "", conditionMessage(e))
    )
    if (!is.null(message)) {
      failures <- c(failures, sprintf("%s: %s", basename(file), message))
    }
  }
  expect_equal(character(), failures)
})

# ---------------------------------------------------------------------------
# vignettes -- the two the translate-rd-python-to-r skill reads as its
# ground-truth reference, so an error in either propagates into new pages
# ---------------------------------------------------------------------------

test_that("reference vignette chunks only use documented arguments and R literals", {
  if (is.null(root) || !dir.exists(file.path(root, "vignettes"))) {
    skip("package source vignettes/ directory is not available")
  }
  docDirs <- Filter(dir.exists, file.path(root, c("man", "auto-man")))
  if (!length(docDirs)) {
    skip("no .Rd directories are available to resolve signatures against")
  }
  documentedFormals <- .documentedFormals(docDirs)
  nullReturning <- .nullReturningFunctions(docDirs)
  # Chunks without eval=FALSE run during the vignette build, so these are all
  # build failures rather than cosmetic issues.
  for (vignette in c("tables.Rmd", "data_upload_download.Rmd")) {
    path <- file.path(root, "vignettes", vignette)
    if (!file.exists(path)) {
      next
    }
    problems <- .vignetteProblems(path, documentedFormals, nullReturning)
    expect_equal(character(), problems, info = vignette)
  }
})

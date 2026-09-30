# One way to run the test is to run the test using devtools::test(filter = "shared")
# from the synapser package directory.

context("test shared filter functions and operations functions")

# ---------------------------------------------------------------------------
# .cherryPickTableFunctionFilter
# ---------------------------------------------------------------------------

test_that(".cherryPickTableFunctionFilter passes through 'build_table'", {
  x <- list(name = "build_table")
  expect_equal(x, .cherryPickTableFunctionFilter(x))
})

test_that(".cherryPickTableFunctionFilter returns NULL for unrecognized names", {
  expect_null(.cherryPickTableFunctionFilter(list(name = "Column")))
  expect_null(.cherryPickTableFunctionFilter(list(name = "EntityView")))
  expect_null(.cherryPickTableFunctionFilter(list(name = "")))
})

# ---------------------------------------------------------------------------
# .removeAllClassesClassFilter
# ---------------------------------------------------------------------------

test_that(".removeAllClassesClassFilter always returns NULL", {
  expect_null(.removeAllClassesClassFilter(list(name = "Synapse")))
  expect_null(.removeAllClassesClassFilter(list(name = "File")))
  expect_null(.removeAllClassesClassFilter(NULL))
})

# ---------------------------------------------------------------------------
# .synapseClassFunctionFilter
# ---------------------------------------------------------------------------

test_that(".synapseClassFunctionFilter passes through included methods", {
  for (methodName in c(
    "login",
    "logout",
    "setEndpoints",
    "sendMessage",
    "rest_get_async",
    "rest_put_async",
    "rest_post_async",
    "rest_delete_async"
  )) {
    x <- list(name = methodName)
    expect_equal(
      x,
      .synapseClassFunctionFilter(x),
      info = paste("should pass through", methodName)
    )
  }
})

test_that(".synapseClassFunctionFilter returns NULL for excluded methods", {
  expect_null(.synapseClassFunctionFilter(list(name = "get")))
  expect_null(.synapseClassFunctionFilter(list(name = "store")))
  expect_null(.synapseClassFunctionFilter(list(name = "some_other_method")))
})

# ---------------------------------------------------------------------------
# .removeAllFunctionsFunctionFilter
# ---------------------------------------------------------------------------

test_that(".removeAllFunctionsFunctionFilter always returns NULL", {
  expect_null(.removeAllFunctionsFunctionFilter(list(name = "get")))
  expect_null(.removeAllFunctionsFunctionFilter(list(name = "login")))
  expect_null(.removeAllFunctionsFunctionFilter(NULL))
})

# ---------------------------------------------------------------------------
# .removeAsyncFunctionFilter
# ---------------------------------------------------------------------------

test_that(".removeAsyncFunctionFilter passes through non-async functions", {
  x <- list(name = "get")
  expect_equal(x, .removeAsyncFunctionFilter(x))
  x2 <- list(name = "store")
  expect_equal(x2, .removeAsyncFunctionFilter(x2))
  x3 <- list(name = "get_async_result") # contains but does not end with _async
  expect_equal(x3, .removeAsyncFunctionFilter(x3))
})

test_that(".removeAsyncFunctionFilter returns NULL for _async-suffixed functions", {
  expect_null(.removeAsyncFunctionFilter(list(name = "get_async")))
  expect_null(.removeAsyncFunctionFilter(list(name = "store_async")))
  expect_null(.removeAsyncFunctionFilter(list(name = "delete_async")))
})

# ---------------------------------------------------------------------------
# .operationsFunctionNamesFilter
# ---------------------------------------------------------------------------

test_that(".operationsFunctionNamesFilter passes through known operations", {
  for (opName in c(
    "get",
    "store",
    "delete",
    "download_list_files",
    "download_list_manifest",
    "download_list_add",
    "download_list_remove",
    "download_list_clear",
    "find_entity_id",
    "is_synapse_id",
    "md5_query",
    "onweb",
    "print_entity"
  )) {
    x <- list(name = opName)
    expect_equal(
      x,
      .operationsFunctionNamesFilter(x),
      info = paste("should pass through", opName)
    )
  }
})

test_that(".operationsFunctionNamesFilter returns NULL for non-operation names", {
  expect_null(.operationsFunctionNamesFilter(list(name = "login")))
  expect_null(.operationsFunctionNamesFilter(list(name = "get_async")))
  expect_null(.operationsFunctionNamesFilter(list(name = "some_function")))
})

# ---------------------------------------------------------------------------
# .synapseModelClassFilter
# ---------------------------------------------------------------------------

test_that(".synapseModelClassFilter returns NULL for classes not in the include list", {
  expect_null(.synapseModelClassFilter(list(
    name = "NotAClass",
    methods = list()
  )))
  expect_null(.synapseModelClassFilter(list(name = "Synapse")))
})

test_that(".synapseModelClassFilter passes through included classes", {
  for (className in c(
    "Project",
    "Folder",
    "File",
    "Table",
    "Activity",
    "Team"
  )) {
    x <- list(name = className, methods = list())
    result <- .synapseModelClassFilter(x)
    expect_false(is.null(result), info = paste("should include", className))
    expect_equal(className, result$name)
  }
})

test_that(".synapseModelClassFilter strips _async methods from included classes", {
  x <- list(
    name = "File",
    methods = list(
      list(name = "from_id"),
      list(name = "from_id_async"),
      list(name = "set_permissions")
    )
  )
  result <- .synapseModelClassFilter(x)
  resultNames <- sapply(result$methods, `[[`, "name")
  expect_true("from_id" %in% resultNames)
  expect_true("set_permissions" %in% resultNames)
  expect_false("from_id_async" %in% resultNames)
})

test_that(".synapseModelClassFilter strips methods in modelClassMethodsToOmit", {
  x <- list(
    name = "File",
    methods = list(
      list(name = "from_id"),
      list(name = "format_for_manifest"),
      list(name = "fill_from_dict"),
      list(name = "to_synapse_request"),
      list(name = "allow_client_caching")
    )
  )
  result <- .synapseModelClassFilter(x)
  resultNames <- sapply(result$methods, `[[`, "name")
  expect_true("from_id" %in% resultNames)
  expect_false("format_for_manifest" %in% resultNames)
  expect_false("fill_from_dict" %in% resultNames)
  expect_false("to_synapse_request" %in% resultNames)
  expect_false("allow_client_caching" %in% resultNames)
})

test_that(".synapseModelClassFilter strips operations function names from class methods", {
  x <- list(
    name = "File",
    methods = list(
      list(name = "from_id"),
      list(name = "get"),
      list(name = "delete"),
      list(name = "my_method")
    )
  )
  result <- .synapseModelClassFilter(x)
  resultNames <- sapply(result$methods, `[[`, "name")
  expect_true("from_id" %in% resultNames)
  expect_true("my_method" %in% resultNames)
  expect_false("get" %in% resultNames)
  expect_false("delete" %in% resultNames)
})

test_that(".synapseModelClassFilter handles class with excluded methods", {
  x <- list(
    name = "File",
    methods = list(list(name = "get"), list(name = "from_id"))
  )
  result <- .synapseModelClassFilter(x)
  expect_equal("File", result$name)
  expect_equal(1L, length(result$methods))
  expect_equal("from_id", result$methods[[1]]$name)
})

test_that(".synapseModelClassFilter returns all methods when none are filtered", {
  x <- list(
    name = "Project",
    methods = list(
      list(name = "from_id"),
      list(name = "my_method")
    )
  )
  result <- .synapseModelClassFilter(x)
  expect_equal(2L, length(result$methods))
})

# ---------------------------------------------------------------------------
# .functionNameMapping
# ---------------------------------------------------------------------------

test_that(".functionNameMappingSynapseclientModels explicit map contains all expected entries", {
  explicit <- .functionNameMappingSynapseclientModels()$explicit
  expect_equal(
    "synDisassociateActivityFromEntity",
    explicit[["synDisassociateFromEntity"]]
  )
  expect_equal("synGetFromPath", explicit[["synFromPath"]])
  expect_equal("synInviteToTeam", explicit[["synInvite"]])
  expect_equal("synGetTeamMembers", explicit[["synMembers"]])
  expect_equal("synGetOpenInvitations", explicit[["synOpenInvitations"]])
})

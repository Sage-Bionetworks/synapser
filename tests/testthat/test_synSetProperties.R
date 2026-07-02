# One way to run the test is using devtools::test(filter = "synSetProperties")
# from the synapser package directory.
context("unit tests for synSetProperties")

# Creates a mock entity environment whose __dataclass_fields__ mirrors a Python dataclass.
mock_entity <- function(...) {
  fields <- list(...)
  e <- list2env(fields)
  e$`__dataclass_fields__` <- setNames(
    vector("list", length(fields)),
    names(fields)
  )
  e
}

# --- Basic behaviour ---

test_that("synSetProperties with no extra args returns entity unchanged", {
  entity <- mock_entity(name = "original")
  result <- synSetProperties(entity)
  expect_equal(result$name, "original")
})

test_that("synSetProperties sets a single property on an entity", {
  entity <- mock_entity(name = "original", annotations = list())
  result <- synSetProperties(entity, name = "updated")
  expect_equal(result$name, "updated")
  expect_equal(result$annotations, list())
})

test_that("synSetProperties sets multiple properties at once", {
  entity <- mock_entity(name = "original", annotations = list())
  result <- synSetProperties(
    entity,
    name = "new name",
    annotations = list(tissue = "brain", n = 42L)
  )
  expect_equal(result$name, "new name")
  expect_equal(result$annotations, list(tissue = "brain", n = 42L))
})

test_that("synSetProperties supports setting a valid property to NULL", {
  entity <- mock_entity(name = "original", annotations = list(a = 1))
  result <- synSetProperties(entity, annotations = NULL)
  expect_true(exists("annotations", envir = result, inherits = FALSE))
  expect_null(result$annotations)
})

test_that("synSetProperties is pipe-friendly", {
  entity <- mock_entity(name = "original")
  result <- entity |> synSetProperties(name = "piped")
  expect_equal(result$name, "piped")
})

# --- Validation errors ---

test_that("synSetProperties errors when an argument is unnamed", {
  entity <- mock_entity()
  expect_error(
    synSetProperties(entity, list(a = 1)),
    "All arguments to synSetProperties must be named, e.g. annotations = list(...)"
  )
})

test_that("synSetProperties errors when arguments are mixed named and unnamed", {
  entity <- mock_entity(name = "original")
  expect_error(
    synSetProperties(entity, "oops", name = "updated"),
    "All arguments to synSetProperties must be named, e.g. annotations = list(...)"
  )
})

test_that("synSetProperties errors on a property not present on the entity", {
  entity <- mock_entity(name = "foo")
  expect_error(
    synSetProperties(
      entity,
      annotations = list(key = "value"),
      description = "new description"
    ),
    "The following are not valid attributes of this entity: annotations, description"
  )
})

test_that("synSetProperties does not partially update when any property is invalid", {
  entity <- mock_entity(name = "original", annotations = list())
  expect_error(
    synSetProperties(entity, name = "updated", notAProp = 123),
    "The following are not valid attributes of this entity: notAProp"
  )
  expect_equal(entity$name, "original")
  expect_equal(entity$annotations, list())
})

test_that("synSetProperties errors when entity dataclass fields are missing", {
  entity <- mock_entity(name = "original")
  rm(list = "__dataclass_fields__", envir = entity)
  expect_error(
    synSetProperties(entity, name = "updated"),
    "The following are not valid attributes of this entity: name"
  )
})

# --- Edge cases ---

test_that("synSetProperties keeps first value for duplicate names via do.call", {
  entity <- mock_entity(name = "original")
  result <- do.call(
    synSetProperties,
    list(entity = entity, name = "first", name = "second")
  )
  expect_equal(result$name, "first")
})

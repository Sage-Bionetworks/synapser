context("test table utilities")

test_that(".saveToCsv() throws error for non-data.frame input", {
  expect_false(is.data.frame(list("a", 1)))
  expect_error(.saveToCsv(list("a", 1), tempfile()))
})

test_that("data.frame can be written to and read from csv consistently", {
  a = c(3.5, NaN, Inf, -Inf, NA)
  b = c("Hello", "World", NA, "!", NA)
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a, b)

  file <- tempfile()
  .saveToCsv(df, file)
  df2 <- .readCsv(file)

  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that("empty data.frame can be written to and read from csv consistently", {
  df <- data.frame()
  expect_equal("data.frame", class(df))

  file <- tempfile()
  cat("some text", file)
  .saveToCsv(df, file)
  df2 <- .readCsv(file)

  expect_equal(df, df2)
})

test_that("Table() takes r data.frame", {
  tableId <- "syn123"
  a = c(3.5, NaN)
  b = c("Hello", "World")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a , b)

  table <- Table(tableId, df)
  df2 <- table$asDataFrame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that("Table() takes an empty r data.frame", {
  tableId <- "syn123"
  df <- data.frame()
  expect_equal("data.frame", class(df))

  table <- Table(tableId, df)
  df2 <- table$asDataFrame()
  expect_is(df2, "data.frame")
  expect_equal(df, df2)
})

test_that("Table() takes a file path", {
  tableId <- "syn123"
  a = c(3.5, NaN)
  b = c("Hello", "World")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a , b)

  temp <- tempfile()
  .saveToCsv(df, temp)
  table <- Table(tableId, temp)
  df2 <- table$asDataFrame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that("as.data.frame works for CsvFileTable", {
  tableId <- "syn123"
  a = c(3.5, NaN)
  b = c("Hello", "World")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a , b)
  
  table <- Table(tableId, df)
  df2 <- table %>% as.data.frame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that(".convertListOfSchemaTypeToRType works for BOOLEAN", {
  list <- c("true", "false", "")
  type <- "BOOLEAN"
  expected <- c(T, F, NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "logical")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for DATE", {
  list <- c("1538005437242", "123042", "")
  type <- "DATE"
  origin <- "1970-01-01"
  
  # The conversion will change millis into seconds
  expected <- c(as.POSIXct(1538005437.242, origin = origin), as.POSIXct(123.042, origin = origin), NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "POSIXct")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for INTEGER", {
  list <- c("1242", "-2482", "")
  type <- "INTEGER"

  expected <- c(1242, -2482, NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "integer")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for STRING", {
  list <- c("42", "24.24", "", "NULL", "NA")
  type <- "STRING"

  expected <- c("42", "24.24", NA, "NULL", "NA")
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for FILEHANDLEID", {
  list <- c("30150852", "")
  type <- "FILEHANDLEID"
  
  expected <- c("30150852", NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for ENTITYID", {
  list <- c("syn30150852", "")
  type <- "ENTITYID"
  
  expected <- c("syn30150852", NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for LINK", {
  # Links are not required to be semantically valid, and are essentially treated the same as STRING
  list <- c("google.com", "yahoo,net.", "", "NULL", "NA")
  type <- "LINK"
  
  expected <- c("42", "24.24", NA, "NULL", "NA")
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for LARGETEXT", {
  # LARGETEXT is essentially treated the same as STRING
  list <- c("Long text", "test", "", "NULL", "NA")
  type <- "LARGETEXT"
  
  expected <- c("Long text", "test", NA, "NULL", "NA")
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for USERID", {
  list <- c("273954", "273950", "")
  type <- "USERID"
  
  expected <- c("273954", "273950", NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSchemaTypeToRType works for DOUBLE", {
  list <- c("3", "900", "")
  type <- "DOUBLE"
  
  expected <- c(3.0, 900.0, NA)
  
  actual <- .convertListOfSchemaTypeToRType(list, type)
  
  expect_is(actual, "numeric")
  expect_equal(expected, actual)
})

test_that("as.data.frame converts tables with a schema to a specific type rather than guessing", {
  tableId <- "syn123"
  origin <- "1970-01-01"
  a = c("T", "F")
  b = c(T, F)
  c = c(as.POSIXct(1538006762.583, origin = origin), as.POSIXct(2942.000, origin = origin))
  d = c(1538006762.583, 2942.000)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_true("POSIXct" %in% class(c))
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)

  cols <- list(
    Column(name = "a", columnType = "STRING", enumValues = list("T", "F"), smaximumSize = 1),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "DOUBLE"))
  
  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  table <- Table(schema, df)
  
  df2 <- table %>% as.data.frame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})
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

test_that(".convertListOfSynapseTypeToRType works for BOOLEAN", {
  list <- c("true", "false", NA)
  type <- "BOOLEAN"
  expected <- c(T, F, NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "logical")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for DATE", {
  list <- c("1538005437242", "123042", NA)
  type <- "DATE"
  origin <- "1970-01-01"
  
  # The conversion will change millis into seconds
  expected <- as.POSIXlt(c(1538005437.242, 123.042, NA), origin = origin, tz="UTC")
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "POSIXlt")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for INTEGER", {
  list <- c("1242", "-2482", NA)
  type <- "INTEGER"

  expected <- c(1242, -2482, NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "integer")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for STRING", {
  list <- c("42", "24.24", NA, "NULL", "NA")
  type <- "STRING"

  expected <- c("42", "24.24", NA, "NULL", "NA")
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for FILEHANDLEID", {
  list <- c("30150852", NA)
  type <- "FILEHANDLEID"
  
  expected <- c("30150852", NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for ENTITYID", {
  list <- c("syn30150852", NA)
  type <- "ENTITYID"
  
  expected <- c("syn30150852", NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for LINK", {
  # Links are not required to be semantically valid, and are essentially treated the same as STRING
  list <- c("google.com", "yahoo,net.", NA, "NULL", "NA")
  type <- "LINK"
  
  expected <- c("google.com", "yahoo,net.", NA, "NULL", "NA")
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for LARGETEXT", {
  # LARGETEXT is essentially treated the same as STRING
  list <- c("Long text", "test", NA, "NULL", "NA")
  type <- "LARGETEXT"
  
  expected <- c("Long text", "test", NA, "NULL", "NA")
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for USERID", {
  list <- c("273954", "273950", NA)
  type <- "USERID"
  
  expected <- c("273954", "273950", NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertListOfSynapseTypeToRType works for DOUBLE", {
  list <- c("3", "900", "")
  type <- "DOUBLE"
  
  expected <- c(3.0, 900.0, NA)
  
  actual <- .convertListOfSynapseTypeToRType(list, type)
  
  expect_is(actual, "numeric")
  expect_equal(expected, actual)
})

test_that(".saveToCsvWithSchema converts tables with a schema to a format accepted by Synapse", {
  tableId <- "syn123"
  origin <- "1970-01-01"
  a = c("Some text", "And more text")
  b = c(T, F)
  c = as.POSIXlt(c(1538006762.583, 2942.000), origin = origin, tz = "UTC")
  d = c(1538006762583, 2942000)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_true("POSIXlt" %in% class(c))
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)

  cols <- list(
    Column(name = "a", columnType = "STRING", enumValues = list("T", "F"), maximumSize = 1),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "DATE"))
  
  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  file <- tempfile()
  .saveToCsvWithSchema(schema, df, file)
  df2 <- .readCsv(file)

  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(as.numeric(c) * 1000, df2$c) # dates that are POSIXt should be converted to timestamp
  expect_equal(d, df2$d) # Dates that are already numeric are assumed to be timestamp and won't be converted
})

# CsvFileTable without schema -> asDataFrame()
test_that("CsvFileTable without a schema does not modify values that would be modified with a schema", {
  tableId <- "syn123"
  origin <- "1970-01-01"
  a = c("T", "F", NA)
  b = c(T, F, NA)
  c = as.POSIXlt(c(1538006762.583, 1538006762.584, 2942.000), origin = origin, tz = "UTC")
  d = c(1538006762583, 1538006762584, 2942000)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_is(c, "POSIXt")
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)
  
  table <- Table(tableId, df)
  
  
  df2 <- table %>% as.data.frame()
  expect_is(df2, "data.frame")
  expect_equal(as.logical(a), df2$a) # R will assume these are logical and coerce
  expect_equal(b, df2$b)
  expect_equal(format(as.POSIXlt(c, origin = origin, tz = "UTC"),"%Y-%m-%d %H:%M:%OS3"), df2$c) # R will read these as character
  expect_equal(d, df2$d) # Timestamps will be converted to dates
  expect_is(df2$d, "numeric") # POSIXct is not precise enough, validate we use POSIXlt
})


# CsvFileTable with schema -> asDataFrame()
test_that("CsvFileTable with a schema is properly converted to appropriate data types for Synapse", {
  tableId <- "syn123"
  origin <- "1970-01-01"
  a = c("T", "F", NA)
  b = c(T, F, NA)
  c = as.POSIXlt(c(1538006762.583, 1538006762.584, 2942.000), origin = origin, tz = "UTC")
  d = c(1538006762583, 1538006762584, 2942000)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_is(c, "POSIXt")
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)
  
  cols <- list(
    Column(name = "a", columnType = "STRING", enumValues = list("T", "F"), maximumSize = 1),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "DATE"))
  
  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  table <- Table(schema, df)
  

  df2 <- table %>% as.data.frame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(c, df2$c)
  expect_equal(as.POSIXlt(d / 1000, origin = origin, tz = "UTC"), df2$d) # Timestamps will be converted to dates
  expect_is(df2$d, "POSIXt") # POSIXct is not precise enough, validate we use POSIXlt
})

# CsvFileTable with schema -> asDataFrame() -> Table(schema, df2)
test_that("", {
  
})

# CsvFileTable with schema -> asDataFrame() -> Table(tableId, df2)


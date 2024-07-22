context("test table utilities")

test_that(".saveToCsv() throws error for non-data.frame input", {
  expect_false(is.data.frame(list("a", 1)))
  expect_error(.saveToCsv(list("a", 1), tempfile()))
})

test_that("data.frame can be written to and read from csv consistently (except dates)", {
  origin <- "1970-01-01"
  a = c(3.5, NaN, Inf, -Inf, NA)
  b = c("Hello", "World", NA, "!", NA)
  c = as.POSIXlt(c(1538422512.542, 1538422512.000, NA, 0, 1.111), origin = origin, tz = "UTC")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  expect_is(c, "POSIXt")
  df <- data.frame(a, b, c)

  file <- tempfile()
  .saveToCsv(df, file)
  df2 <- .readCsv(file)

  expectedC <- as.numeric(c) * 1000 # Dates are converted to timestamp and then formatted in standard notation

  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(expectedC, df2$c)
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
  df2 <- data.frame(table$asDataFrame(rowIdAndVersionInIndex = F))
  
  # convert NaN to NA
  df$a[is.nan(df$a)] <- NA
  df2$a[is.nan(df2$a)] <- NA

  expect_is(df2, "data.frame")
  expect_equal(df, df2)
})

test_that("Table() takes an empty r data.frame", {
  tableId <- "syn123"
  # create an empty dataframe
  columns= c("test_col") 
  df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
  # assign column names
  colnames(df) = columns
  # convert all columns to character columns
  df <- data.frame(lapply(df, as.character), stringsAsFactors = FALSE)
  expect_equal("data.frame", class(df))

  # create a Table object and convert it to dataframe
  table <- Table(tableId, df)
  df2 <- data.frame(table$asDataFrame())
  # convert all columns to character columns
  df2 <- data.frame(lapply(df2, as.character), stringsAsFactors = FALSE)
  expect_is(df2, "data.frame")
  expect_true(all.equal(df, df2, check.attributes=F))
})

test_that("Table() takes a file path", {
  tableId <- "syn123"
  a = c(3.5, NaN)
  b = c("Hello", "World")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a , b)
  # convert all columns to character columns
  df <- data.frame(lapply(df, as.character), stringsAsFactors = FALSE)

  temp <- tempfile()
  .saveToCsv(df, temp)
  table <- Table(tableId, temp)
  df2 <- data.frame(table$asDataFrame())
  # convert all columns to character columns
  df2 <- data.frame(lapply(df2, as.character), stringsAsFactors = FALSE)
  
  expect_is(df2, "data.frame")
  expect_equal(df$a, df2$a)
  expect_equal(df$b, df2$b)
  
})

test_that("as.data.frame works for CsvFileTable", {
  tableId <- "syn123"
  a = c(3.5, NaN)
  b = c("Hello", "World")
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a , b)

  table <- Table(tableId, df)
  df2 <- as.data.frame(table)
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that(".convertPOSIXToCharacterTimestamp converts POSIX to timestamp in ms", {
  origin <- "1970-01-01"
  list <- as.POSIXlt(c(1538005437.242, 123.042, NA), origin = origin, tz = "UTC")

  # The conversion will change POSIX into a character of the numeric value, times 1000 (milliseconds)
  expected <- as.character(c(1538005437242, 123042, NA))

  actual <- .convertPOSIXToCharacterTimestamp(list)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})


test_that(".convertToRType works for BOOLEAN", {
  list <- c("true", "false", NA)
  type <- "BOOLEAN"
  expected <- c(T, F, NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "logical")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for DATE", {
  list <- c("1538005437242", "123042", NA)
  type <- "DATE"
  origin <- "1970-01-01"

  # The conversion will change millis into seconds
  expected <- as.POSIXlt(c(1538005437.242, 123.042, NA), origin = origin, tz="UTC")

  actual <- .convertToRType(list, type)

  expect_is(actual, "POSIXlt")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for INTEGER", {
  list <- c("1242", "-2482", NA)
  type <- "INTEGER"

  expected <- c(1242, -2482, NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "integer")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for INTEGER outside of the bounds of max integer", {
  list <- c(as.character(.Machine$integer.max + 1), "4", NA)
  type <- "INTEGER"

  expected <- c(.Machine$integer.max + 1, 4, NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "numeric")
  expect_false(is(actual, "integer"))
  expect_equal(expected, actual)
})

test_that(".convertToRType works for STRING", {
  list <- c("42", "24.24", NA, "NULL", "NA", "")
  type <- "STRING"

  expected <- c("42", "24.24", NA, "NULL", "NA", "")

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for FILEHANDLEID", {
  list <- c("30150852", NA)
  type <- "FILEHANDLEID"

  expected <- c("30150852", NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for ENTITYID", {
  list <- c("syn30150852", NA)
  type <- "ENTITYID"

  expected <- c("syn30150852", NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for LINK", {
  # Links are not required to be semantically valid, and are essentially treated the same as STRING
  list <- c("google.com", "yahoo,net.", NA, "NULL", "NA")
  type <- "LINK"

  expected <- c("google.com", "yahoo,net.", NA, "NULL", "NA")

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for LARGETEXT", {
  # LARGETEXT is essentially treated the same as STRING
  list <- c("Long text", "test", NA, "NULL", "NA")
  type <- "LARGETEXT"

  expected <- c("Long text", "test", NA, "NULL", "NA")

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for USERID", {
  list <- c("273954", "273950", NA)
  type <- "USERID"

  expected <- c("273954", "273950", NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToRType works for DOUBLE", {
  list <- c("3", "900", "", NA)
  type <- "DOUBLE"

  expected <- c(3.0, 900.0, NA, NA)

  actual <- .convertToRType(list, type)

  expect_is(actual, "numeric")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for BOOLEAN", {
  list <- c("true", "false", NA)
  type <- "BOOLEAN"
  expected <- c(T, F, NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "logical")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for DATE for POSIX", {
  origin <- "1970-01-01"
  list <- as.POSIXlt(c(1538005437.242, 123.042, NA), origin = origin, tz="UTC")
  type <- "DATE"

  # The conversion will change POSIX into a character of the numeric value, times 1000 (milliseconds)
  expected <- trimws(as.numeric(c(1538005437242, 123042, NA)))

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for DATE for numeric", {
  list <- c(1538005437242, 123042, NA)
  type <- "DATE"
  origin <- "1970-01-01"

  # The conversion shouldn't change anything; numeric implies timestamp
  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "numeric")
  expect_equal(list, actual)
})

test_that(".convertToSynapseType works for INTEGER", {
  list <- c("1242", "-2482", NA)
  type <- "INTEGER"

  expected <- c(1242, -2482, NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "integer")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for INTEGER outside of the bounds of max integer", {
  list <- c(as.character(.Machine$integer.max + 1), "4", NA)
  type <- "INTEGER"

  expected <- c(.Machine$integer.max + 1, 4, NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "numeric")
  expect_false(is(actual, "integer"))
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for STRING", {
  list <- c("42", "24.24", NA, "NULL", "NA", "")
  type <- "STRING"

  expected <- c("42", "24.24", NA, "NULL", "NA", "")

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for FILEHANDLEID", {
  list <- c("30150852", NA)
  type <- "FILEHANDLEID"

  expected <- c("30150852", NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for ENTITYID", {
  list <- c("syn30150852", NA)
  type <- "ENTITYID"

  expected <- c("syn30150852", NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for LINK", {
  # Links are not required to be semantically valid, and are essentially treated the same as STRING
  list <- c("google.com", "yahoo,net.", NA, "NULL", "NA")
  type <- "LINK"

  expected <- c("google.com", "yahoo,net.", NA, "NULL", "NA")

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for LARGETEXT", {
  # LARGETEXT is essentially treated the same as STRING
  list <- c("Long text", "test", NA, "NULL", "NA")
  type <- "LARGETEXT"

  expected <- c("Long text", "test", NA, "NULL", "NA")

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for USERID", {
  list <- c("273954", "273950", NA)
  type <- "USERID"

  expected <- c("273954", "273950", NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "character")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType works for DOUBLE", {
  list <- c("3", "900", "", NA)
  type <- "DOUBLE"

  expected <- c(3.0, 900.0, NA, NA)

  actual <- .convertToSynapseType(list, type)

  expect_is(actual, "numeric")
  expect_equal(expected, actual)
})

test_that(".convertToSynapseType and .convertToRType are compatible", {
  booleanTest <- c(T, F, NA)
  integerTest <- c(1, 4, NA, .Machine$integer.max)
  integerTestOverMax <- c(1, 4, NA, .Machine$integer.max + 1)
  posixDateTest <- as.POSIXlt(c(1538422512.435, 4.000, NA), origin = "1970-01-01", tz = "UTC")
  numericDateTest <- c(1538422512435, 4000, NA)
  stringTest <- c("", "A long string", "NA", NA)
  doubleTest <- c(1.53, 4.23, NA, .Machine$integer.max + 5)

  # .convertToRType -> .convertToSynapseType
  expect_equal(booleanTest, .convertToSynapseType(.convertToRType(booleanTest, "BOOLEAN"), "BOOLEAN"))
  expect_equal(integerTest, .convertToSynapseType(.convertToRType(integerTest, "INTEGER"), "INTEGER"))
  expect_equal(integerTestOverMax, .convertToSynapseType(.convertToRType(integerTestOverMax, "INTEGER"), "INTEGER"))
  expect_equal(as.character(numericDateTest), .convertToSynapseType(.convertToRType(numericDateTest, "DATE"), "DATE"))
  expect_equal(stringTest, .convertToSynapseType(.convertToRType(stringTest, "STRING"), "STRING"))
  expect_equal(doubleTest, .convertToSynapseType(.convertToRType(doubleTest, "DOUBLE"), "DOUBLE"))

  # .convertToSynapseType -> .convertToRType
  expect_equal(booleanTest, .convertToRType(.convertToSynapseType(booleanTest, "BOOLEAN"), "BOOLEAN"))
  expect_equal(integerTest, .convertToRType(.convertToSynapseType(integerTest, "INTEGER"), "INTEGER"))
  expect_equal(integerTestOverMax, .convertToRType(.convertToSynapseType(integerTestOverMax, "INTEGER"), "INTEGER"))
  expect_equal(posixDateTest, .convertToRType(.convertToSynapseType(posixDateTest, "DATE"), "DATE"))
  expect_equal(stringTest, .convertToRType(.convertToSynapseType(stringTest, "STRING"), "STRING"))
  expect_equal(doubleTest, .convertToRType(.convertToSynapseType(doubleTest, "DOUBLE"), "DOUBLE"))
})

test_that(".convertToRTypeFromSchema works for a dataframe", {
  origin <- "1970-01-01"
  a <- c("Some text", "And more text")
  b <- c(T, F)
  c <- c(1538006762583, 2942000)
  d <- c(.Machine$integer.max + 1, 0)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_equal("numeric", class(c))
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)

  cols <- list(
    Column(name = "a", columnType = "STRING", enumValues = list("T", "F"), maximumSize = 1),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "INTEGER"))

  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  df2 <- .convertToRTypeFromSchema(df, schema$columns_to_store)

  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(as.POSIXlt(c / 1000, origin = origin, tz = "UTC"), df2$c) # timestamp dates will be converted to POSIX
  expect_equal(d, df2$d)
})

test_that(".convertToSynapseTypeFromSchema works for a dataframe", {
  origin <- "1970-01-01"
  a = c("Some text", "And more text")
  b = c(T, F)
  c = as.POSIXlt(c(1538006762.583, 2942.000), origin = origin, tz = "UTC")
  d <- c(.Machine$integer.max + 1, 0)
  expect_equal("character", class(a))
  expect_equal("logical", class(b))
  expect_is(c, "POSIXt")
  expect_equal("numeric", class(d))
  df <- data.frame(a, b, c, d)

  cols <- list(
    Column(name = "a", columnType = "STRING", enumValues = list("T", "F"), maximumSize = 1),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "INTEGER"))

  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  df2 <- .convertToSynapseTypeFromSchema(df, schema$columns_to_store)

  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(as.character(as.numeric(c) * 1000), df2$c) # timestamp dates will be converted to POSIX
  expect_equal(d, df2$d)
})

test_that(".saveToCsvWithSchema works for empty columns_to_store", {
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

  schema <- Schema(name = "A Test Table", parent = "syn234")

  file <- tempfile()

  .saveToCsvWithSchema(schema, df, file)
  df2 <- .readCsv(file)

  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
  expect_equal(as.numeric(c) * 1000, df2$c) # dates that are POSIXt should be converted to timestamp
  expect_equal(d, df2$d) # Dates that are already numeric are assumed to be timestamp and won't be converted
})

test_that(".saveToCsvWithSchema converts tables with a schema to a format accepted by Synapse", {
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

test_that(".saveToCsvWithSchema writes Integers over R max integer limit without trailing 0", {
  origin <- "1970-01-01"
  a = c(0, -10, .Machine$integer.max + 1)
  expect_equal("numeric", class(a))
  df <- data.frame(a)

  cols <- list(Column(name = "a", columnType = "INTEGER"))

  schema <- Schema(name = "A Test Table", columns = cols, parent = "syn234")
  file <- tempfile()
  .saveToCsvWithSchema(schema, df, file)
  df2 <- .readCsv(file, "character")
  expect_is(df2, "data.frame")
  # Note no trailing 0s in the expected
  expected <- c("0", "-10", as.character(.Machine$integer.max + 1))
  expect_equal(expected, df2$a)
})

test_that("CsvFileTable without a schema does not modify values that would be modified with a schema (except dates)", {
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

  df2 <- as.data.frame(table)
  expect_is(df2, "data.frame")
  # expect_equal(as.logical(a), df2$a) # R will assume these are logical and coerce
  # expect_equal(b, df2$b)
  expect_equal(as.numeric(c) * 1000, df2$c) # R will read these as character
  expect_equal(d, df2$d) # Timestamps will be converted to dates
  expect_is(df2$d, "numeric")
})

test_that("CsvFileTable with a schema is properly converted to appropriate data types for Synapse", {
  origin <- "1970-01-01"
  a = c("T", "F", NA)
  b = c(T, F, NA)
  c = as.POSIXlt(c(1538006762.583, 1538006762.584, 2942.000), origin = origin, tzone = "UTC")
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

  df2 <- as.data.frame(table)
  expect_is(df2, "data.frame")
  # expect_equal(a, df2$a)
  # expect_equal(b, df2$b)
  expect_equal(c, df2$c)
  expect_equal(as.POSIXlt(d / 1000, origin = origin, tzone = "UTC"), df2$d) # Timestamps will be converted to dates
})

test_that("as.data.frame coerces types appropriately when using synBuildTable", {
  tableId <- "syn123"
  origin <- "1970-01-01"
  a = c("Some text", "More text", NA)
  b = as.POSIXlt(c(1538006762.583, 1538006762.584, 2942.000), origin = origin, tz = "UTC")
  c = c(1538006762583, 1538006762584, 2942000)
  expect_equal("character", class(a))
  expect_is(b, "POSIXt")
  expect_equal("numeric", class(c))
  df <- data.frame(a, b, c)

  table <- synBuildTable(tableId, "project", df)

  df2 <- as.data.frame(table)
  expect_is(df2, "data.frame")
  # expect_equal(a, df2$a) # R will assume these are logical and coerce
  # expect_equal(as.numeric(b) * 1000, df2$b) # Timestamps will be converted to dates
  expect_equal(c, df2$c) # These are assumed to be numeric
})

test_that(".extractColumnTypes works on schema columns", {
  cols <- list(
    Column(name = "a", columnType = "STRING"),
    Column(name = "b", columnType = "BOOLEAN"),
    Column(name = "c", columnType = "DATE"),
    Column(name = "d", columnType = "DOUBLE"))

  schema <- Schema(name = "A Test Schema", columns = cols, parent = "syn234")

  types <- .extractColumnTypes(schema$columns_to_store)
  expect_equal(types, c("STRING", "BOOLEAN", "DATE", "DOUBLE"))
})

test_that(".extractColumnNames works on schema columns", {
  cols <- list(
    Column(name = "a", columnType = "STRING", name = "A name"),
    Column(name = "b", columnType = "BOOLEAN", name = "Name 2"),
    Column(name = "c", columnType = "DATE", name = "A third name"),
    Column(name = "d", columnType = "DOUBLE", name = "4"))

  schema <- Schema(name = "A Test Schema", columns = cols, parent = "syn234")

  types <- .extractColumnNames(schema$columns_to_store)
  expect_equal(types, c("A name", "Name 2", "A third name", "4"))
})

test_that(".ensureMetaCols does not modify matched cols", {
  cols <- list(
    Column(name = "int", columnType = "INTEGER"),
    Column(name = "str", columnType = "STRING"))
  schema <- Schema(name = "test", columns = cols, parent = "syn123")
  columnSchema <- schema$columns_to_store
  df <- list(
    int = c(1, 2, 3),
    str = c("a", "b", "c")
  )
  expect_equal(columnSchema, .ensureMetaCols(df, schema$columns_to_store))
})

test_that(".ensureMetaCols adds Table cols", {
  cols <- list(Column(name = "str", columnType = "STRING"))
  schema <- Schema(name = "test", columns = cols, parent = "syn123")
  columnSchema <- schema$columns_to_store
  df <- data.frame(
    ROW_ID = c(1, 2, 3),
    ROW_VERSION = c(1, 2, 3),
    str = c("a", "b", "c")
  )
  columnSchema <- append(columnSchema, dict(.ROW_ID), after = 0)
  columnSchema <- append(columnSchema, dict(.ROW_VERSION), after = 1)
  expect_equal(columnSchema, .ensureMetaCols(df, schema$columns_to_store))
})

test_that(".ensureMetaCols adds View cols", {
  cols <- list(Column(name = "str", columnType = "STRING"))
  schema <- Schema(name = "test", columns = cols, parent = "syn123")
  columnSchema <- schema$columns_to_store
  df <- data.frame(
    ROW_ID = c(1, 2, 3),
    ROW_VERSION = c(1, 2, 3),
    ROW_ETAG = c("x", "y", "z"),
    str = c("a", "b", "c")
  )
  columnSchema <- append(columnSchema, dict(.ROW_ID), after = 0)
  columnSchema <- append(columnSchema, dict(.ROW_VERSION), after = 1)
  columnSchema <- append(columnSchema, dict(.ROW_ETAG), after = 2)
  expect_equal(columnSchema, .ensureMetaCols(df, schema$columns_to_store))
})

test_that(".ensureMetaCols does not add non-metadata cols", {
  cols <- list(Column(name = "str", columnType = "STRING"))
  schema <- Schema(name = "test", columns = cols, parent = "syn123")
  columnSchema <- schema$columns_to_store
  df <- list(
    x = c(1, 2, 3),
    str = c("a", "b", "c")
  )
  expect_equal(columnSchema, .ensureMetaCols(df, schema$columns_to_store))
})


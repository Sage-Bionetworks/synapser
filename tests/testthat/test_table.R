context("test table utilities")

test_that("data.frame can be write to and read from csv consistently", {
  a = c(3.5, NaN, Inf, -Inf, NA)
  b = c("Hello", "World", NA, "!", NA)
  expect_equal("numeric", class(a))
  expect_equal("character", class(b))
  df <- data.frame(a, b)

  file <- tempfile()
  saveToCsv(df, file)
  df2 <- readCsv(file)

  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

test_that("empty data.frame can be write to and read from csv consistently", {
  df <- data.frame()
  expect_equal("data.frame", class(df))

  file <- tempfile()
  saveToCsv(df, file)
  df2 <- readCsv(file)

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
  saveToCsv(df, temp)
  table <- Table(tableId, temp)
  df2 <- table$asDataFrame()
  expect_is(df2, "data.frame")
  expect_equal(a, df2$a)
  expect_equal(b, df2$b)
})

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
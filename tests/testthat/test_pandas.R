context("test pandas")

test_that("pandas is available", {
  PythonEmbedInR::pyImport("pandas")
})

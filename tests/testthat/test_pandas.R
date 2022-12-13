context("test pandas")

test_that("pandas is available", {
  reticulate::py_run_string("import pandas")
})

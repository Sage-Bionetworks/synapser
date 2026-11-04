# One way to run the test is using devtools::test(filter = "poolProvider")
# from the synapser package directory.

context("test pool provider")

test_that("synapser uses Synapse Python Client pool provider for single thread", {
  callback <- function(name, def) {
    setGeneric(name, def)
  }
  reticulate::py_run_string("import sys")
  reticulate::py_eval(sprintf("sys.path.insert(0, '%s')", getwd()))
  reticulate::py_run_string("import testPoolProvider")
  generateRWrappers(
    pyPkg = "testPoolProvider",
    container = "testPoolProvider",
    setGenericCallback = callback
  )

  expect_true(reticulate::py_eval("synapseclient.core.config.single_threaded"))
  expect_error(test(), NA)
})

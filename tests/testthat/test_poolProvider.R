context("test pool provider")

test_that("synapser uses Synapse Python Client pool provider for single thread", {

  callback <- function(name, def) {
    setGeneric(name, def)
  }
  PythonEmbedInR::pyImport("sys")
  PythonEmbedInR::pyExec(sprintf("sys.path.insert(0, '.')"))
  PythonEmbedInR::pyExecp("sys.path")
  PythonEmbedInR::pyImport("testPoolProvider")
  PythonEmbedInR::generateRWrappers(pyPkg = "testPoolProvider",
                                    container = "testPoolProvider",
                                    setGenericCallback = callback)

  test()
})

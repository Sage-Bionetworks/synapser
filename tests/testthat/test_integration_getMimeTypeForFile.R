integrationTestGetEntityByIdExistingFileCache <-
  function()
{
  expect_equal("image/jpeg", synapseClient:::getMimeTypeForFile("foo.jpg"))
  expect_equal("image/jpeg", synapseClient:::getMimeTypeForFile("foo.jpeg"))
  expect_equal("text/html", synapseClient:::getMimeTypeForFile("this.is.a.file.html"))
  expect_equal("application/octet-stream", synapseClient:::getMimeTypeForFile("FileWithoutExtension"))
  expect_equal("application/octet-stream", synapseClient:::getMimeTypeForFile("foo.unrecognizedExtenion"))
  expect_equal("text/x-r", synapseClient:::getMimeTypeForFile("python-copycat.R"))
  expect_equal("text/x-r", synapseClient:::getMimeTypeForFile("PYTHON-COPYCAT.r"))
}
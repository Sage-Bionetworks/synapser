context("test .outputSideeffect")


test_that("no output as a side effect", {
  conn <- textConnection("stdoutContent", open = "w")
  sink(conn)
  file <- Folder(parentId = "syn123456")
  sink()
  close(conn)
  expect_equal(length(stdoutContent), 0)
})

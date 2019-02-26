context("test version-check utilities")

test_that(".simplifyVersion() works for all inputs", {
  expect_error(.simplifyVersion("1.0.0", 0))
  expect_error(.simplifyVersion("1.0.0", 4))
  expect_equal("1", .simplifyVersion("1.0.0", .MAJOR))
  expect_equal("1.0", .simplifyVersion("1.0.0", .MINOR))
  expect_equal("1.0.0", .simplifyVersion("1.0.0", .PATCH))
  expect_equal("1.0.0", .simplifyVersion("1", .PATCH))
})

test_that(".checkForUpdate() does not fail when synapser does not available", {
  # change RAN where synapser is not available
  .RAN <- "https://cran.r-project.org/"
  expect_equal(NULL, .checkForUpdate())
})

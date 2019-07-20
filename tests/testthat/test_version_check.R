context("test version-check utilities")

test_that(".simplifyVersion() works for all inputs", {
  expect_error(.simplifyVersion("1.0.0", NULL))
  expect_error(.simplifyVersion("1.0.0", NA))
  expect_error(.simplifyVersion("1.0.0", 0))
  expect_error(.simplifyVersion("1.0.0", 4))
  expect_equal("1", .simplifyVersion("1.0.0", 1))
  expect_equal("1.0", .simplifyVersion("1.0.0", 2))
  expect_equal("1.0.0", .simplifyVersion("1.0.0", 3))
  expect_equal("1.0.0", .simplifyVersion("1", 3))
})

test_that(".isVersionOutOfDate() works for invalid input", {
  expect_equal(FALSE, .isVersionOutOfDate(NULL, "synapser", 2))
  expect_equal(FALSE, .isVersionOutOfDate("", "synapser", 2))
})

test_that(".isVersionOutOfDate() returns false for package does not appear in info", {
  info <- matrix()
  expect_equal(FALSE, .isVersionOutOfDate(info, "synapser", 2))
  info <- matrix(
    c("PythonEmbedInR", "/Library/Frameworks/R.framework/Versions/3.5/Resources/library",
      "0.0.0", "3.5.1", "0.5.45", "http://ran.synapse.org/src/contrib"), 
    nrow = 1,
    dimnames = list(
      c("PythonEmbedInR"),
      c("Package", "LibPath", "Installed", "Built", "ReposVer", "Repository")))
  expect_equal(FALSE, .isVersionOutOfDate(info, "synapser", package_version("0.5.20"), 2))
})

test_that(".isVersionOutOfDate() returns false for package that is not out of date", {
  info <- matrix(
    c("synapser", "/Library/Frameworks/R.framework/Versions/3.5/Resources/library",
      "0.5.20", "3.5.1", "0.5.45", "http://ran.synapse.org/src/contrib"), 
    nrow = 1,
    dimnames = list(
      c("synapser"),
      c("Package", "LibPath", "Installed", "Built", "ReposVer", "Repository")))
  expect_equal(FALSE, .isVersionOutOfDate(info, "synapser", package_version("0.5.20"), 2))
})

test_that(".isVersionOutOfDate() returns true for package that is out of date", {
  info <- matrix(
    c("synapser", "/Library/Frameworks/R.framework/Versions/3.5/Resources/library",
      "0.4.40", "3.5.1", "0.5.45", "http://ran.synapse.org/src/contrib"), 
    nrow = 1,
    dimnames = list(
      c("synapser"),
      c("Package", "LibPath", "Installed", "Built", "ReposVer", "Repository")))
  expect_equal(TRUE, .isVersionOutOfDate(info, "synapser", package_version("0.4.40"), 2))
})

test_that(".isVersionOutOfDate() handles edge case in string comparison", {
  info <- matrix(
    c("synapser", "/Library/Frameworks/R.framework/Versions/3.5/Resources/library",
      "0.4.40", "3.5.1", "0.10.0", "http://ran.synapse.org/src/contrib"), 
    nrow = 1,
    dimnames = list(
      c("synapser"),
      c("Package", "LibPath", "Installed", "Built", "ReposVer", "Repository")))
  expect_equal(TRUE, .isVersionOutOfDate(info, "synapser", package_version("0.4.40"), 2))
})

test_that(".checkForUpdate() does not fail when synapser does not available", {
  expect_equal(NULL, .checkForUpdate(ran = "https://cran.r-project.org/"))
})

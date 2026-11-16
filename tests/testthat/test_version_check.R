# One way to run the test is to run the test using devtools::test(filter = "version_check")
# from the synapser package directory.

context("test version-check utilities")

# build a one-row matrix shaped like old.packages() output
make_info <- function(installed, repos_ver, package = "synapser") {
  matrix(
    c(
      package,
      "/Library/Frameworks/R.framework/Versions/3.5/Resources/library",
      installed,
      "3.5.1",
      repos_ver,
      "https://sage-bionetworks.r-universe.dev/src/contrib"
    ),
    nrow = 1,
    dimnames = list(
      c(package),
      c("Package", "LibPath", "Installed", "Built", "ReposVer", "Repository")
    )
  )
}

test_that(".simplifyVersion() works for all inputs", {
  expect_error(.simplifyVersion("1.0.0", NULL), "Invalid precision")
  expect_error(.simplifyVersion("1.0.0", NA), "Invalid precision")
  expect_error(.simplifyVersion("1.0.0", 0), "Invalid precision")
  expect_error(.simplifyVersion("1.0.0", 4), "Invalid precision")
  expect_error(.simplifyVersion("1.0.0", c(1, 2)), "Invalid precision")
  expect_equal("1", .simplifyVersion("1.0.0", 1))
  expect_equal("1.0", .simplifyVersion("1.0.0", 2))
  expect_equal("1.0.0", .simplifyVersion("1.0.0", 3))
  expect_equal("1.0.0", .simplifyVersion("1", 3))
  expect_equal("1.2.0", .simplifyVersion("1.2", 3))
  expect_equal("0.5", .simplifyVersion("0.5.20.9000", 2))
})

test_that(".isVersionOutOfDate() works for invalid input", {
  expect_equal(
    FALSE,
    .isVersionOutOfDate(NULL, "synapser", package_version("1.0.0"), 2)
  )
  expect_equal(
    FALSE,
    .isVersionOutOfDate("", "synapser", package_version("1.0.0"), 2)
  )
})

test_that(".isVersionOutOfDate() returns false when package is not in old.packages() output", {
  info <- make_info("1.0.0", "2.0.0", package = "otherpkg")
  expect_equal(
    FALSE,
    .isVersionOutOfDate(info, "synapser", package_version("1.0.0"), 2)
  )
})

test_that(".isVersionOutOfDate() ignores patch-only differences at minor precision", {
  info <- make_info("0.5.20", "0.5.45")
  expect_equal(
    FALSE,
    .isVersionOutOfDate(info, "synapser", package_version("0.5.20"), 2)
  )
})

test_that(".isVersionOutOfDate() detects patch-only differences at patch precision", {
  info <- make_info("0.5.20", "0.5.45")
  expect_equal(
    TRUE,
    .isVersionOutOfDate(info, "synapser", package_version("0.5.20"), 3)
  )
})

test_that(".isVersionOutOfDate() returns true for package that is out of date", {
  info <- make_info("0.4.40", "0.5.45")
  expect_equal(
    TRUE,
    .isVersionOutOfDate(info, "synapser", package_version("0.4.40"), 2)
  )
})

test_that(".isVersionOutOfDate() handles edge case in string comparison", {
  info <- make_info("0.4.40", "0.10.0")
  expect_equal(
    TRUE,
    .isVersionOutOfDate(info, "synapser", package_version("0.4.40"), 2)
  )
})

test_that(".isVersionOutOfDate() returns false when installed version is newer than repo", {
  info <- make_info("0.6.0.9000", "0.5.45")
  expect_equal(
    FALSE,
    .isVersionOutOfDate(info, "synapser", package_version("0.6.0.9000"), 2)
  )
})

test_that(".printVersionOutOfDateWarnings() includes versions and install command", {
  repo <- "https://sage-bionetworks.r-universe.dev"
  expect_message(
    .printVersionOutOfDateWarnings("0.4.40", "0.5.45", "synapser", repo),
    "You are using synapser version 0.4.40"
  )
  expect_message(
    .printVersionOutOfDateWarnings("0.4.40", "0.5.45", "synapser", repo),
    "synapser version 0.5.45 is detected at https://sage-bionetworks.r-universe.dev"
  )
  expect_message(
    .printVersionOutOfDateWarnings("0.4.40", "0.5.45", "synapser", repo),
    "install.packages(\"synapser\"",
    fixed = TRUE
  )
})

test_that(".checkForUpdate() prints a message when package is out of date", {
  local_mocked_bindings(
    old.packages = function(...) make_info("0.4.40", "0.5.45"),
    packageVersion = function(...) package_version("0.4.40")
  )
  expect_message(.checkForUpdate(), "New synapser version detected")
})

test_that(".checkForUpdate() is silent when package is up to date", {
  local_mocked_bindings(
    old.packages = function(...) make_info("0.5.20", "0.5.45"),
    packageVersion = function(...) package_version("0.5.20")
  )
  expect_silent(.checkForUpdate())
})

test_that(".checkForUpdate() does not fail when synapser is not available in repo", {
  skip_if_offline()
  expect_equal(NULL, .checkForUpdate(repo = "https://cran.r-project.org/"))
})

test_that(".checkForUpdate does not warn when can't access repo", {
  # If repo is inaccessible for whatever reason, .checkForUpdate() should
  # silently return NULL. This prevents warning messages from appearing when
  # loading synapser without an internet connection.
  expect_silent(.checkForUpdate(repo = ""))
  expect_null(.checkForUpdate(repo = ""))
})

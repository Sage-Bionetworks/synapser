context("test determineArgsAndKwArgs")


test_that("no arguments", {
	expect_equal(determineArgsAndKwArgs(), list(args=list(), kwargs=list()))
})

test_that("unnamed arguments", {
	expect_equal(determineArgsAndKwArgs("foo", "bar"), list(args=list("foo", "bar"), kwargs=list()))
})

test_that("unnamed arguments, followed by named argument", {
	expect_equal(determineArgsAndKwArgs("foo", "bar", x="baz"), list(args=list("foo", "bar"), kwargs=list(x="baz")))
})

test_that("only named argument", {
	expect_equal(determineArgsAndKwArgs(a="foo", b="bar", c="baz"), list(args=list(), kwargs=list(a="foo", b="bar", c="baz")))
})

test_that("unnamed NULL argument", {
	expect_equal(determineArgsAndKwArgs(NULL), list(args=list(NULL), kwargs=list()))
})

test_that("unnamed arguments with NULL", {
	expect_equal(determineArgsAndKwArgs("foo", NULL), list(args=list("foo", NULL), kwargs=list()))
})

test_that("named arguments with NULL", {
	expect_equal(determineArgsAndKwArgs(a="foo", b=NULL, c="baz"), list(args=list(), kwargs=list(a="foo", b=NULL, c="baz")))
})

test_that("unnamed arguments after named ones trigger an error", {
	expect_error(determineArgsAndKwArgs(foo="bar", "baz"))
})



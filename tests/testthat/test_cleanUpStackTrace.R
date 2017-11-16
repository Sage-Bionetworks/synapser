context("test cleanUpStackTrace")

createError<-function(x) {
	cat(sprintf("exception-message-boundaryEncountered an error %s\nexception-message-boundary", x))
	stop()
}

test_that("cleanUpStackTrace", {
	tryCatch(
		{
			.cleanUpStackTrace(createError, list(x=123))
			fail("Error expected")
		},
		error=function(e) {
			expect_equal(e[[1]], "Encountered an error 123")
		}
	)
})

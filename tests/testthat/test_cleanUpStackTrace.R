context("test cleanUpStackTrace")

createErrorNonWin<-function(x) {
	cat(sprintf("exception-message-boundaryEncountered an error %s\nexception-message-boundary", x))
	stop("irrelevant text")
}

test_that("cleanUpStackTrace NonWin", {
	tryCatch(
		{
			.cleanUpStackTrace(createErrorNonWin, list(x=123))
			fail("Error expected")
		},
		error=function(e) {
			expect_equal(e[[1]], "Encountered an error 123\n")
		}
	)
})

# On Windows the error goes into the error message rather than to stdout
createErrorWin<-function(x) {
	cat("irrelevant text")
	stop(sprintf("exception-message-boundaryEncountered an error %s\nexception-message-boundary", x))
}


test_that("cleanUpStackTrace", {
	tryCatch(
		{
			.cleanUpStackTrace(createErrorWin, list(x=123))
			fail("Error expected")
		},
		error=function(e) {
			expect_equal(e[[1]], "Encountered an error 123\n")
		}
	)
})

test_that("multiple parallel calls work", {
	conn<-textConnection("outputCapture", open="w")
	writeLines("this is a test", conn)

	tryCatch(
		{
			.cleanUpStackTrace(function(x){x}, list(x=123))
		},
		finally = {
			close(conn)
		}
	)
})

## Unit test fileNameFromHeaders
## 
## 
###############################################################################



unitTestMissingFileName <-function() {
	headers<-"Content-Type: text/html; charset=UTF-8\r\nDate: Sat, 28 Mar 2015 19:43:25 GMT\r\nExpires: Mon, 27 Apr 2015 19:43:25 GMT"
	checkTrue(is.null(synapseClient:::fileNameFromHeaders(headers)))
}

unitTestHappyCase <- function() {
	headers<-"x-amz-id-2: +iB0K6cFV3I1eUO7YIGJlF3Wn7GVxLKZEPsO1dbo5DYzwwo0lBVBlCqKV4W8S4w5\r\nx-amz-request-id: A2EA02790F1D642A\r\nDate: Thu, 26 Mar 2015 17:11:54 GMT\r\nContent-Disposition: attachment; filename=file7697fb85a1e.rbin\r\nLast-Modified: Tue, 13 Jan 2015 02:03:02 GMT\r\n"
	checkEquals(synapseClient:::fileNameFromHeaders(headers), "file7697fb85a1e.rbin")
}

unitTestWrongHeaderName <- function() {
	headers<-"x-amz-id-2: +iB0K6cFV3I1eUO7YIGJlF3Wn7GVxLKZEPsO1dbo5DYzwwo0lBVBlCqKV4W8S4w5\r\nx-amz-request-id: A2EA02790F1D642A\r\nDate: Thu, 26 Mar 2015 17:11:54 GMT\r\nNOT-Content-Disposition: attachment; filename=file7697fb85a1e.rbin\r\nLast-Modified: Tue, 13 Jan 2015 02:03:02 GMT\r\n"
	checkTrue(is.null(synapseClient:::fileNameFromHeaders(headers)))
}



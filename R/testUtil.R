# Utilities that are used in the 'testthat'-based tests
# 
# Author: bhoff
###############################################################################


# This adapts RUnit style tests to be run by testThat
runTests<-function(ls) {
	setUpExists<-FALSE
	tearDownExists<-FALSE
	for (x in ls) {
		if (x==".setUp") setUpExists<-TRUE
		if (x==".tearDown") tearDownExists<-TRUE
	}
	for (x in ls) {
		message(x)
		if (x==".setUp") next
		if (x==".tearDown") next
		if (!startsWith(x, "unitTest") && !startsWith(x, "integrationTest")) next
		# TODO is it a function?
		# TODO set up / tear down
		message("about to call ", x)
		eval(call(x))
	}
	
}

startsWith<-function(str, prefix) {
	i <-pracma::strfind(str, prefix)
	!is.null(i) && i==1
}
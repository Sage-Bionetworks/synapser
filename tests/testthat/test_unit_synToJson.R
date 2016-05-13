# unit tests for synToJson.R
# 
# Author: brucehoff
###############################################################################

library("rjson")

unitTest_SynToJsonWithNAs<-function() {
	orig<-list(foo="bar", baz=NA, bar=list(a="A",b=NA))
	expected<-list(foo="bar", bar=list(a="A"))
	expect_equal(synapseClient:::synToJson(orig), toJSON(expected))
}

unitTest_UnnamedElements<-function() {
	orig<-list(foo=list("foo", "bar", "baz"))
	expect_equal(synapseClient:::synToJson(orig), toJSON(orig))
}

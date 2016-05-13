
# 
# Author: brucehoff
###############################################################################



unitTestGetEffectivePropertySchemas<-function() {
  # this schema implements *two* interfaces
  schemaName<-"org.sagebionetworks.repo.model.file.S3FileHandle"
  eps<-synapseClient:::getEffectivePropertySchemas(schemaName, synapseClient:::getSchemaPath())
  expect_true(any(names(eps)=="previewId"))
  expect_true(any(names(eps)=="id"))
}

unitTest_ProblemString <- function() {
  require(rjson)
  problemString <- "{\"foo\":\"b\\ar\"}"
  expected <- "b\ar"
  expect_equal(synapseClient:::synFromJson(problemString)$foo, expected)
   expect_error(fromJSON(problemString))
}

unitTest_synFromJson<-function() {
	expect_equal(list(foo="bar"), synapseClient:::synFromJson("{\"foo\":\"bar\"}"))
	expect_equal(list(foo="/bar"), synapseClient:::synFromJson("{\"foo\":\"\\/bar\"}"))
}

runTests(ls())
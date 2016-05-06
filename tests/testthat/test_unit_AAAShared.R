
# 
# Author: brucehoff
###############################################################################



unitTestGetEffectivePropertySchemas<-function() {
  # this schema implements *two* interfaces
  schemaName<-"org.sagebionetworks.repo.model.file.S3FileHandle"
  eps<-synapseClient:::getEffectivePropertySchemas(schemaName, synapseClient:::getSchemaPath())
  checkTrue(any(names(eps)=="previewId"))
  checkTrue(any(names(eps)=="id"))
}

unitTest_ProblemString <- function(){
  require(rjson)
  problemString <- "{\"foo\":\"b\\ar\"}"
  expected <- "b\ar"
  checkEquals(synapseClient:::synFromJson(problemString)$foo, expected)
  checkException(fromJSON(problemString))
}

unitTest_synFromJson<-function() {
	checkEquals(list(foo="bar"), synapseClient:::synFromJson("{\"foo\":\"bar\"}"))
	checkEquals(list(foo="/bar"), synapseClient:::synFromJson("{\"foo\":\"\\/bar\"}"))
}

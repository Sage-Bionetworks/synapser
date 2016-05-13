# Unit tests for UsedListEntiry
# 
# Author: brucehoff
###############################################################################


unitTestUsedListEntry<-function() {
	usedEntry<-synapseClient:::usedListEntry(list(entity="syn123456", wasExecuted=T))
	expect_true(usedEntry$wasExecuted)
	expect_equal("org.sagebionetworks.repo.model.provenance.UsedEntity", usedEntry$concreteType)
	expect_equal("syn123456", usedEntry$reference$targetId)
	
	usedEntry<-synapseClient:::usedListEntry(list(url="http://foo.bar", wasExecuted=F))
	expect_true(!usedEntry$wasExecuted)
	expect_equal("org.sagebionetworks.repo.model.provenance.UsedURL", usedEntry$concreteType)
	expect_equal("http://foo.bar", usedEntry$url)
	expect_equal("http://foo.bar", usedEntry$name)
	
}

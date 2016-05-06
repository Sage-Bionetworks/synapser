# Unit tests for UsedListEntiry
# 
# Author: brucehoff
###############################################################################


unitTestUsedListEntry<-function() {
	usedEntry<-synapseClient:::usedListEntry(list(entity="syn123456", wasExecuted=T))
	checkTrue(usedEntry$wasExecuted)
	checkEquals("org.sagebionetworks.repo.model.provenance.UsedEntity", usedEntry$concreteType)
	checkEquals("syn123456", usedEntry$reference$targetId)
	
	usedEntry<-synapseClient:::usedListEntry(list(url="http://foo.bar", wasExecuted=F))
	checkTrue(!usedEntry$wasExecuted)
	checkEquals("org.sagebionetworks.repo.model.provenance.UsedURL", usedEntry$concreteType)
	checkEquals("http://foo.bar", usedEntry$url)
	checkEquals("http://foo.bar", usedEntry$name)
	
}

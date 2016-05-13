# These are testActivity tests
###############################################################################

.setUp <-
  function()
  {
    synapseClient:::.setCache("oldWarn", options("warn")[[1]])
    options(warn=2L)
  }

.tearDown <-
  function()
  {
    options(warn = synapseClient:::.getCache("oldWarn"))
    if(!is.null(name <- synapseClient:::.getCache("detachMe"))){
      detach(name)
      synapseClient:::.deleteCache('detachMe')
    }
  }
  
  
unitTestUsedAndExecuted<-function() {
  # test setting and retrieving 'used' entities on an activity
  a<-Activity()
  expect_equal(list(), used(a))
  used(a)<-list("syn101")
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  # test setting and retrieving 'executed' entities on an activity
  executed(a)<-list("syn202", "http://my.favorite.site.com")
  # should not appear in used list
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  expect_equal(list(
      list(reference=list(targetId="syn202"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(url="http://my.favorite.site.com", name="http://my.favorite.site.com", wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedURL")), executed(a)) 
  
  # test setting and retrieving used and executed if they are passed as vectors rather than lists
  #		and test both single and multiple entitites
  a<-Activity()
  used(a)<-"syn101"
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  # test setting and retrieving 'executed' entities on an activity
  executed(a)<-c("syn202", "http://my.favorite.site.com")
  # should not appear in used list
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  expect_equal(list(
      list(reference=list(targetId="syn202"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(url="http://my.favorite.site.com", name="http://my.favorite.site.com", wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedURL")), executed(a)) 
  
  # test used<-, executed<- using a single/multiple Entity(ies) as the argument(s)
  a<-Activity()
  entity<-Folder(id="syn987", parentId="syn000")
  used(a)<-entity
  expect_equal(list(list(reference=list(targetId="syn987"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  executed(a)<-entity
  expect_equal(list(list(reference=list(targetId="syn987"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), executed(a))
  
  entity2<-Folder(id="syn654", parentId="syn000")
  used(a)<-c(entity, entity2)
  expect_equal(list(
      list(reference=list(targetId="syn987"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(reference=list(targetId="syn654"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a)) 
  
  executed(a)<-c(entity, entity2)
  expect_equal(list(
      list(reference=list(targetId="syn987"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(reference=list(targetId="syn654"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), executed(a)) 
  
  # TODO test $ accessor for getting and setting

  # test setting and retrieving 'used' entities on an activity
  a<-Activity()
  expect_equal(list(), a$used)
  a$used<-list("syn101")
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used)
  # test setting and retrieving 'executed' entities on an activity
  a$executed<-list("syn202", "http://my.favorite.site.com")
  # should not appear in used list
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used)
  expect_equal(list(
      list(reference=list(targetId="syn202"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(url="http://my.favorite.site.com", name="http://my.favorite.site.com", wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedURL")), a$executed) 
  
  # test setting and retrieving used and executed if they are passed as vectors rather than lists
  #		and test both single and multiple entitites
  a<-Activity()
  a$used<-"syn101"
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used)
  # test setting and retrieving 'executed' entities on an activity
  a$executed<-c("syn202", "http://my.favorite.site.com")
  # should not appear in used list
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used)
  expect_equal(list(
      list(reference=list(targetId="syn202"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(url="http://my.favorite.site.com", name="http://my.favorite.site.com", wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedURL")), a$executed) 
  
  # test used<-, executed<- using a single/multiple Entity(ies) as the argument(s)
  a<-Activity()
  entity<-Folder(id="syn987", parentId="syn000")
  a$used<-entity
  expect_equal(list(list(reference=list(targetId="syn987"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used)
  a$executed<-entity
  expect_equal(list(list(reference=list(targetId="syn987"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$executed)
  
  entity2<-Folder(id="syn654", parentId="syn000")
  a$used<-c(entity, entity2)
  expect_equal(list(
      list(reference=list(targetId="syn987"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(reference=list(targetId="syn654"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$used) 
  
  a$executed<-c(entity, entity2)
  expect_equal(list(
      list(reference=list(targetId="syn987"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity"),
      list(reference=list(targetId="syn654"), wasExecuted=TRUE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), a$executed) 

}


unitTestShowActivity <- function(){
  
  ## CREATE AN EMPTY ACTIVITY AND MAKE SURE THAT IT RENDERS
  act <- Activity()
  act
  
  ## USING NEW METHODS FOR SETTING USED AND EXECUTED
  act$used <- "syn123"
  act$executed <- "syn456"
  act
  
  act <- Activity()
  used(act) <- "syn123"
  executed(act) <- "syn456"
  act
  
  ## CREATE AN ACTIVITY WITH A NAME BUT NOTHING USED
  act <- Activity(name="Sweet")
  act
  
  ## CREATE AN ACTIVITY THAT USES SOMETHING - SYNAPSE ID ONLY
  act <- Activity(name="Sweet", used=list(list(entity="syn1234", wasExecuted=F)))
  act
  
  ## CREATE AN ACTIVITY THAT USES SOMETHING executed and something non-executed - SYNAPSE ID ONLY
  act <- Activity(name="Sweet", used="syn1234", executed="syn1234")
  act
  
  ## CREATE AN ACTIVITY THAT USES SOMETHING - SYNAPSE ID AND A url
  act <- Activity(name="Sweet", used=list(list(entity="syn1234", wasExecuted=F),
                                          list(url="https://www.synapse.org", wasExecuted=T)))
  act

  ## CREATE AN ACTIVITY THAT USES SOMETHING  executed and something non-executed - SYNAPSE ID AND A url
  act <- Activity(name="Sweet", used=list(entity="syn1234"),
      executed=list(url="https://www.synapse.org"))
  act
  
}

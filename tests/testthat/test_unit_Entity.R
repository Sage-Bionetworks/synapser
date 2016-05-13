## Unit tests for Entity S4 classes
## 
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################


unitTestConstructors <-
  function()
{
  ## these just need to work without throwing an exception. the JSON parsing and mapping to
  ## slots is tested elsewhere
  suppressWarnings(entity <- synapseClient:::Entity(entity = as.list(synapseClient:::synFromJson("{\"name\":\"Mouse Cultured Bone marrow derived Macrophage\",\"description\":\"A powerful way to identify genes for complex traits it to combine genetic and genomic methods. Many trait quantitative trait loci (QTLs) for complex traits are sex specific, but the reason for this is not well understood. RNA was prepared from bone marrow derived macrophages of 93 female and 114 male F(2) mice derived from a strain intercross between apoE-deficient mice on the AKR and DBA/2 genetic backgrounds, and was subjected to transcriptome profiling using microarrays. A high density genome scan was performed using a mouse SNP chip, and expression QTLs (eQTLs) were located for expressed transcripts. Using suggestive and significant LOD score cutoffs of 3.0 and 4.3, respectively, thousands of eQTLs in the female and male cohorts were identified. At the suggestive LOD threshold the majority of the eQTLs were trans eQTLs, mapping unlinked to the position of the gene. Cis eQTLs, which mapped to the location of the gene, had much higher LOD scores than trans eQTLs, indicating their more direct effect on gene expression. The majority of cis eQTLs were common to both males and females, but only approximately 1% of the trans eQTLs were shared by both sexes. At the significant LOD threshold, the majority of eQTLs were cis eQTLs, which were mostly sex-shared, while the trans eQTLs were overwhelmingly sex-specific. Pooling the male and female data, 31% of expressed transcripts were expressed at different levels in males vs. females after correction for multiple testing.These studies demonstrate a large sex effect on gene expression and trans regulation, under conditions where male and female derived cells were cultured ex vivo and thus without the influence of endogenous sex steroids. These data suggest that eQTL data from male and female mice should be analyzed separately, as many effects, such as trans regulation are sex specific. \"}"))))
}

unitTestProperties <-
  function()
{
  ## test property getters and setters
  entity <- new(Class="Entity")
  
  ## all other property types
  propertyValue(entity,"name") <- "string"

  expect_equal(propertyValue(entity,"name"), "string")
 }
 
 unitTestProjectProperties <- function() {
	 project<-Project()
	 propertyValue(project, "alias")<-"alias"
 }
 

unitTestAnnotations <-
  function()
{
  entity <- new(Class="Entity")
  
  ## date valued property
  dd <- Sys.Date()
  annotValue(entity,"date") <- dd
  
  ## POSIXct date valued property
  dd2 <- Sys.time()
  annotValue(entity, "date2") <- dd2
  
  ## POSIXlt date valued property
  dd3 <- as.POSIXlt(Sys.time())
  annotValue(entity, "date3") <- dd3
  
  ## all other property types
  annotValue(entity,"string") <- "string"
  annotValue(entity,"long") <- 1L
  annotValue(entity,"double") <- 2.0
  
  ## check that annotValue returns the proper types and values
  expect_true(difftime(annotValue(entity,"date"), dd, units="secs") < 1)
  expect_true("POSIXct" %in% as.character(class(annotValue(entity, "date"))))
  expect_true(difftime(annotValue(entity,"date2"), dd2, units="secs") < 1)
  expect_true("POSIXct" %in% as.character(class(annotValue(entity, "date2"))))
  expect_true(difftime(annotValue(entity,"date3"), dd3, units="secs") < 1)
  expect_true("POSIXct" %in% as.character(class(annotValue(entity, "date3"))))
  
  
  expect_equal(annotValue(entity,"string"), "string")
  expect_equal(as.character(class(annotValue(entity, "string"))), "character")
  expect_equal(annotValue(entity,"long"), 1L)
  expect_equal(as.character(class(annotValue(entity, "long"))), "integer")
  expect_equal(annotValue(entity,"double"), 2.0)
  expect_equal(as.character(class(annotValue(entity, "double"))), "numeric")
}

unitTestSingleVectorAnnotation <-
  function()
{
  entity <- new(Class="Entity")
  annotValue(entity, "specialNums") <- c(2.71828, 3.14159, 1.618034)

  vals <- annotations(entity)
  expect_equal(vals$specialNums, c(2.71828, 3.14159, 1.618034))
}

unitTestVectorAnnotations <-
  function()
{
  entity <- new(Class="Entity")
  annotValue(entity, "ponies") <- c("Alice", "Sunflower Hot-air-balloon", "Star Butterfly", "Jewel")
  annotValue(entity, "bottlesOfBeerOnTheWall") <- 99L
  annotValue(entity, "specialNums") <- c(2.71828, 3.14159, 1.618034)

  vals <- annotations(entity)
  expect_equal(vals$ponies, c("Alice", "Sunflower Hot-air-balloon", "Star Butterfly", "Jewel"))
  expect_equal(vals$bottlesOfBeerOnTheWall, 99)
  expect_equal(vals$specialNums, c(2.71828, 3.14159, 1.618034))
}

unitTestListSetters <-
  function()
{
  entity <- new(Class="Entity")
  
  dd <- Sys.time()
  annotationValues(entity) <- list(
    date = dd,
    string = "string",
    long = 1L,
    double = 2.0
  )
  ## need to fix the timezone
  ##expect_equal(annotValue(entity,"date"), dd)
  expect_true(difftime(entity$annotations$date, dd, units = "sec") < 1L)
  expect_true("POSIXct" %in% class(annotValue(entity, "date")))
  expect_equal(annotValue(entity,"string"), "string")
  expect_equal(annotValue(entity,"long"), 1L)
  expect_equal(annotValue(entity,"double"), 2.0)
}


unitTestSetPropertiesDollarSignAccessor <-
  function()
{
  entity <- new(Class = "Entity")
  dd <- Sys.time()
  ##entity$properties$date <- dd
  entity$properties$name <- "string"
  ##entity$properties$long <- 1L
  ##entity$properties$double <- 2.1
  
  ##expect_true(difftime(entity$properties$date, dd, units = "sec") < 1L)
  ##expect_true("POSIXct" %in% class(entity$properties$date))
  expect_equal(entity$properties$name, "string")
  ##expect_equal(entity$properties$long, 1L)
  ##expect_equal(entity$properties$double, 2.1)
}

unitTestSetAnnotationsDollarSignAccessor <-
  function()
{
 entity <- new(Class = "Entity")
 dd <- Sys.time()
 annotationValues(entity) <- list(
   date = dd,
   string = "string",
   long = 1L,
   double = 2.0
 )
 
 expect_true(difftime(entity$annotations$date, dd, units = "sec") < 1L)
 expect_true("POSIXct" %in% class(annotValue(entity, "date")))
 expect_equal(entity$annotations$string, "string")
 expect_equal(entity$annotations$long, 1L)
 expect_equal(entity$annotations$double, 2.0)
 
}

unitTestSetAnnotationsDollarSignAccessorReplace <-
  function()
{
   entity <- new(Class = "Entity")
   dd <- Sys.time()
   entity$annotations$date <- dd
   entity$annotations$string <- "string"
   entity$annotations$long <- 1L
   entity$annotations$double <- 2.0

   expect_true(difftime(entity$annotations$date, dd, units = "sec") < 1L)
   expect_true("POSIXct" %in% class(annotValue(entity, "date")))
   expect_equal(entity$annotations$string, "string")
   expect_equal(entity$annotations$long, 1L)
   expect_equal(entity$annotations$double, 2.0)
   
}

unitTestDeleteAnnotation <-
  function()
{
  entity <- new(Class = "Entity")

  entity$annotations$foo <- "bar"
  entity$annotations$boo <- "blah"
  entity$annotations$blue <- 1L

  expect_equal(length(annotationNames(entity)), 3L)
  
  entity <- deleteAnnotation(entity, "foo")
  expect_equal(length(annotationNames(entity)), 2L)
  expect_true(all(c("boo", "blue") %in% annotationNames(entity)))
  expect_equal(entity$annotations$boo, "blah")
  expect_equal(entity$annotations$blue, 1L)
  
  entity$annotations$boo <- NULL
  entity$annotations$blue <- NULL
  
  expect_equal(length(annotationNames(entity)), 0L)
}

unitTestDeleteProperty <-
  function()
{
  entity <- synapseClient:::Entity()
  entity$properties$id <- "syn1234"

  expect_equal("syn1234", entity$properties$id)
  newEntity <- deleteProperty(entity, "id")

  expect_equal(newEntity$properties$id, synapseClient:::Entity()$properties$id)
}

unitTestSetPropertyNull <-
  function()
{
  ## should be the equivalent of calling deleteProperty

}

unitTestAsList <-
  function()
{
  entity <- new("Entity")
}

unitTestBracketAccessorProperties <-
  function()
{
  entity <- synapseClient:::Entity()
  

}

unitTestPropertyValues <-
  function()
{
  entity <- synapseClient:::Entity()
  expect_equal(length(propertyValues(entity)), length(propertyValues(entity)))
}

unitTestPropertyNames <-
  function()
{

}


unitTestUsedAndExecuted<-function() {
  # test setting and retrieving 'used' entities on an entity
  a<-synapseClient:::Entity()
  expect_equal(NULL, used(a))
  used(a)<-list("syn101")
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  # test setting and retrieving 'executed' entities on an entity
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
  a<-synapseClient:::Entity()
  used(a)<-"syn101"
  expect_equal(list(list(reference=list(targetId="syn101"), wasExecuted=FALSE, 
        concreteType="org.sagebionetworks.repo.model.provenance.UsedEntity")), used(a))
  # test setting and retrieving 'executed' entities on an entity
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
  a<-synapseClient:::Entity()
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
 
}

unitTestSynAnnot<-function() {
  e<-Folder()
  expect_true(is.null(synAnnot(e, "id")))
  synAnnot(e, "id")<-"syn101"
  expect_equal("syn101", propertyValue(e, "id"))
  expect_equal("syn101", synAnnot(e, "id"))
  synAnnot(e, "myCustomAnnotation")<-"abc"
  expect_equal("abc", annotValue(e, "myCustomAnnotation"))
  expect_equal("abc", synAnnot(e, "myCustomAnnotation"))
  synAnnot(e, "myNumberAnnotation")<-999
  expect_equal(999, annotValue(e, "myNumberAnnotation"))
  expect_equal(999, synAnnot(e, "myNumberAnnotation"))
  synAnnot(e, "id")<-NULL
  expect_true(is.null(synAnnot(e, "id")))
}




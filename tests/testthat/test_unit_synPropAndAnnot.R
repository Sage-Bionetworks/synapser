# 
# Author: brucehoff
###############################################################################


unitTestSetAndGetProperty <- function() {
  e<-Folder()
  expect_true(is.null(synGetProperty(e, "id")))
  synSetProperty(e, "id")<-"syn101"
  expect_equal("syn101", synGetProperty(e, "id"))
  synSetProperty(e, "id")<-NULL
  expect_equal(NULL, synGetProperty(e, "id"))
  
  # check that undefined property triggers error
   expect_error(synSetProperty(e, "notAProperty")<-"foo")
   expect_error(synGetProperty(e, "notAProperty"))
  
  e<-Folder()
  props<-list("id"="syn101", "name"="myFolder")
  synSetProperties(e)<-props
  expect_equal(length(props), length(intersect(props, synGetProperties(e))))
  expect_equal("syn101", synGetProperty(e, "id"))
  expect_equal("myFolder", synGetProperty(e, "name"))
}

unitTestSetAndGetAnnotation <- function() {
  e<-Folder()
  synSetAnnotation(e, "myCustomAnnotation")<-"abc"
  expect_equal("abc", synGetAnnotation(e, "myCustomAnnotation"))
  
  expectedAnnots <- list("myCustomAnnotation"="abc")
  expect_equal(length(expectedAnnots), length(intersect(expectedAnnots, synGetAnnotations(e))))
  
  synSetAnnotation(e, "myCustomAnnotation")<-NULL
  expect_equal(NULL, synGetAnnotation(e, "myCustomAnnotation"))
  expect_true(!("myCustomAnnotation" %in% annotationNames(e)))
  
  e<-Folder()
  annots <-list("foo"=999, "bar"="bas")
  synSetAnnotations(e)<-annots
  expect_equal(length(annots), length(intersect(annots, synGetAnnotations(e))))
  expect_equal(999, synGetAnnotation(e, "foo"))
  expect_equal("bas", synGetAnnotation(e, "bar"))
}



  

# 
# Author: brucehoff
###############################################################################


unitTestSetAndGetProperty <- function() {
  e<-Folder()
  checkTrue(is.null(synGetProperty(e, "id")))
  synSetProperty(e, "id")<-"syn101"
  checkEquals("syn101", synGetProperty(e, "id"))
  synSetProperty(e, "id")<-NULL
  checkEquals(NULL, synGetProperty(e, "id"))
  
  # check that undefined property triggers error
  checkException(synSetProperty(e, "notAProperty")<-"foo")
  checkException(synGetProperty(e, "notAProperty"))
  
  e<-Folder()
  props<-list("id"="syn101", "name"="myFolder")
  synSetProperties(e)<-props
  checkEquals(length(props), length(intersect(props, synGetProperties(e))))
  checkEquals("syn101", synGetProperty(e, "id"))
  checkEquals("myFolder", synGetProperty(e, "name"))
}

unitTestSetAndGetAnnotation <- function() {
  e<-Folder()
  synSetAnnotation(e, "myCustomAnnotation")<-"abc"
  checkEquals("abc", synGetAnnotation(e, "myCustomAnnotation"))
  
  expectedAnnots <- list("myCustomAnnotation"="abc")
  checkEquals(length(expectedAnnots), length(intersect(expectedAnnots, synGetAnnotations(e))))
  
  synSetAnnotation(e, "myCustomAnnotation")<-NULL
  checkEquals(NULL, synGetAnnotation(e, "myCustomAnnotation"))
  checkTrue(!("myCustomAnnotation" %in% annotationNames(e)))
  
  e<-Folder()
  annots <-list("foo"=999, "bar"="bas")
  synSetAnnotations(e)<-annots
  checkEquals(length(annots), length(intersect(annots, synGetAnnotations(e))))
  checkEquals(999, synGetAnnotation(e, "foo"))
  checkEquals("bas", synGetAnnotation(e, "bar"))
}



  

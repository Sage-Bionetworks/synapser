#
# 
# Author: furia
###############################################################################

## Constructor
SynapseAnnotations <- 
  function(entity)
{
  if (missing(entity)) stop("entity is required")
  if(!is.list(entity))
    stop("entity must be a list.")
  if(any(names(entity) == "") && length(entity) > 0)
    stop("all elements of the entity must be named")
  
  aa <- new(Class = "SynapseAnnotations")
  ps <- new("TypedPropertyStore")
  aa@annotations <- .populateSlotsFromEntity(ps, entity)
  
  # anything that's not an annotation becomes a property
  nms <- c("stringAnnotations",
		  "doubleAnnotations",
		  "longAnnotations",
		  "dateAnnotations",
		  "blobAnnotations")
  
  for (name in names(entity)) {
	  if (!(name %in% nms)) propertyValue(aa, name)<-entity[[name]]
  }
  aa
}

setMethod(
  f = "annotations<-",
  signature = signature("SynapseAnnotations", "list"),
  definition = function(object, value){
    if(any(names(value) == ""))
      stop("all elements must be named")
    for(n in names(value)){
          annotValue(object, n) <- value[[n]]
        }
    object
  }
)

## show method
setMethod(
  f = "show",
  signature = "SynapseAnnotations",
  definition = function(object){
    tmp <- annotationValues(object)
    if(length(tmp) > 0L){
    names(tmp) <- annotationNames(object)
    show(as.list(tmp))
  }else{
      show(list())
    }
  } 
)

## getter for annotation names
setMethod(
  f = "annotationNames",
  signature = "SynapseAnnotations",
  definition = function(object){
    propertyNames(object@annotations)
  }
)

setMethod(
  f = "annotValue",
  signature = signature("SynapseAnnotations", "character"),
  definition = function(object, which){
    getProperty(object@annotations, which) 
  }
)

setMethod(
  f = "annotValue<-",
  signature = signature("SynapseAnnotations", "character", "ANY"),
  definition = function(object, which, value){
    object@annotations <- setProperty(object@annotations, which, value)
    object
  }
)

setMethod(
  f = "annotationValues",
  signature = "SynapseAnnotations",
  definition = function(object){
    propertyValues(object@annotations)
  }
)

setMethod(
  f = "annotationValues<-",
  signature = signature("SynapseAnnotations", "list"),
  def = function(object, value){
    ## this method is broken. need to implement  "propertyValues<-" for PropertyStore class
    propertyValues(object@annotations) <- value
    object
  }
)

setMethod(
    f = "propertyValues<-",
    signature = signature("SynapseAnnotations", "list"),
    definition = function(object, value){
      if(any(names(value)))
      lapply(names(value))
      object
    }
)

setMethod(
  f = "propertyNames",
  signature = "SynapseAnnotations",
  definition = function(object){
    propertyNames(object@properties)
  }
)

setMethod(
  f = "propertyValues",
  signature = "SynapseAnnotations",
  definition = function(object){
    propertyValues(object@properties)
  }
)


# for some reason the method above doesn't do what you expect, but this DOES
as_list_SynapseAnnotations <- 
		function(x, ...){
	as.list(x@annotations, ...)
}


as.list.SynapseAnnotations<-function(x) {
  annotations <- as.list(x@annotations)
    
    ## make sure all scalars are converted to lists since the service expects all 
    ## annotation values to be arrays instead of scalars
    for(key in names(annotations)){
      ## This is one of our annotation buckets
      if(is.list(annotations[[key]])) {
        for(annotKey in names(annotations[[key]])) {
          if(is.scalar(annotations[[key]][[annotKey]])) {
            annotations[[key]][[annotKey]] <- list(annotations[[key]][[annotKey]])
          }
        }
      }
    }
  
  c(as.list(x@properties), annotations)
}

setMethod(
  f = "[",
  signature = "SynapseAnnotations",
  definition = function(x, i, j, ...){
    if(length(as.character(as.list(substitute(list(...)))[-1L])) > 0L || !missing(j))
      stop("incorrect number of subscripts")
    if(is.numeric(i)){
      if(any(i > length(annotationNames(x))))
        stop("subscript out of bounds")
      i <- names(x)[i]
    }
    retVal <- lapply(i, function(i){
        annotValue(x, i)
      }
    )
    names(retVal) <- i
    retVal
  }
)

setMethod(
  f = "[[",
  signature = "SynapseAnnotations",
  definition = function(x, i, j, ...){
    if(length(as.character(as.list(substitute(list(...)))[-1L])) > 0L || !missing(j))
      stop("incorrect number of subscripts")
    if(length(i) > 1)
      stop("subscript out of bounds")
    x[i][[1]]
  }
)

setMethod(
  f = "$",
  signature = "SynapseAnnotations",
  definition = function(x, name){
    x[[name]]
  }
)

setReplaceMethod(
  f = "[[", 
  signature = signature(
    x = "SynapseAnnotations",
    i = "character"
  ),
  definition = function(x, i, value) {
    annotValue(x, i) <- value
    x
  }
)

setReplaceMethod(
  f = "$", 
  signature = "SynapseAnnotations",
  definition = function(x, name, value) {
    x[[name]] <- value
    x
  }
)

setMethod(
  f = "deleteAnnotation",
  signature = signature("SynapseAnnotations", "character"),
  definition = function(object, which){
    object@annotations <- deleteProperty(object@annotations, which)
    object
  }
)

setMethod(
  f = "updateEntity",
  signature = "SynapseAnnotations",
  definition = function(entity){
    annotations <- as.list(entity)
    
    emptyNamedList<-structure(list(), names = character())

    for(key in names(annotations)){
      ## This is one of our annotation buckets
      if(is.list(annotations[[key]])) {
        for(annotKey in names(annotations[[key]])) {
          if(is.scalar(annotations[[key]][[annotKey]])) {
            annotations[[key]][[annotKey]] <- list(annotations[[key]][[annotKey]])
          }
        }
        
        if (length(annotations[[key]])==0) {
          annotations[[key]]<-emptyNamedList
        }
      }
    }

    uri <- sprintf("/entity/%s/annotations", entity@properties$id)
    SynapseAnnotations(synapsePut(uri, as.list(annotations)))
  }
)



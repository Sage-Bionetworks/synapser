# These are the methods for TypedList
# 
# Author: brucehoff
###############################################################################

setMethod(
  f = "$",
  signature = "TypedList",
  definition = function(x, name){
    x@content[[name]]
  }
)

validateTypedListElement<-function(typedList, value) {
  if (!is(value, typedList@type)) stop(sprintf("Expected %s but found %s.", typedList@type, class(value)))
}

setReplaceMethod("$",
  signature = "TypedList",
  definition = function(x, name, value) {
    validateTypedListElement(x, value)
    x@content[[name]]<-value
    x
  }
)

setMethod(
  f = "[[",
  signature = "TypedList",
  definition = function(x, i, j, ...){
    x@content[[i]]
  }
)

setReplaceMethod("[[", 
  signature = signature(
    x = "TypedList",
    i = "character"
  )
  ,
  function(x, i, value) {
    validateTypedListElement(x, value)
    x@content[[i]]<-value
    x
  }
)

setReplaceMethod("[[", 
  signature = signature(
    x = "TypedList",
    i = "integer"
  )
  ,
  function(x, i, value) {
    validateTypedListElement(x, value)
    x@content[[i]]<-value
    x
  }
)

setReplaceMethod("[[", 
  signature = signature(
    x = "TypedList",
    i = "numeric"
  )
  ,
  function(x, i, value) {
    validateTypedListElement(x, value)
    x@content[[i]]<-value
    x
  }
)

setMethod(
  f = "set",
  signature = signature("TypedList", "list"),
  definition = function(x, values) {
    # make sure all values have the right type
    lapply(X=values, FUN=function(value){validateTypedListElement(x, value)})
    x@content<-values
    x
  }
)

setMethod(
  f = "length",
  signature = "TypedList",
  definition = function(x) {
    length(x@content)
  }
)

setMethod(
  f = "getList",
  signature = "TypedList",
  definition = function(x) {
    x@content
  }
)

createTypedList<-function(untyped) {
  if (is.null(untyped) || length(untyped)==0) stop("Argument is empty.")
  if (is(untyped, "list")) {
    type<-class(untyped[[1]])
    if (!all(sapply(X=untyped, FUN=function(x){is(x, type)}))) stop("list elements are not all of the same type.")
    # we are not in the business of creating classes on the fly.
    # if the class doesn't already exist the following will throw an exception
    result<-do.call(listClassName(type), list())
    result@content<-untyped
  } else { # treat as a vector
    type<-class(untyped)
    # we are not in the business of creating classes on the fly.
    # if the class doesn't already exist the following will throw an exception
    result<-do.call(listClassName(type), list())
    result@content<-as.list(untyped)
  }
  result
}


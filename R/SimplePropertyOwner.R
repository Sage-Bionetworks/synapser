#
# 
# Author: furia
###############################################################################

setMethod(
    f = "properties",
    signature = "SimplePropertyOwner",
    definition = function(object){
      val <- lapply(propertyNames(object), function(name) propertyValue(object, name))
      names(val) <- propertyNames(object)
      val
    }
)

setMethod(
    f = "properties<-",
    signature = "SimplePropertyOwner",
    definition = function(object, value){
      if(!is.null(object@properties@typeMap) & !all(names(value) %in% propertyNames(object)))
        stop(sprintf("invalid property names specified: %s", names(value)))
      for(n in names(value)){
        propertyValue(object, n) <- value
      }
      object
    }

)

setMethod(
  f = "propertyNames",
  signature = "SimplePropertyOwner",
  definition = function(object){
    names(object@properties)
  }
)

setMethod(
  f = "propertyValues",
  signature = "SimplePropertyOwner",
  definition = function(object){
    values <- lapply(propertyNames(object), function(n){
        val <- propertyValue(object,n)
        if(is.null(val))
          val <- "NULL"
        val
      }
    )
    unlist(values)
  }
)

#####
## Set multiple property values
#####
setMethod(
		f = "propertyValues<-",
		signature = signature("SimplePropertyOwner", "list"),
		definition = function(object, value){
			if(any(names(value) == "") && length(value) > 0)
				stop("All entity members must be named")

      if(!is.null(object@properties@typeMap) & !all(names(value) %in% propertyNames(object)))
        stop(sprintf("invalid property names specified: %s", names(value)))

			for(name in names(value))
				propertyValue(object, name) <- value[[name]]

			object
		}
)

#####
## Delete a property
#####
setMethod(
		f = "deleteProperty",
		signature = signature("SimplePropertyOwner", "character"),
		definition = function(object, which){
			if(!all(which %in% propertyNames(object))){
				indx <- which(!(which %in% propertyNames(object)))
				warning(paste(propertyNames(object)[indx], sep="", collapse=","), "were not found in the object, so were not deleted.")
			}
      for(w in which)
        propertyValue(object, which) <- NULL
			object
		}
)

#####
## set a property value
#####
setMethod(
		f = "propertyValue<-",
		signature = signature("SimplePropertyOwner", "character"),
		definition = function(object, which, value){
      if(!is.null(object@properties@typeMap) & !all(which %in% propertyNames(object)))
        stop(sprintf("invalid property name specified: %s", which))
			propertyValue(object@properties, which) <- value
			object
		}
)

setMethod(
  f = "propertyValue<-",
  signature = signature("SimplePropertyOwner", "character", "list"),
  definition = function(object, which, value){
    if(!is.null(object@properties@typeMap) & !all(which %in% propertyNames(object)))
      stop(sprintf("invalid property name specified: %s", which))

    propertyValue(object@properties, which) <- value
    object
  }
)

## S3 method to convert object to list
as.list.SimplePropertyOwner<-function(x) {
	as.list(x@properties)
}

# move content from 'entity' (a list) to 'object' ( a SimplePropertyOwner)
setMethod(
		f = ".populateSlotsFromEntity",
		signature = signature("SimplePropertyOwner", "list", "missing"),
		definition = function(object, entity) {
			for (label in names(entity)) {
				propertyValue(object, label)<-entity[[label]]
			}
			object
		}
)

setMethod(
    f = "propertyValue",
    signature = signature("SimplePropertyOwner", "character"),
    definition = function(object, which){
      propertyValue(object@properties, which)
    }
)

setMethod(
  f = "$",
  signature = "SimplePropertyOwner",
  definition = function(x, name){
   if (any(name==propertyNames(x))) {
      propertyValue(x, name)
    } else {
      stop(sprintf("invalid name %s", name))
    }
  }
)

setReplaceMethod("$", 
  signature = "SimplePropertyOwner",
  definition = function(x, name, value) {
    if (any(name==propertyNames(x))) {
      propertyValue(x, name)<-value
      x
    } else {
      stop(sprintf("invalid name %s", name))
    }
  }
)

identicalSimplePropertyOwner<-function(x, y, num.eq = TRUE, single.NA = TRUE, attrib.as.set = TRUE,
  ignore.bytecode = TRUE) {
  sortedNamesX <- sort(names(properties(x)))
  sortedNamesY <- sort(names(properties(y)))
  if (!identical(sortedNamesX, sortedNamesY)) return(FALSE)
  for (name in sortedNamesX) {
    if (!identical(propertyValue(x, name), propertyValue(x, name))) return(FALSE)
  }
  TRUE
}

setMethod("identical",
  signature=signature("SimplePropertyOwner", "SimplePropertyOwner"),
  definition = function(x, y, num.eq=TRUE, single.NA = TRUE, attrib.as.set = TRUE,
    ignore.bytecode = TRUE) {
    identicalSimplePropertyOwner(x, y, num.eq, single.NA, attrib.as.set, ignore.bytecode)
  }
)
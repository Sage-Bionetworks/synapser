# create method for auto-generated S4 objects
# 
# Author: brucehoff
###############################################################################

createS4Object<-function(object, createUri) {
  objectAsList<-createListFromS4Object(object)
  listResult<-synRestPOST(createUri, objectAsList)
  objectResult<-createS4ObjectFromList(listResult, class(object))
  objectResult
}




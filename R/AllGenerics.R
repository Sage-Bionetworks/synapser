#
#
# Author: furia
###############################################################################

setGeneric(
	name = ".populateSlotsFromEntity",
	def = function(object, entity, json){
		standardGeneric(".populateSlotsFromEntity")
	}
)

setGeneric(
  name="Activity",
  def = function(activity, ...) {
    standardGeneric("Activity")
  }
)

setGeneric(
  name = "available.versions",
  def = function(object){
    standardGeneric('available.versions')
  }
)

setGeneric(
  name = "initializeEntity",
  def = function(entity){
    standardGeneric("initializeEntity")
  }
)

setGeneric(
  name = "createEntity",
  def = function(entity){
    standardGeneric("createEntity")
  }
)


setGeneric(
  name = "storeEntity",
  def = function(entity){
    standardGeneric("storeEntity")
  }
)

setGeneric(
  name = "storeFile",
  def = function(entity, filePath){
    standardGeneric("storeFile")
  }
)

setGeneric(
  name = "updateEntity",
  def = function(entity){
    standardGeneric("updateEntity")
  }
)

setGeneric(
  name = "deleteEntity",
  def = function(entity){
    standardGeneric("deleteEntity")
  }
)

setGeneric(
  name = "getParentEntity",
  def = function(entity){
    standardGeneric("getParentEntity")
  }
)

setGeneric(
  name = "onWeb",
  def = function(entity){
    standardGeneric("onWeb")
  }
)

setGeneric(
  name = "downloadEntity",
  def = function(entity, versionId){
    standardGeneric("downloadEntity")
  }
)

setGeneric(
  name = "getEntity",
  def = function(entity, versionId){
    standardGeneric("getEntity")
  }
)

setGeneric(
  name = "getEntityInstance",
  def = function(entity){
    standardGeneric("getEntityInstance")
  }
)

setGeneric(
  name = "loadEntity",
  def=function(entity, versionId, ...){
    standardGeneric("loadEntity")
  }
)

setGeneric(
  name = "getAnnotations",
  def = function(entity){
    standardGeneric("getAnnotations")
  }
)

setGeneric(
  name = "deleteProperty",
  def = function(object, which){
    standardGeneric("deleteProperty")
  }
)

setGeneric(
  name = "properties",
  def = function(object){
    standardGeneric("properties")
  }
)

setGeneric(
  name = "properties<-",
  def = function(object, value){
    standardGeneric("properties<-")
  }
)

setGeneric(
  name = "propertyValues",
  def = function(object){
    standardGeneric("propertyValues")
  }
)

setGeneric(
  name = "propertyValues<-",
  def = function(object, value){
    standardGeneric("propertyValues<-")
  }
)

setGeneric(
  name = "annotations",
  def = function(object){
    standardGeneric("annotations")
  }
)

setGeneric(
  name = "propertyValue",
  def = function(object, which){
    standardGeneric("propertyValue")
  }
)

setGeneric(
  name = "propertyValue<-",
  def = function(object, which, value){
    standardGeneric("propertyValue<-")
  }
)

setGeneric(
  name = "annotations<-",
  def = function(object, value){
    standardGeneric("annotations<-")
  }
)

setGeneric(
  name = "annotationNames",
  def = function(object){
    standardGeneric("annotationNames")
  }
)

setGeneric(
  name = "annotValue",
  def = function(object, which){
    standardGeneric("annotValue")
  }
)

setGeneric(
  name = "deleteAnnotation",
  def = function(object, which){
    standardGeneric("deleteAnnotation")
  }
)

setGeneric(
  name = "annotValue<-",
  def = function(object, which, value){
    standardGeneric("annotValue<-")
  }
)

setGeneric(
  name = "annotationValues",
  def = function(object){
    standardGeneric("annotationValues")
  }
)

setGeneric(
  name = "annotationValues<-",
  def = function(object, value){
    standardGeneric("annotationValues<-")
  }
)

setGeneric(
  name = "synAnnot",
  def = function(object, which){
    standardGeneric("synAnnot")
  }
)

setGeneric(
  name = "synAnnot<-",
  def = function(object, which, value){
    standardGeneric("synAnnot<-")
  }
)

setGeneric(
  name = "TypedPropertyStore",
  def = function(file, data, json){
    standardGeneric("TypedPropertyStore")
  }
)

setGeneric(
  name = "setUpdatePropValue",
  def = function(object, which, value, type){
    standardGeneric("setUpdatePropValue")
  }
)
setGeneric(
  name = "propertyNames",
  def = function(object){
    standardGeneric("propertyNames")
  }
)

setGeneric(
  name = "propertyValues",
  def = function(object){
    standardGeneric("propertyValues")
  }
)

setGeneric(
  name = "propertyType",
  def = function(object, which){
    standardGeneric("propertyType")
  }
)

setGeneric(
  name = "getProperty",
  def = function(object, which){
    standardGeneric("getProperty")
  }
)

setGeneric(
  name = "setProperty",
  def = function(object, which, value){
    standardGeneric("setProperty")
  }
)

## Generic method for addObject
setGeneric(
  name = "addObject",
  def = function(owner, object, name, unlist){
    standardGeneric("addObject")
  }
)

## generic method for deleteObject
setGeneric(
  name = "deleteObject",
  def = function(owner, which){
    standardGeneric("deleteObject")
  }
)

## Generic method for renameObject
setGeneric(
  name = "renameObject",
  def = function(owner, which, name){
    standardGeneric("renameObject")
  }
)

## Generic method for getObject
setGeneric(
  name = "getObject",
  def = function(owner, which){
    standardGeneric("getObject")
  }
)

setGeneric(
  name = "addFile",
  def = function(entity, file, path){
    standardGeneric("addFile")
  }
)

setGeneric(
  name = "synapseEntityKind",
  def = function(entity){
    standardGeneric("synapseEntityKind")
  }
)

setGeneric(
  name = "synapseEntityKind<-",
  def = function(entity, value){
    standardGeneric("synapseEntityKind<-")
  }
)

setGeneric(
  name = "refreshAnnotations",
  def = function(entity){
    standardGeneric("refreshAnnotations")
  }
)

setGeneric(
  name = "storeActivity",
  def = function(activity) {
    standardGeneric("storeActivity")
  }
)

setGeneric(
  name = "showEntity",
  def = function(activity) {
    standardGeneric("showEntity")
  }
)

setGeneric(
  name = "getActivity",
  def = function(activity) {
    standardGeneric("getActivity")
  }
)

setGeneric(
  name = "synGetActivity",
  def = function(entity, version) {
    standardGeneric("synGetActivity")
  }
)

setGeneric(
  name = "deleteActivity",
  def = function(activity) {
    standardGeneric("deleteActivity")
  }
)

setGeneric(
  name = "generatedBy",
  def = function(entity){
    standardGeneric("generatedBy")
  }
)

setGeneric(
  name = "generatedBy<-",
  def = function(entity, value){
    standardGeneric("generatedBy<-")
  }
)

setGeneric(
  name = "getGeneratedBy",
  def = function(entity){
    standardGeneric("getGeneratedBy")
  }
)

setGeneric(
  name = "used",
  def = function(entity) {
    standardGeneric("used")	
  }
)

setGeneric(
  name = "used<-",
  def = function(entity, value) {
    standardGeneric("used<-")
  }
)

setGeneric(
  name = "executed",
  def = function(entity) {
    standardGeneric("executed")	
  }
)

setGeneric(
  name = "executed<-",
  def = function(entity, value) {
    standardGeneric("executed<-")
  }
)

# returns a reference list of the form (targetId="syn1234") or
# (targetId="syn1234", targetVersionNumber="1") referring
# to the given entity.  The argument can be a SynapseEntity or a 
# synapse ID
setGeneric(
  name = "getReference",
  def = function(entity) {
    standardGeneric("getReference")
  }
)

setGeneric(
  name="usedListEntry",
  def = function(listEntry, ...) {
    standardGeneric("usedListEntry")
  }
)

setGeneric(
  name="synStore",
  def = function(entity, ...) {
    standardGeneric("synStore")
  }
)

setGeneric(
  name="synDelete",
  def = function(entity, ...) {
    standardGeneric("synDelete")
  }
)

setGeneric(
  name="createFileFromProperties",
  def = function(propertiesList) {
    standardGeneric("createFileFromProperties")
  }
)

setGeneric(
  name="createSubmissionFromProperties",
  def = function(propertiesList) {
    standardGeneric("createSubmissionFromProperties")
  }
)

setGeneric(
  name = "synGetAnnotations",
  def = function(object){
    standardGeneric("synGetAnnotations")
  }
)

setGeneric(
  name = "synSetAnnotations<-",
  def = function(object, value){
    standardGeneric("synSetAnnotations<-")
  }
)

setGeneric(
  name = "synGetProperties",
  def = function(object){
    standardGeneric("synGetProperties")
  }
)

setGeneric(
  name = "synSetProperties<-",
  def = function(object, value){
    standardGeneric("synSetProperties<-")
  }
)

setGeneric(
  name = "synGetAnnotation",
  def = function(object, which){
    standardGeneric("synGetAnnotation")
  }
)

setGeneric(
  name = "synSetAnnotation<-",
  def = function(object, which, value){
    standardGeneric("synSetAnnotation<-")
  }
)

setGeneric(
  name = "synGetProperty",
  def = function(object, which){
    standardGeneric("synGetProperty")
  }
)

setGeneric(
  name = "synSetProperty<-",
  def = function(object, which, value){
    standardGeneric("synSetProperty<-")
  }
)

setGeneric(
  name = "set",
  def = function(x, values) {
    standardGeneric("set")
  }
)

setGeneric(
  name = "getList",
  def = function(x) {
    standardGeneric("getList")
  }
)

setGeneric(
  name="createTableSchemaFromProperties",
  def = function(propertiesList) {
    standardGeneric("createTableSchemaFromProperties")
  }
)

setGeneric(
  name="Table",
  def = function(tableSchema, values, ...) {
    standardGeneric("Table")
  }
)

setGeneric(
  name="as.tableColumns",
  def = function(source, ...) {
    standardGeneric("as.tableColumns")
  }
)



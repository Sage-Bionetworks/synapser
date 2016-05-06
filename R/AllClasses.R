## Class Definitions. Class definitions for the specific Synapse entity types
## are located in SynapseEntityDefinitions.R
##
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

##
## NOTE: this constructor is defined here because it is used in the definition of
## the Entity class
##
setGeneric(
  name = "SynapseProperties",
  def = function(typeMap){
    standardGeneric("SynapseProperties")
  }
)

setMethod(
  f = "SynapseProperties",
  signature = "list",
  definition = function(typeMap){
    if(any(names(typeMap) == ""))
      stop("all properties must be named")
    if(any(table(names(typeMap)) > 1L))
      stop("each name must appear only once")
    if(!all(typeMap %in% TYPEMAP))
      stop("invalid data type specified")

    object <- new("SynapseProperties")
    object@typeMap <- typeMap
    object
  }
)



##
## the global cache is a singleton
##
setClass(
    Class = "GlobalCache",
    representation = representation(env = "environment"),
    prototype = prototype(
        env = new.env(parent=emptyenv())
    )
)

##
## a file cache factory makes sure that all in-memory copies
## of a file cache object hold a reference to the same copy
##
setClass(
    Class = "FileCacheFactory",
    representation = representation(load = "environment", get="environment"),
    prototype = prototype(load=new.env(parent = emptyenv()), get= new.env(parent=emptyenv()))
)

##
## class for storing typed properties. Right now this is only
## used for storing synapse annotations, but in the future it will also be
## used to store typed synapse properties once the JSON schema is integrated
## with the R Synapse client
##

emptyNamedList<-structure(list(), names = character()) # copied from RJSONIO

setClass(
    Class = "TypedPropertyStore",
    representation = representation(
        stringAnnotations = "list",
        doubleAnnotations = "list",
        longAnnotations = "list",
        dateAnnotations = "list",
        blobAnnotations = "list"
    ),
    prototype = prototype(
        stringAnnotations = emptyNamedList,
        doubleAnnotations = emptyNamedList,
        longAnnotations = emptyNamedList,
        dateAnnotations = emptyNamedList,
        blobAnnotations = emptyNamedList
    )
)

setClass(
  Class = "SynapseProperties",
  representation = representation(
    properties = "TypedPropertyStore",
    typeMap = "list"
  ),
  prototype=prototype(typeMap=NULL)
)

##
## this class may not seem necessary since it's just a wrapper on
## a list, but it will allow for an easier changeover to typed
## properties once the R client integrates the Synapse JSON schema
## this class is intended to be used to keep track of properties
## for both the Synapse "Annotations" entity and the "Base" Synapse
## entity
##
setClass(
    Class = "SimplePropertyOwner",
    contains = "VIRTUAL",
    representation = representation(
      properties = "SynapseProperties"
    ),
    prototype = prototype(
      properties = new("SynapseProperties")
    )
)


setClass(
		Class = "Activity",
		contains = "SimplePropertyOwner",
		prototype = prototype(
      properties = SynapseProperties(getEffectivePropertyTypes("org.sagebionetworks.repo.model.provenance.Activity"))
		)
)

##
## A class for representing the Synapse Annotations entity
##
setClass(
    Class = "SynapseAnnotations",
    contains = "SimplePropertyOwner",
    representation = representation(
        annotations = "TypedPropertyStore"
    ),
    prototype = prototype(
        annotations <- new("TypedPropertyStore")
    )
)

setClassUnion("activityOrNULL", c("Activity", "NULL"))

setClass(
  Class="PaginatedResults",
  representation = list(
    totalNumberOfResults="integer",
    results = "list"
    )
)

setClass(
  Class="Config", 
  representation=list(data="list")
)

setClass(
  Class = "Entity",
  contains = "SimplePropertyOwner",
  representation = representation(
    annotations = "SynapseAnnotations",
    synapseEntityKind = "character",
    synapseWebUrl = "character",
    generatedBy = "activityOrNULL",
    generatedByChanged = "logical"
  )
)

# This is an abstract class for a typed list
# Concrete extensions should fill the 'type' slot
# with the class of the elements in the list
setClass(
  Class="TypedList", 
  contains = "VIRTUAL",
  representation=representation(type="character", content="list"), 
  prototype=list(content=list())
)

# This class is used to represent a null S4 value in a slot in another S4 class
# Normally S4 classes don't allow S4 slots to be null.  The recommended workaround
# is to create a class union, e.g. setClassUnion("myClassOrNULL", c("MyClass", "NULL"))
# However since this makes the class union a super-class of NULL, R 'breaks' when
# the package namespace is unloaded.  So rather than use NULL to represent a NULL
# object we use an instance of this special placeholder class.
setClass(
  Class = "NullS4Object",
  representation=representation(placeholder="character") # if omitted it's a 'virtual' class!!
)

# Autogenerated classes
defineS4Classes()

# ---- Classes dependent on auto-generated ones go after this line.

setClass(
		Class = "TableSchema",
		contains = "Entity",
		representation = representation(
				columns = "TableColumnList"
		),
		prototype = prototype(
				synapseEntityKind = "TableSchema"
		)
)

setClassUnion("TableSchemaOrCharacter", c("TableSchema", "character"))

setClass(
		Class = "Table",
		# this can either be a TableSchema or the ID of the TableSchema
		representation=representation(schema="TableSchemaOrCharacter")
)

setClass(
		Class = "TableDataFrame",
		contains = c("Table"),
		representation=representation(values="data.frame", updateEtag="character")
)

setClass(
		Class = "TableFilePath",
		contains = c("Table"),
		representation=representation(
				filePath="character",
				updateEtag="character",
				linesToSkip="integer",
				quoteCharacter="character",
				isFirstLineHeader="logical",
				escapeCharacter="character",
				lineEnd="character",
				separator="character"
		)
)

setClass(
		Class = "TableRowCount",
		contains = c("Table"),
		representation=representation(rowCount="integer", updateEtag="character")
)

setClass(
		Class = "TableFileHandleId",
		contains = c("Table"),
		representation=representation(
				fileHandleId="integer",
				updateEtag="character",
				linesToSkip="integer",
				quoteCharacter="character",
				isFirstLineHeader="logical",
				escapeCharacter="character",
				lineEnd="character",
				separator="character"
		)
)




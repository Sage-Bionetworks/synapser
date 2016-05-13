# 
# Author: brucehoff
###############################################################################

.setUp <- function() {
  # create project
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
  
}

.tearDown <- function() {
  # delete the project, cascading to the table
  deleteEntity(synapseClient:::.getCache("testProject"))
  
}

integrationTestCreateTableSchema<-function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-list()
  for (i in 1:3) {
    tableColumn<-TableColumn(
      name=sprintf("R_Client_Integration_Test_Column_Name_%d", i), 
      columnType="STRING")
	
	  # it should work whether or not you store the column first
    if (i<3) tableColumn<-synStore(tableColumn)
		if (i==2) {
			# it should work if you just provide the ID
			tableColumns<-append(tableColumns, tableColumn@id)
		} else {
			tableColumns<-append(tableColumns, tableColumn)
		}
  }
	# this point tableColumns is a list of (1) a stored column, (2) an unstored column, (3) a column ID
  
  name<-sprintf("R_Client_Integration_Test_Create_Schema_%s", sample(999999999, 1))
 
  tableSchema<-TableSchema(name=name, parent=propertyValue(project, "id"), columns=tableColumns,  foo="bar", "pi"=3.14)
	
  storedSchema<-synStore(tableSchema)
  id<-propertyValue(storedSchema, "id")
  expect_true(!is.null(id))
  expect_true(!is.null(propertyValue(storedSchema, "etag")))
  expect_true(!is.null(propertyValue(storedSchema, "createdOn")))
  expect_true(!is.null(propertyValue(storedSchema, "modifiedOn")))
  expect_true(!is.null(propertyValue(storedSchema, "uri")))
  expect_true(!is.null(propertyValue(storedSchema, "createdBy")))
  expect_true(!is.null(propertyValue(storedSchema, "modifiedBy")))
  expect_equal(propertyValue(storedSchema, "name"), name)
  expect_equal(propertyValue(storedSchema, "parentId"), propertyValue(project, "id"))
  expect_equal(synGetAnnotations(storedSchema), synGetAnnotations(tableSchema))
  
  retrievedSchema<-synGet(id)
  expect_true(identical(retrievedSchema, storedSchema))
  
  expect_equal(synGetAnnotation(retrievedSchema, "foo"), "bar")
  expect_equal(synGetAnnotation(retrievedSchema, "pi"), 3.14)
	
	# check that that retrieved columns match the retrieved column IDs
	expect_equal(3, length(retrievedSchema@columns))
	expect_equal(3, length(propertyValue(retrievedSchema, "columnIds")))
	for (i in 1:3) {
		expect_true(any(retrievedSchema@columns[[i]]$id==propertyValue(retrievedSchema, "columnIds")))
	}
	
  synDelete(storedSchema)
  
  # check synDelete
   expect_error(synGet(id))
 
}

integrationTestAddAndRemoveColumns<-function() {
	project<-synapseClient:::.getCache("testProject")
	name<-sprintf("R_Client_Integration_Test_Create_Schema_%s", sample(999999999, 1))
	tableSchema<-TableSchema(name=name, parent=propertyValue(project, "id"), columns=list())
	columnName<-"R_Client_Integration_Test_Column_Name_1"
	tableColumn<-TableColumn(name=columnName,columnType="STRING")
	tableSchema<-synAddColumn(tableSchema, tableColumn)
	tableSchema<-synStore(tableSchema)
	columns<-synGetColumns(tableSchema)
	expect_equal(1, length(columns))
	expect_equal(columnName, columns[[1]]@name)
	
	# now let's add another column, this time by its ID
	columnName2<-"R_Client_Integration_Test_Column_Name_2"
	tableColumn<-TableColumn(name=columnName2,columnType="STRING")
	tableColumn<-synStore(tableColumn)
	tableSchema<-synAddColumn(tableSchema, tableColumn@id)
	tableSchema<-synStore(tableSchema)
	columns<-synGetColumns(tableSchema)
	expect_equal(2, length(columns))
	expect_equal(columnName, columns[[1]]@name)
	expect_equal(columnName2, columns[[2]]@name)
	
	# now let's remove the first column
	tableSchema<-synRemoveColumn(tableSchema, columns[[1]])
	tableSchema<-synStore(tableSchema)
	columns<-synGetColumns(tableSchema)
	
	# schema should have just the second column
	expect_equal(1, length(columns))
	expect_equal(columnName2, columns[[1]]@name)
	
	synDelete(tableSchema)
	
}



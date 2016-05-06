# test for operations on Tables
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


createColumns<-function() {
	tableColumns<-list()
	for (i in 1:3) {
		tableColumn<-TableColumn(
				name=sprintf("R_Integration_Test_Column_%d", i), 
				columnType="STRING")
		tableColumns<-append(tableColumns, tableColumn)
	}
	tableColumns
}

createTableSchema<-function(projectId, tableColumns) {
	name<-sprintf("R_Client_Integration_Test_Create_Schema_%s", sample(999999999, 1))
	
	tableSchema<-TableSchema(name=name, parent=projectId, columns=tableColumns)
	tableSchema
}

testDataFramesEqual <- function(df1, df2){
	
	## check names
	checkTrue(all(names(df1)==names(df2)))
	## check values
	## two step process:
	## checkTrue with na.rm to ensure all values are identical
	## checkTrue with is.na to ensure that all nas are identical
	checkTrue(all(df1==df2, na.rm=T))
	checkTrue(all(is.na(df1)==is.na(df2)))
	## check column classes
	all(sapply(df1, function(x){class(x)[1]})==sapply(df2, function(x){class(x)[1]}))
}

integrationTestSynStoreDataFrame <- function() {
	project<-synapseClient:::.getCache("testProject")
	
	tableColumns<-createColumns()
	tableColumnNames<-list()
	for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
	tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
	
	dataFrame <- as.data.frame(matrix(c("a1", "b1", "c1", "a2", "b2", "c2"), nrow = 2, ncol = 3, byrow = TRUE,
					dimnames = list(c(1,2), tableColumnNames)))
	table<-Table(tableSchema=tableSchema, values=dataFrame)
	retrievedTable<-synStore(table, retrieveData=TRUE, verbose=FALSE)
	
	# modify the retrieved table (we exchange the two values)
	retrievedTable@values[1,3]<-"c2"
	retrievedTable@values[2,3]<-"c1"
  # append a new row
	retrievedTable@values<-rbind(retrievedTable@values, c("z1", "z2", "z3"))

	# update in Synapse
	updatedTable<-synStore(retrievedTable, retrieveData=TRUE, verbose=FALSE)
	checkTrue(is(updatedTable, "TableDataFrame"))
	checkEquals(propertyValue(updatedTable@schema, "id"), propertyValue(retrievedTable@schema, "id"))
	checkTrue(length(updatedTable@updateEtag)>0)
	# now check that the data frames are the same
	testDataFramesEqual(updatedTable@values, retrievedTable@values)
	# make sure the row labels are valid
	synapseClient:::parseRowAndVersion(row.names(updatedTable@values))   
	
}



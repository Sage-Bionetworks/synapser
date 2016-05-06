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
  # note we permute the column order in the data frame values and headers, then
  # test that it comes out right
  permutedDataFrame <- as.data.frame(matrix(c("b1", "a1", "c1", "b2", "a2", "c2"), nrow = 2, ncol = 3, byrow = TRUE,
      dimnames = list(c(1,2), tableColumnNames[c(2,1,3)])))
  table<-Table(tableSchema=tableSchema, values=permutedDataFrame)
  retrievedTable<-synStore(table, retrieveData=TRUE, verbose=FALSE)
  show(retrievedTable) # make sure 'show' works
  checkTrue(is(retrievedTable, "TableDataFrame"))
  checkTrue(!is.null(propertyValue(retrievedTable@schema, "id")))
  checkTrue(length(retrievedTable@updateEtag)>0)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, retrievedTable@values)
  # make sure the row labels are valid
  synapseClient:::parseRowAndVersion(row.names(retrievedTable@values))
  
  # modify the retrieved table (we exchange the two values)
  retrievedTable@values[1,3]<-"c2"
  retrievedTable@values[2,3]<-"c1"
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

integrationTestSynStoreDataFrameNORetrieveData <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-createColumns()
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  tableSchema<-synStore(tableSchema)
  dataFrame <- as.data.frame(matrix(c("b1", "a1", "c1", "b2", "a2", "c2"), nrow = 2, ncol = 3, byrow = TRUE,
      dimnames = list(c(1,2), tableColumnNames[c(2,1,3)])))
  table<-Table(tableSchema=propertyValue(tableSchema, "id"), values=dataFrame)
  stored<-synStore(table, verbose=FALSE)
  show(stored) # make sure 'show' works
  checkEquals(stored@rowCount, 2)
}

integrationTestSynStoreDataFrameWRONGColumns <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-createColumns()
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  
  id<-propertyValue(tableSchema, "id")
  # replace the third column name with "foo"
  dataFrame <- as.data.frame(matrix(c("a1", "b1", "c1", "a2", "b2", "c2"), nrow = 2, ncol = 3, byrow = TRUE,
      dimnames = list(c(1,2), c(tableColumnNames[1:2], "foo"))))
  table<-Table(tableSchema=tableSchema, values=dataFrame)
  # the erroneous column name should cause an error
  checkException(synStore(table, verbose=FALSE))
}

integrationTestSynStoreDataFrameWrongColumnType <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-createColumns()
  tableColumn<-TableColumn(
    name=sprintf("R_Integration_Test_Column_%d", 3), 
    columnType="INTEGER") # WRONG TYPE FOR DATA!
  tableColumns[[3]]<-synStore(tableColumn)
  
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  
  id<-propertyValue(tableSchema, "id")
  dataFrame <- as.data.frame(matrix(c("a1", "b1", "c1", "a2", "b2", "c2"), nrow = 2, ncol = 3, byrow = TRUE,
      dimnames = list(c(1,2), tableColumnNames)))
  table<-Table(tableSchema=tableSchema, values=dataFrame)
  # the erroneous column type should cause an error
  checkException(synStore(table, verbose=FALSE))
}

integrationTestSynStoreMixedDataFrame<-function() {
  project<-synapseClient:::.getCache("testProject")
  
  tc1 <- TableColumn(name="sweet", columnType="STRING", enumValues=c("one", "two", "three"))
  tc1 <- synStore(tc1)
  tc2 <- TableColumn(name="sweet2", columnType="INTEGER")
  tc2 <- synStore(tc2)
  
  pid<-propertyValue(project, "id")
  tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2))
  tschema <- synStore(tschema, createOrUpdate=FALSE)
  
  rowsToUpload<-30
  myTable <- Table(propertyValue(tschema, "id"), values=
      data.frame(
        sweet=sample(c("one", "two", "three"), size = rowsToUpload, replace = T), 
        sweet2=sample.int(rowsToUpload, replace = T)
  ))
  stored <- synStore(myTable)
  # returns the number of rows uploaded
  checkEquals(stored@rowCount, rowsToUpload)
}


integrationTestSynStoreRetrieveAndQueryMixedDataFrame<-function() {
  project<-synapseClient:::.getCache("testProject")
  
  tc1 <- TableColumn(name="sweet", columnType="STRING")
  tc1 <- synStore(tc1)
  tc2 <- TableColumn(name="sweet2", columnType="INTEGER")
  tc2 <- synStore(tc2)
  
  pid<-propertyValue(project, "id")
  tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2))
  tschema <- synStore(tschema, createOrUpdate=FALSE)
  
  rowsPerCategory<-10
  rowsToUpload<-rowsPerCategory*3
  sweet=c(sample("one", rowsPerCategory, replace=T), 
      sample("two", rowsPerCategory, replace=T), 
      sample("three", rowsPerCategory, replace=T))
  dataFrame <- data.frame(
    sweet=sweet, 
    sweet2=sample.int(rowsToUpload, replace = T))
  myTable <- Table(tschema, values=dataFrame)
  myTable <- synStore(myTable, retrieveData=T)
  checkTrue(is(myTable, "TableDataFrame"))
  checkEquals(propertyValue(myTable@schema, "id"), propertyValue(tschema, "id"))
  checkTrue(length(myTable@updateEtag)>0)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, myTable@values)
  # make sure the row labels are valid
  synapseClient:::parseRowAndVersion(row.names(myTable@values))
  
  # test synTableQuery
  queryResult<-synTableQuery(sprintf("select * from %s", propertyValue(tschema, "id")), verbose=FALSE)
  checkTrue(is(queryResult, "TableDataFrame"))
  checkEquals(queryResult@schema, propertyValue(tschema, "id"))
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, queryResult@values)
  checkTrue(length(queryResult@updateEtag)>0)
  
  # test no load
  queryResult<-synTableQuery(sprintf("select * from %s", propertyValue(tschema, "id")), loadResult=FALSE, verbose=FALSE)
  checkTrue(is(queryResult, "TableFilePath"))
  checkEquals(queryResult@schema, propertyValue(tschema, "id"))
  checkTrue(file.exists(queryResult@filePath))
  checkTrue(length(queryResult@updateEtag)>0)
  
  filePath<-tempfile()
  queryResult<-synTableQuery(sprintf("select * from %s", propertyValue(tschema, "id")), loadResult=FALSE, verbose=FALSE, filePath=filePath)
  checkTrue(file.exists(queryResult@filePath))
  
  # test a simple aggregation query
  queryResult<-synTableQuery(sprintf("select count(*) from %s", propertyValue(tschema, "id")), verbose=FALSE)
  checkEquals(rowsToUpload, queryResult@values[1,1])
  
  # test a more complicated aggregation query
  queryResult<-synTableQuery(sprintf("select sweet, count(sweet) from %s where sweet='one'", propertyValue(tschema, "id")), verbose=FALSE)
  expected<-data.frame(sweet="one", "COUNT(sweet)"=as.integer(rowsPerCategory), check.names=FALSE)
  # now check that the data frames are the same
  testDataFramesEqual(expected, queryResult@values)
  
  # finally, check row deletion
  queryResult<-synTableQuery(sprintf("select * from %s", propertyValue(tschema, "id")), loadResult=TRUE, verbose=FALSE)
  deletionResult<-synDeleteRows(queryResult)
  checkEquals(deletionResult@rowCount, rowsToUpload)
}

roundPOSIXct<-function(x) {
	y<-round(as.numeric(x))
	as.POSIXct(y, origin="1970-01-01")
}

integrationTestSynStoreAndRetrieveAllTypes<-function() {
  project<-synapseClient:::.getCache("testProject")
  
  # String, Integer, Double, Boolean, Date, Filehandleid, Entityid
  tc1 <- TableColumn(name="stringType", columnType="STRING", enumValues=c("one", "two", "three"))
  tc1 <- synStore(tc1)
  tc2 <- TableColumn(name="intType", columnType="INTEGER")
  tc2 <- synStore(tc2)
  tc3 <- TableColumn(name="doubleType", columnType="DOUBLE")
  tc3 <- synStore(tc3)
  tc4 <- TableColumn(name="booleanType", columnType="BOOLEAN")
  tc4 <- synStore(tc4)
  tc5 <- TableColumn(name="dateType", columnType="DATE")
  tc5 <- synStore(tc5)
  tc6 <- TableColumn(name="fileHandleIdType1", columnType="FILEHANDLEID")
  tc6 <- synStore(tc6)
  tc7 <- TableColumn(name="fileHandleIdType2", columnType="FILEHANDLEID")
  tc7 <- synStore(tc7)
  tc8 <- TableColumn(name="entityIdType", columnType="ENTITYID")
  tc8 <- synStore(tc8)
  
  pid<-propertyValue(project, "id")
  tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2, tc3, tc4, tc5, tc6, tc7, tc8))
  tschema <- synStore(tschema, createOrUpdate=FALSE)
	
	fileHandleIds<-NULL
	for (i in 1:3) {
		# upload a file and receive the file handle
		filePath<- tempfile()
		connection<-file(filePath)
		writeChar(sprintf("this is a test %s", sample(999999999, 1)), connection, eos=NULL)
		close(connection)  
		fileHandle<-synapseClient:::chunkedUploadFile(filePath)
		checkTrue(!is.null(fileHandle$id))
		fileHandleIds<-c(fileHandleIds, fileHandle$id)
	}
	
  rowsToUpload<-30
  dataFrame<-data.frame(
    stringType=sample(c("one", "two", "three"), size = rowsToUpload, replace = T), 
    intType=sample.int(rowsToUpload, replace = T),
    doubleType=as.numeric(sample.int(rowsToUpload, replace = T)),
    booleanType=sample(c(TRUE, FALSE, NA), size = rowsToUpload, replace = T),
    dateType=sample(roundPOSIXct(Sys.time()+c(1,2,3)), size = rowsToUpload, replace = T),
    fileHandleIdType1=sample(fileHandleIds, size = rowsToUpload, replace = T),
    fileHandleIdType2=sample(as.integer(fileHandleIds), size = rowsToUpload, replace = T),
    entityIdType=sample(c("syn123", "syn456", "syn789"), size = rowsToUpload, replace = T)
    )
  
  
  myTable <- Table(tschema, values=dataFrame)
  myTable <- synStore(myTable, retrieveData=T)
  checkTrue(is(myTable, "TableDataFrame"))
  checkEquals(propertyValue(myTable@schema, "id"), propertyValue(tschema, "id"))
  checkTrue(length(myTable@updateEtag)>0)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, myTable@values)
  # make sure the row labels are valid
  synapseClient:::parseRowAndVersion(row.names(myTable@values))
}

integrationTestSynStoreRetrieveAndQueryNumericDataFrame<-function() {
  project<-synapseClient:::.getCache("testProject")
  
  tc1 <- TableColumn(name="sweet", columnType="DOUBLE")
  tc1 <- synStore(tc1)
  tc2 <- TableColumn(name="sweet2", columnType="DOUBLE")
  tc2 <- synStore(tc2)
  
  pid<-propertyValue(project, "id")
  tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2))
  tschema <- synStore(tschema, createOrUpdate=FALSE)
  
  dataFrame <- data.frame(sweet=c(1:5, 1.234e-10, 5.678e+10, NA, NaN, Inf, -Inf), sweet2=c(NA, 6:10, 1.234567, 9.876543, Inf, NaN, 1))
  myTable <- Table(tschema, values=dataFrame)
  myTable <- synStore(myTable, retrieveData=T)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, myTable@values)
  
  # also check what happens when query result is empty
  queryResult<-synTableQuery(sprintf("select * from %s where sweet=99", propertyValue(tschema, "id")), verbose=FALSE)
  # verify that the result is empty
  checkTrue(nrow(queryResult@values)==0)
}

integrationTestSynStoreNAColumn <- function() {
	project<-synapseClient:::.getCache("testProject")
	
	tc1<-TableColumn(name="R_Integration_Test_Column_0", columnType="STRING")
	tc2<-TableColumn(name="R_Integration_Test_Column_1", columnType="INTEGER")
	tableColumns<-c(tc1,tc2)
	
	tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
	tableSchema<-synStore(tableSchema)
	dataFrame <- data.frame("R_Integration_Test_Column_0"=c("A", "B", "C"), 
			"R_Integration_Test_Column_1"=c(NA, NA, NA))
	table<-Table(tableSchema=propertyValue(tableSchema, "id"), values=dataFrame)
	stored<-synStore(table, verbose=FALSE)
	checkEquals(stored@rowCount, 3)
}

integrationTestSynStoreCSVFileNoRetrieve <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-createColumns()
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  tableSchema<-synStore(tableSchema)
  id<-propertyValue(tableSchema, "id")
  table<-Table(tableSchema=tableSchema, values=system.file("resources/test/test.csv", package = "synapseClient"))
  stored<-synStore(table)
  checkEquals(2, stored@rowCount)
}

integrationTestSynStoreAndRetrieveCSVFile <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  tableColumns<-createColumns()
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  
  csvFilePath<-system.file("resources/test/test.csv", package = "synapseClient")
  table<-Table(tableSchema=tableSchema, values=csvFilePath)
  filePath<-tempfile()
  retrievedTable<-synStore(table, retrieveData=TRUE, verbose=FALSE, filePath=filePath)
  checkTrue(is(retrievedTable, "TableFilePath"))
  checkTrue(!is.null(propertyValue(retrievedTable@schema, "id")))
  show(retrievedTable) # make sure 'show' works
  checkTrue(length(retrievedTable@updateEtag)>0)
  # now check that the data frames are the same
  retrievedDataFrame<-synapseClient:::loadCSVasDataFrame(retrievedTable@filePath)
  dataFrame<-read.csv(csvFilePath, header=TRUE)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, retrievedDataFrame)
  # make sure the row labels are valid
  synapseClient:::parseRowAndVersion(row.names(retrievedDataFrame))
}

integrationTestCSVFileWithAsTableColumns <- function() {
  project<-synapseClient:::.getCache("testProject")
  
  csvFilePath<-system.file("resources/test/test.csv", package = "synapseClient")
  tcResult<-as.tableColumns(csvFilePath)
  tableColumns<-tcResult$tableColumns
  tableColumnNames<-list()
  for (column in tableColumns) tableColumnNames<-append(tableColumnNames, column@name)
  tableSchema<-createTableSchema(propertyValue(project, "id"), tableColumns)
  
  table<-Table(tableSchema=tableSchema, values=tcResult$fileHandleId)
  filePath<-tempfile()
  retrievedTable<-synStore(table, retrieveData=TRUE, verbose=FALSE, filePath=filePath)
  checkTrue(is(retrievedTable, "TableFilePath"))
  checkTrue(!is.null(propertyValue(retrievedTable@schema, "id")))
  show(retrievedTable) # make sure 'show' works
  checkTrue(length(retrievedTable@updateEtag)>0)
  # now check that the data frames are the same
  retrievedDataFrame<-synapseClient:::loadCSVasDataFrame(retrievedTable@filePath)
  dataFrame<-read.csv(csvFilePath, header=TRUE)
  # now check that the data frames are the same
  testDataFramesEqual(dataFrame, retrievedDataFrame)
  # make sure the row labels are valid
  synapseClient:::parseRowAndVersion(row.names(retrievedDataFrame))
}

integrationTestSynStoreAndDownloadFiles<-function() {
	project<-synapseClient:::.getCache("testProject")
	
	# String, Integer, Double, Boolean, Date, Filehandleid, Entityid
	tc1 <- TableColumn(name="stringType", columnType="STRING", enumValues=c("one", "two", "three"))
	tc1 <- synStore(tc1)
	tc2 <- TableColumn(name="fileHandleIdType", columnType="FILEHANDLEID")
	tc2 <- synStore(tc2)
	
	pid<-propertyValue(project, "id")
	tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2))
	tschema <- synStore(tschema, createOrUpdate=FALSE)
	
	fileHandleIds<-NULL
	md5s<-NULL
	for (i in 1:2) {
		# upload a file and receive the file handle
		filePath<- tempfile()
		connection<-file(filePath)
		writeChar(sprintf("this is a test %s", sample(999999999, 1)), connection, eos=NULL)
		close(connection)  
		fileHandle<-synapseClient:::chunkedUploadFile(filePath)
		checkTrue(!is.null(fileHandle$id))
		fileHandleIds<-c(fileHandleIds, fileHandle$id)
		md5s<-c(md5s, as.character(tools::md5sum(filePath)))
	}
	
	dataFrame<-data.frame(
			stringType=c("one", "two"), 
			fileHandleIdType=fileHandleIds
	)
	
	myTable <- Table(tschema, values=dataFrame)
	myTable <- synStore(myTable, retrieveData=T)
	
	# download by passing TableDataFrame
	for (i in 1:2) {
		rowIdAndVersion<-rownames(myTable@values)[i]
		downloaded<-synDownloadTableFile(myTable, rowIdAndVersion, "fileHandleIdType")
		checkEquals(as.character(tools::md5sum(downloaded)), md5s[i])
	}
	
	# download by passing TableDataFrame
	tableId<-propertyValue(tschema, "id")
	for (i in 1:2) {
		rowIdAndVersion<-rownames(myTable@values)[i]
		downloaded<-synDownloadTableFile(tableId, rowIdAndVersion, "fileHandleIdType")
		checkEquals(as.character(tools::md5sum(downloaded)), md5s[i])
	}
	
	# download by passing TableDataFrame having id, not schema
	myTable@schema<-tableId
	for (i in 1:2) {
		rowIdAndVersion<-rownames(myTable@values)[i]
		downloaded<-synDownloadTableFile(myTable, rowIdAndVersion, "fileHandleIdType")
		checkEquals(as.character(tools::md5sum(downloaded)), md5s[i])
	}
	
	# download by passing TableFilePath
	tableFilePath<-synTableQuery(sprintf("select * from %s", tableId), loadResult=FALSE)
	checkTrue(is(tableFilePath, "TableFilePath"))
	for (i in 1:2) {
		rowIdAndVersion<-rownames(myTable@values)[i]
		downloaded<-synDownloadTableFile(tableFilePath, rowIdAndVersion, "fileHandleIdType")
		checkEquals(as.character(tools::md5sum(downloaded)), md5s[i])
	}
	
}


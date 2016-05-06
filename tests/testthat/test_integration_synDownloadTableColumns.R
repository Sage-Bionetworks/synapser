# test for synDownloadTableColumns
# 
# Author: brucehoff
###############################################################################

library(rjson)

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

integrationTestDownloadTableColumns<-function() {
	project<-synapseClient:::.getCache("testProject")
	
	tc1 <- TableColumn(name="stringType", columnType="STRING", enumValues=c("one", "two", "three", "four"))
	tc1 <- synStore(tc1)
	tc2 <- TableColumn(name="fileHandleIdType", columnType="FILEHANDLEID")
	tc2 <- synStore(tc2)
	
	pid<-propertyValue(project, "id")
	tschema <- TableSchema(name = "testDataFrameTable", parent=pid, columns=c(tc1, tc2))
	tschema <- synStore(tschema, createOrUpdate=FALSE)
	
	fileHandleIds<-NULL
	md5s<-NULL
	fileNames<-c()
	for (i in 1:2) {
		# upload a file and receive the file handle
		filePath <- tempfile()
		fileNames <- c(fileNames, basename(filePath))
		connection<-file(filePath)
		writeChar(sprintf("this is a test %s", sample(999999999, 1)), connection, eos=NULL)
		close(connection)  
		fileHandle<-synapseClient:::chunkedUploadFile(filePath)
		checkTrue(!is.null(fileHandle$id))
		fileHandleIds<-c(fileHandleIds, fileHandle$id)
		if (i==2) {
			fileHandleToDelete<-fileHandle$id
		}
		md5s<-c(md5s, as.character(tools::md5sum(filePath)))
	}
	
	dataFrame<-data.frame(
			stringType=c("one", "two", "three", "four"), 
			fileHandleIdType=c(fileHandleIds, fileHandleIds) # test the case where fhids occur multiple times in a table
	)
	
	myTable <- Table(tschema, values=dataFrame)
	myTable <- synStore(myTable, retrieveData=T)
	
	# let's make one of the file handles invalid
	uri<- sprintf("/fileHandle/%s", fileHandleToDelete)
	synRestDELETE(uri, endpoint=synapseFileServiceEndpoint())
	
	downloadResult<-synDownloadTableColumns(myTable, "fileHandleIdType")
	
	# check that the names of the result are the file handle IDs
	checkTrue(all(names(downloadResult)==fileHandleIds))
	
	# check that the file name in the result matches the uploaded one and that the file exists
	checkEquals(basename(downloadResult[[1]]), fileNames[1])
	checkTrue(file.exists(downloadResult[[1]]))
	# check that the missing one was not downloaded
	checkTrue(is.null(downloadResult[[2]]))
}


# integration tests for as.TableColumns
# 
# Author: brucehoff
###############################################################################

integrationTest_asTableColumns<-function() {
  tableColumns<-as.tableColumns(system.file("resources/test/withHeaders.csv", package = "synapseClient"))
  checkTrue(!is.null(tableColumns$fileHandleId))
  checkEquals(4, length(tableColumns$tableColumns))
  checkTrue(identical(tableColumns$tableColumns[[1]], 
      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(2))))
  checkTrue(identical(tableColumns$tableColumns[[2]], TableColumn(name="numeric", columnType="DOUBLE")))
  checkTrue(identical(tableColumns$tableColumns[[3]], TableColumn(name="integer", columnType="INTEGER")))
  checkTrue(identical(tableColumns$tableColumns[[4]], TableColumn(name="logical", columnType="BOOLEAN")))
  
  # do the same thing, but starting with a data frame, rather than a file
  dataframe<-read.csv(system.file("resources/test/withHeaders.csv", package = "synapseClient"))
  tableColumns<-as.tableColumns(dataframe)
  
  checkTrue(!is.null(tableColumns$fileHandleId))

  checkEquals(4, length(tableColumns$tableColumns))
  checkTrue(identical(tableColumns$tableColumns[[1]], 
      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(2))))
  checkTrue(identical(tableColumns$tableColumns[[2]], TableColumn(name="numeric", columnType="DOUBLE")))
  checkTrue(identical(tableColumns$tableColumns[[3]], TableColumn(name="integer", columnType="INTEGER")))
  checkTrue(identical(tableColumns$tableColumns[[4]], TableColumn(name="logical", columnType="BOOLEAN")))
  
  ## test doFullFileScan
  n <- 100000
  tDF <- data.frame(string=sample(c("one", "two", "three"), size=n, replace=T),
                    double=rnorm(n),
                    stringsAsFactors=FALSE)
  tDF$string[n] <- "asdfasdfasdfasdfasdf"
  tcsTrue <- as.tableColumns(tDF)
  checkTrue(identical(tcsTrue$tableColumns[[1]], 
                      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(max(nchar(tDF$string))))))
  tcsFalse <- as.tableColumns(tDF, doFullFileScan=FALSE)
  checkTrue(identical(tcsFalse$tableColumns[[1]], 
                      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(5))))
  
}

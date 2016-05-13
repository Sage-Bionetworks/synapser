# integration tests for as.TableColumns
# 
# Author: brucehoff
###############################################################################

integrationTest_asTableColumns<-function() {
  tableColumns<-as.tableColumns(system.file("resources/test/withHeaders.csv", package = "synapseClient"))
  expect_true(!is.null(tableColumns$fileHandleId))
  expect_equal(4, length(tableColumns$tableColumns))
  expect_true(identical(tableColumns$tableColumns[[1]], 
      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(2))))
  expect_true(identical(tableColumns$tableColumns[[2]], TableColumn(name="numeric", columnType="DOUBLE")))
  expect_true(identical(tableColumns$tableColumns[[3]], TableColumn(name="integer", columnType="INTEGER")))
  expect_true(identical(tableColumns$tableColumns[[4]], TableColumn(name="logical", columnType="BOOLEAN")))
  
  # do the same thing, but starting with a data frame, rather than a file
  dataframe<-read.csv(system.file("resources/test/withHeaders.csv", package = "synapseClient"))
  tableColumns<-as.tableColumns(dataframe)
  
  expect_true(!is.null(tableColumns$fileHandleId))

  expect_equal(4, length(tableColumns$tableColumns))
  expect_true(identical(tableColumns$tableColumns[[1]], 
      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(2))))
  expect_true(identical(tableColumns$tableColumns[[2]], TableColumn(name="numeric", columnType="DOUBLE")))
  expect_true(identical(tableColumns$tableColumns[[3]], TableColumn(name="integer", columnType="INTEGER")))
  expect_true(identical(tableColumns$tableColumns[[4]], TableColumn(name="logical", columnType="BOOLEAN")))
  
  ## test doFullFileScan
  n <- 100000
  tDF <- data.frame(string=sample(c("one", "two", "three"), size=n, replace=T),
                    double=rnorm(n),
                    stringsAsFactors=FALSE)
  tDF$string[n] <- "asdfasdfasdfasdfasdf"
  tcsTrue <- as.tableColumns(tDF)
  expect_true(identical(tcsTrue$tableColumns[[1]], 
                      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(max(nchar(tDF$string))))))
  tcsFalse <- as.tableColumns(tDF, doFullFileScan=FALSE)
  expect_true(identical(tcsFalse$tableColumns[[1]], 
                      TableColumn(name="string", columnType="STRING", maximumSize=as.integer(5))))
  
}

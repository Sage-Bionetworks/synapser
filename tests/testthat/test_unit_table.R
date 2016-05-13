# unit tests for supporting functions in Table.R
# 
# Author: brucehoff
###############################################################################

unitTest_parseRowAndVersion<-function() {
  expect_equal(synapseClient:::parseRowAndVersion(c("1_2", "2_3", "3_2")), rbind(c(1,2,3), c(2,3,2)))
	expect_equal(synapseClient:::parseRowAndVersion(c("1_2", "2_3", "3")), rbind(c(1,2,NA), c(2,3,NA)))
}

unitTest_findSynIdInSql<-function() {
  expect_equal("syn123", synapseClient:::findSynIdInSql("select * from syn123"))
  expect_equal("syn123", synapseClient:::findSynIdInSql("select * from syn123 where foo=bar"))
  expect_equal("syn123", synapseClient:::findSynIdInSql("select * FrOm SyN123 where foo=bar"))
  expect_equal("syn123", synapseClient:::findSynIdInSql("select * from\tsyn123\twhere foo=bar"))
}

# checks values and column labels, but not row labels
# we have to use this to compare data frames that have NAs
dataFramesAreSame<-function(df1, df2) {
  if (nrow(df1)!=nrow(df2) || ncol(df1)!=ncol(df2)) return(FALSE)
  if (any(names(df1)!=names(df2))) return(FALSE)
  if (nrow(df1)==0 || ncol(df1)==0) return(TRUE)
  for (r in 1:nrow(df1)) {
    for (c in 1:ncol(df1)) {
      if (!identical(df1[r,c], df2[r,c])) return(FALSE)
    }
  }
  TRUE
}

unitTest_csvRoundTrip<-function() {
  dataFrame <- data.frame(sweet=c(1:5, 1.234e-10, 5.678e+10, NA), sweet2=c(NA, 6:10, 1.234567, 9.876543))
  filePath<-tempfile()
  synapseClient:::writeDataFrameToCSV(dataFrame, filePath)
  readBackIn<-synapseClient:::readDataFrameFromCSV(filePath)
  expect_true(dataFramesAreSame(dataFrame,readBackIn))
}
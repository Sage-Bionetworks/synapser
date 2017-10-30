# Utilities for working with table in synapser
# 
# Author: kimyen
###############################################################################

saveToCsv <- function(dataFrame, filePath) {
  for (i in 1:dim(dataFrame)[2]) {
    if (is.numeric(dataFrame[[i]])) {
      dataFrame[[i]][is.nan(dataFrame[[i]])]<-"NaN"
    } else if (is(dataFrame[[i]], "POSIXct")) {
      # convert POSIXct before uploading to Synapse
      dataFrame[[i]]<-format(as.POSIXlt(dataFrame[[i]], 'UTC', usetz=TRUE), "%Y-%m-%d %H:%M:%S.000")
    }
  }
  write.csv(x=dataFrame, file=filePath, row.names=FALSE, na="")
}
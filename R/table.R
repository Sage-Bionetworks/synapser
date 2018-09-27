# Utilities for working with table in synapser
#
# Author: kimyen
###############################################################################

# writing a dataFrame to a csv
.saveToCsv <- function(dataFrame, filePath) {
  if (!is.data.frame(dataFrame)) {
    stop("dataFrame arg is not a data frame.")
  }
  if (nrow(dataFrame) != 0) {
    for (i in 1:dim(dataFrame)[2]) {
      if (is.numeric(dataFrame[[i]])) {
        dataFrame[[i]][is.nan(dataFrame[[i]])] <- "NaN"
      } else if (is(dataFrame[[i]], "POSIXct")) {
        # convert POSIXct before uploading to Synapse
        dataFrame[[i]] <- format(
          as.POSIXlt(dataFrame[[i]], "UTC", usetz = TRUE),
          "%Y-%m-%d %H:%M:%S.000"
        )
      }
    }
  }
  write.csv(x = dataFrame, file = filePath, row.names = FALSE, na = "")
}

# reading a csv file and returning a data.frame
.readCsv <- function(filePath, colClasses=NA) {
  tryCatch(
    {
      read.csv(
        filePath,
        encoding = "UTF-8",
        stringsAsFactors = FALSE,
        check.names = FALSE,
        na.strings = c(""),
        colClasses = colClasses
      )
    },
    error = function(e) {
      stopifnot(e$message == "first five rows are empty: giving up")
      data.frame()
    }
  )
}

# This method is only tested to work with input of type "character"
.convertListOfSchemaTypeToRType <- function(list, type) {
  if (length(list) > 0 && !is.na(list)) { # make sure the the list exists
    if (type=="BOOLEAN") {
      as.logical(list)
    } else if (type == "DATE") {
      as.POSIXct(as.numeric(list)/1000, origin="1970-01-01")
    } else if (type == "INTEGER"){
      as.integer(list)
    } else if (type %in% c("STRING", "FILEHANDLEID", "ENTITYID", "LINK", "LARGETEXT", "USERID")){
      as.character(list)
    } else if (type == "DOUBLE"){
      as.numeric(list)
    } else {
      stop(paste("Cannot coerce schema type", schemaType, "to a matching R type."))
    }
  }
}

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
      } else if (is(dataFrame[[i]], "POSIXt")) {
        # convert POSIX time to the same precision offered by Synapse
        dataFrame[[i]] <- format(
          as.POSIXlt(dataFrame[[i]], "UTC", usetz = TRUE),
          "%Y-%m-%d %H:%M:%OS3"
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
.convertListOfSynapseTypeToRType <- function(list, type) {
  if (length(list) > 0 && !is.na(list)) { # make sure the the list exists
    if (type=="BOOLEAN") {
      as.logical(list)
    } else if (type == "DATE") {
      as.POSIXlt(as.numeric(list)/1000, origin="1970-01-01", tz = "UTC")
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

.convertListToSynapseType <- function(list, type) {
  if (length(list) > 0 && !is.na(list)) { # make sure the the list exists
    if (type=="BOOLEAN") {
      as.logical(list)
    } else if (type == "DATE") {
      if (is(list, "POSIXt")) {
        as.numeric(list) * 1000 # Convert date to timestamp
      } else if (is(list, "numeric")) {
        list
      } else {
        stop(paste("Cannot convert type ", class(list), "to a ", type, "."))
      }
    } else if (type == "INTEGER"){
      as.integer(list)
    } else if (type %in% c("STRING", "FILEHANDLEID", "ENTITYID", "LINK", "LARGETEXT", "USERID")){
      as.character(list)
    } else if (type == "DOUBLE"){
      as.numeric(list)
    } else {
      stop(paste("Cannot convert type ", class(list), "to a ", type, "."))
    }
  }
}

.convertToRTypeFromSchema <- function(df, columnSchema) {
  types <- .extractColumnTypesFromSchema(columnSchema)
  # convert each column to the most likely desired type
  df <- data.frame(
    Map(.convertListOfSynapseTypeToRType, list = df, type = types),
    stringsAsFactors = F)
  
  # The Map function mangles column names (which are in the Schema), so let's fix them
  colnames(df) <- .extractColumnNamesFromSchema(columnSchema)
  df
}

.convertToSynapseSchema <- function(df, columnSchema) {
  types <- .extractColumnTypesFromSchema(columnSchema)
  # convert each column to the most likely desired type
  df <- data.frame(
    Map(.convertListToSynapseType, list = df, type = types),
    stringsAsFactors = F)
  
  # The Map function mangles column names (which are in the Schema), so let's fix them
  colnames(df) <- .extractColumnNamesFromSchema(columnSchema)
  df
}

.extractColumnTypesFromSchema <- function(columnSchema) {
  unlist(lapply(columnSchema["::"], function(x){x$columnType}))
}

.extractColumnNamesFromSchema <- function(columnSchema) {
  unlist(lapply(columnSchema["::"], function(x){x$name}))
}

.readWithOrWithoutSchema <- function(object) {
  # We can get the column types from the schema, which is either in $schema or $headers
  # We check the schema first because this is more likely to be accurate than the headers (e.g. after a local table schema change)
  if (!is.null(object$schema)) {
    # We read the CSV as a "character" to prevent early coercion (and therefore data loss)
    df <- .readCsv(object$filepath, "character")
    .convertToRTypeFromSchema(df, object$schema$columns_to_store)
  } else if (!is.null(object$headers)) {
    df <- .readCsv(object$filepath, "character")
    .convertToRTypeFromSchema(df, object$headers)
  } else {
    .readCsv(object$filepath) # let readCsv decide types
  }
}

.saveToCsvWithSchema <- function(schema, values, file) {
  df <- .convertToSynapseSchema(values, schema$columns_to_store)
  .saveToCsv(df, file)
}

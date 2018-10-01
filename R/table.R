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

# Converts data downloaded from Synapse to an appropriate data type in R
.convertToRType <- function(list, synapseType) {
  if (length(list) > 0 && !is.na(list)) { # make sure the the list exists
    if (synapseType=="BOOLEAN") {
      as.logical(list)
    } else if (synapseType == "DATE") {
      as.POSIXlt(as.numeric(list)/1000, origin="1970-01-01", tz = "UTC")
    } else if (synapseType == "INTEGER"){
      tryCatch(
        as.integer(list),
        warning = function(x) { as.numeric(list) } # in case the integers are outside of the bounds of R integer
      )
    } else if (synapseType %in% c("STRING", "FILEHANDLEID", "ENTITYID", "LINK", "LARGETEXT", "USERID")){
      as.character(list)
    } else if (synapseType == "DOUBLE"){
      as.numeric(list)
    } else {
      list
    }
  }
}

# Convert data to a format expected by Synapse prior to uploading
.convertToSynapseType <- function(list, synapseType) {
  if (length(list) > 0 && !is.na(list)) { # make sure the the list exists
    if (synapseType=="BOOLEAN") {
      as.logical(list)
    } else if (synapseType == "DATE") {
      if (is(list, "POSIXt")) {
        as.numeric(list) * 1000 # Convert date to timestamp
      } else if (is(list, "numeric")) {
        list
      } else {
        stop(paste("Cannot convert type ", class(list), "to a ", synapseType, "."))
      }
    } else if (synapseType == "INTEGER"){
      tryCatch(
        as.integer(list),
        warning = function(x) { as.numeric(list) } # in case the integers are outside of the bounds of R integer
      )
    } else if (synapseType %in% c("STRING", "FILEHANDLEID", "ENTITYID", "LINK", "LARGETEXT", "USERID")){
      as.character(list)
    } else if (synapseType == "DOUBLE"){
      as.numeric(list)
    } else {
      list
    }
  }
}

# Converts a dataframe downloaded from Synapse to R types based on a valid Table schema
.convertToRTypeFromSchema <- function(df, columnSchema) {
  types <- .extractColumnTypes(columnSchema)
  # convert each column to the most likely desired type
  df <- data.frame(
    Map(.convertToRType, list = df, synapseType = types),
    stringsAsFactors = F)
  
  # The Map function mangles column names (which are in the Schema), so let's fix them
  colnames(df) <- .extractColumnNames(columnSchema)
  df
}

# Converts a dataframe to formats expected by Synapse based on a valid Table schema prior to upload
.convertToSynapseTypeFromSchema <- function(df, columnSchema) {
  types <- .extractColumnTypes(columnSchema)
  # convert each column to the most likely desired type
  df <- data.frame(
    Map(.convertToSynapseType, list = df, synapseType = types),
    stringsAsFactors = F)
  
  # The Map function mangles column names (which are in the Schema), so let's fix them
  colnames(df) <- .extractColumnNames(columnSchema)
  df
}

# Extract Synapse column types from a valid Table schema
.extractColumnTypes <- function(columnSchema) {
  unlist(lapply(columnSchema["::"], function(x){x$columnType}))
}

# Extract Synapse column names from a valid Table schema
.extractColumnNames <- function(columnSchema) {
  unlist(lapply(columnSchema["::"], function(x){x$name}))
}

# Read the CSV of a Table with an associated schema, and coerce each column based on the schema type
.readCsvBasedOnSchema <- function(object) {
  # We can get the column types from the schema, which is either in $schema or $headers
  # We check the schema field first because this is more likely to be accurate than the headers (e.g. after a local table schema change)
  if (!is.null(object$schema)) {
    # We read every column in the CSV as "character" to prevent early coercion (and therefore data loss)
    df <- .readCsv(object$filepath, "character")
    .convertToRTypeFromSchema(df, object$schema$columns_to_store)
  } else if (!is.null(object$headers)) {
    df <- .readCsv(object$filepath, "character")
    .convertToRTypeFromSchema(df, object$headers)
  } else { # There is no schema provided
    .readCsv(object$filepath) # let readCsv decide types
  }
}

# Modify columns of a dataframe to a corresponding value in Synapse based on the Synapse type of the
# column and save the CSV. 
.saveToCsvWithSchema <- function(schema, values, file) {
  df <- .convertToSynapseTypeFromSchema(values, schema$columns_to_store)
  .saveToCsv(df, file)
}

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
      } else if (methods::is(dataFrame[[i]], "POSIXt")) {
        dataFrame[[i]] <- .convertPOSIXToCharacterTimestamp(dataFrame[[i]])
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

# Converts a POSIXt time to a character timestamp in milliseconds
.convertPOSIXToCharacterTimestamp <- function(list) {
  list <- trimws(format(as.numeric(list) * 1000, scientific = FALSE))
  # Format coerces NA to "NA", so change them back (this will only be for dates)
  list[list == "NA"] <- NA 
  list
}

# Converts data downloaded from Synapse to an appropriate data type in R
.convertToRType <- function(list, synapseType) {
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

# Convert data to a format expected by Synapse prior to uploading
.convertToSynapseType <- function(list, synapseType) {
  if (synapseType=="BOOLEAN") {
    as.logical(list)
  } else if (synapseType == "DATE") {
    if (methods::is(list, "POSIXt")) {
      .convertPOSIXToCharacterTimestamp(list)
    } else if (methods::is(list, "numeric")) {
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

.ROW_ID <- list(name = 'ROW_ID', columnType = 'STRING', fake_id = -1)
.ROW_VERSION <- list(name = 'ROW_VERSION', columnType = 'STRING', fake_id = -1)
.ROW_ETAG <- list(name = 'ROW_ETAG', columnType = 'STRING', fake_id = -1)

# ensure that the columnSchema matches the data.frame columns
.ensureMetaCols <- function(df, columnSchema) {
  dfCols <- colnames(df)
  schemaCols <- .extractColumnNames(columnSchema)
  if (length(dfCols) != length(schemaCols)) {
    if (is.element("ROW_ID", dfCols) && !is.element("ROW_ID", schemaCols)) {
      columnSchema$insert(0, .ROW_ID)
    }
    if (is.element("ROW_VERSION", dfCols) && !is.element("ROW_VERSION", schemaCols)) {
      columnSchema$insert(1, .ROW_VERSION)
    }
    if (is.element("ROW_ETAG", dfCols) && !is.element("ROW_ETAG", schemaCols)) {
      columnSchema$insert(2, .ROW_ETAG)
    }
  }
  columnSchema
}

# Converts a dataframe downloaded from Synapse to R types based on a valid Table schema
.convertToRTypeFromSchema <- function(df, columnSchema) {
  columnSchema <- .ensureMetaCols(df, columnSchema)
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
  cols <- schema$columns_to_store
  if (is.vector(cols)) {
    df <- .convertToSynapseTypeFromSchema(values, cols)
    .saveToCsv(df, file)
  } else {
    .saveToCsv(values, file)
  }
}

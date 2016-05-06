\name{Table}
\alias{Table}
\docType{methods}
\title{
Table Constructor
}
\description{Constructor for a table, which can subsequently be stored in Synapse}
\usage{Table(tableSchema, values)}
\arguments{
  \item{tableSchema}{
  the schema for the table, an object of the type TableSchema or its ID
  }
  \item{values}{
  the values to be stored in the table, either a data frame, the (character) file path to a CSV file, 
  or the (integer) ID of an uploaded file (as returned by as.tableColumns).
  }
  \item{linesToSkip}{
	When 'values' is a file path or ID of an uploaded file: The number of lines to skip from the start of the file. The default value of 0 will be used if this is not provided by the caller.  }
  \item{quoteCharacter}{
  	When 'values' is a file path or ID of an uploaded file: The character to used for quoted elements in the provided file. The default character '"' will be used if this is not provided by the caller.
  }
  \item{isFirstLineHeader}{
  	When 'values' is a file path or ID of an uploaded file: Is the first line a header? The default value of 'true' will be used if this is not provided by the caller.
  }
 \item{escapeCharacter}{
  	When 'values' is a file path or ID of an uploaded file: The escape character used for escaping a separator or quote. The default character '\\' will be used if this is not provided by the caller.
  }
  \item{lineEnd}{
  	When 'values' is a file path or ID of an uploaded file: The line feed terminator to be used for the resulting file. The default value of '\\n' will be used if this is not provided by the caller.
  }
  \item{separator}{
  	When 'values' is a file path or ID of an uploaded file: The delimiter to used for separating entries in the provided file. The default character ',' will be used if this is not provided by the caller. For tab-separated values use '\\t'
  }
}
\seealso{
\code{\link{TableSchema},\link{RowList},\link{synStore},\link{synDownloadTableFile},
\link{as.tableColumns},\link{synGetColumns}}
}

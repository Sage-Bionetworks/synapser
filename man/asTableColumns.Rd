\name{as.tableColumns}
\alias{as.tableColumns}
\docType{methods}
\title{
as.tableColumns
}
\description{
Create Table Columns based on a data frame
}
\usage{
  as.tableColumns(source, doFullFileScan=TRUE, ... )
}
\arguments{
  \item{source}{
	 A data frame or path to a csv file
  }
  \item{doFullFileScan}{
  Should the services suggest column types based on the entire file (TRUE - default) or the first 1000 rows of the file (FALSE). For large homogeneous files, doFullFileScan=FALSE will be faster, but may miss-classify the column types.
  }
  \item{linesToSkip}{
	When 'source' is a file path: The number of lines to skip from the start of the file. The default value of 0 will be used if this is not provided by the caller.  }
  \item{quoteCharacter}{
  	When 'source' is a file path: The character to used for quoted elements in the provided file. The default character '"' will be used if this is not provided by the caller.
  }
 \item{escapeCharacter}{
  	When 'source' is a file path: The escape character used for escaping a separator or quote. The default character '\\' will be used if this is not provided by the caller.
  }
  \item{lineEnd}{
  	When 'source' is a file path: The line feed terminator to be used for the resulting file. The default value of '\\n' will be used if this is not provided by the caller.
  }
  \item{separator}{
  	When 'source' is a file path: The delimiter to used for separating entries in the provided file. The default character ',' will be used if this is not provided by the caller. For tab-separated values use '\\t'
  }
}
\value{
A list containing two fields, 'tableColumns' and 'fileHandleId'.

tableColumns: A list of TableColumns matching the columns in the given file or data frame in terms of name and type.

fileHandleId: The ID of the uploaded file, suitable for passing to the Table constructor along with a schema. (See 'Table'.)
}
\seealso{
\code{\link{TableColumn},\link{Table}}
}

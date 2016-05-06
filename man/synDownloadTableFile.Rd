\name{synDownloadTableFile}
\alias{synDownloadTableFile}
\title{
synDownloadTableFile
}
\description{
Download a file associated with a cell in a Table
}
\usage{
synDownloadTableFile(table, rowIdAndVersion, columnName, downloadLocation=NULL, ifcollision="keep.both")

}
\arguments{
\item{table}{
a Table object or its Synapse Id
}
\item{rowIdAndVersion}{
the row ID and version in the form "r_v", as found in the row labels of a query result returned as a data frame
}
\item{columnName}{
the column name, as found in the column labels of a query result returned as a data frame
}
\item{downloadLocation}{
the folder into which the file should be downloaded.  If NULL then a default location will be used
}
\item{ifcollision}{
 if.collision is one of "keep.both", "keep.local", or "overwrite.local", 
telling the system what to do if a different file is found at the given local file location
}
}
\details{
When downloading, file caching is used:  If the file has already been downloaded (and not modified 
and/or ifcollision is set to "keep.local") then the file will not be downloaded a second time.
}
\value{
The path of the downloaded file.
}

\seealso{
\code{\link{synTableQuery}}
}

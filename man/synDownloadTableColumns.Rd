\name{synDownloadTableColumns}
\alias{synDownloadTableColumns}
\docType{methods}
\title{
synDownloadTableColumns
}
\description{
Bulk download of table-associated files.
}
\usage{
synDownloadTableColumns(table, columns)
}
\arguments{
\item{table}{            table query result\cr
}
\item{columns}{           a list of column names as character strings}
}
\value{
 a named list whose names are file handle IDs and values are paths to downloaded files in the local file system
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
tableId<-"syn1234567"
results <- synTableQuery(sprintf("select * from \%s ", tableId))
fileAttachments<-synDownloadTableColumns(results, "Attachments")
}
}




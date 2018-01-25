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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{ 
 a named list whose names are file handle IDs and values are paths to downloaded files in the local file system
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
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




%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
synDownloadTableColumns(table, columns, downloadLocation=NULL)
}
\arguments{
\item{table}{               table query result\cr
}
\item{columns}{             a list of column names as strings\cr
}
\item{downloadLocation}{    directory into which to download the files}
}
\value{
 a dictionary from file handle ID to path in the local file system.
}



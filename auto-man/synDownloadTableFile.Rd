%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDownloadTableFile}
\alias{synDownloadTableFile}
\docType{methods}
\title{
synDownloadTableFile
}
\description{
Downloads a file associated with a row in a Synapse table.
}
\usage{
synDownloadTableFile(table, column, downloadLocation=NULL, rowId=NULL, versionNumber=NULL, rowIdAndVersion=NULL, ifcollision=keep.both)
}
\arguments{
\item{table}{            schema object, table query result or synapse ID\cr
}
\item{column}{           a Column object, the ID of a column or its name\cr
}
\item{downloadLocation}{ location in local file system to download the file\cr
}
\item{rowId}{            row number that holds the file handle\cr
}
\item{versionNumber}{    version number of the row that holds the file handle\cr
}
\item{rowIdAndVersion}{  row number and version in one string, "101_2" for version 2 of row 101\cr
}
\item{ifcollision}{      Determines how to handle file collisions.\cr
                         May be "overwrite.local", "keep.local", or "keep.both".\cr
                         Defaults to "keep.both".}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a dictionary with 'path'.
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%    file_info = syn.downloadTableFile(table, rowId=1, versionNumber=1, column="cover_art", downloadLocation=".")
%    print(file_info['path'])
%}
}




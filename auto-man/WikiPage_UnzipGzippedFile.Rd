%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUnzipGzippedFile}
\alias{WikiPage_synUnzipGzippedFile}
\docType{methods}
\title{
WikiPage :  unzip_gzipped_file
}
\description{
Unzip the gzipped file and return the file path to the unzipped file.
If the file is a markdown file, the content will be printed.
}
\usage{
synUnzipGzippedFile(file_path)
}
\arguments{
\item{file_path}{(str) The path to the gzipped file.}
}
\value{
The file path to the unzipped file.
}
\examples{
\dontrun{
## Unzip a gzipped file
    file_path = "path/to/file.md.gz"
    unzipped_file_path = WikiPage.unzip_gzipped_file(file_path)
}
}
\keyword{WikiPage}

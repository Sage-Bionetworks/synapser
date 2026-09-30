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
    unzipped_file_path = synUnzipGzippedFile(file_path)
}
}
\keyword{WikiPage}

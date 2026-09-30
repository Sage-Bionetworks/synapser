\name{FileOptions}
\alias{FileOptions}
\docType{class}
\title{
FileOptions
}
\format{An S3-style class object.}
\description{
Configuration options specific to File entities when using the factory methods.

This dataclass allows you to customize how File entities are handled during
retrieval, including download behavior, file location, and collision handling.
}
\usage{
FileOptions(download_file=TRUE, download_location=NULL, if_collision="keep.both")
}
\arguments{
\item{download_file}{(bool) Whether to automatically download the file content when retrieving the File entity. If TRUE, the file will be downloaded to the local filesystem. If FALSE, only the metadata will be retrieved. Default is TRUE.}
\item{download_location}{(Optional[str]) The local directory path where the file should be downloaded. If NULL, the file will be downloaded to the default Synapse cache location. If specified, must be a valid directory path. Default is NULL.}
\item{if_collision}{(str) Strategy to use when a file with the same name already exists at the download location. Valid options are:\cr
- "keep.both": Keep both files by appending a number to the new file\cr
- "overwrite.local": Overwrite the existing local file\cr
- "keep.local": Keep the existing local file and skip download\cr
Default is "keep.both".}
}
\value{
NULL
}
\examples{
\dontrun{
    # Configure file download options:
    library(synapser)

    # Download file to specific location with overwrite
    file_options = FileOptions(
        download_file = TRUE,
        download_location = "/path/to/downloads/",
        if_collision = "overwrite.local"
    )

    # Only retrieve metadata, don't download file content
    metadata_only = FileOptions(download_file = FALSE)
}
}
\section{Methods}{
\itemize{
\item \code{FileOptions(download_file=TRUE, download_location=NULL, if_collision="keep.both")}: Constructor for \code{\link{FileOptions}}
}
}


\name{synGetFromPath}
\alias{File_synGetFromPath}
\docType{methods}
\title{
File :  from_path
}
\description{
Get the file from Synapse. If the path of the file matches multiple files
within Synapse the first one found will be returned. The other matching
files will be printed to the console.


Wrapper for \code{\link[=synGet]{synGet}}.
}
\usage{
synGetFromPath(cls, path, synapse_client=NULL)
}
\arguments{
\item{cls}{(File) The File class (or an existing File instance) to dispatch this call to.}
\item{path}{(str) The path to the file on disk.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The file object.
}
\examples{
\dontrun{
## Using this function
    # Assuming you have a file at the path "path/to/file.txt":
    file_instance = File |> synGetFromPath(path = "path/to/file.txt")
}
}
\keyword{File}

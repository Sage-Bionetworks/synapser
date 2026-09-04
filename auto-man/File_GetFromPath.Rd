%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetFromPath}
\alias{synGetFromPath}
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
synGetFromPath(instance, path, synapse_client=NULL)
}
\arguments{
\item{instance}{(File) The File instance to operate on.}
\item{path}{(str) The path to the file on disk.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The file object.
}
\examples{
\dontrun{
## Using this function
    Assuming you have a file at the path "path/to/file.txt":

        file_instance = await File.from_path_async(path="path/to/file.txt")
}
}
\keyword{File}

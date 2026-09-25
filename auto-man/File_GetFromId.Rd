%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetFromId}
\alias{File_synGetFromId}
\docType{methods}
\title{
File :  from_id
}
\description{
Wrapper for \code{\link[=synGet]{synGet}}.
}
\usage{
synGetFromId(cls, synapse_id, synapse_client=NULL)
}
\arguments{
\item{cls}{(File) The File class (or an existing File instance) to dispatch this call to.}
\item{synapse_id}{(str) The ID of the file in Synapse.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The file object.
}
\examples{
\dontrun{
## Using this function
    Assuming you have a file with the ID "syn123":

        file_instance = await File.from_id_async(synapse_id="syn123")
}
}
\keyword{File}

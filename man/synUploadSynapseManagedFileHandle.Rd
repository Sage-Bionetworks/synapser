\name{synUploadSynapseManagedFileHandle}
\alias{synUploadSynapseManagedFileHandle}
\docType{methods}
\title{
synUploadSynapseManagedFileHandle
}
\description{
Uploads a file to a Synapse managed S3 storage. This is the preferred function for uploading files to Tables.
Deprecated in synapser 0.4. Will be removed in synapser 0.5.
}
\usage{
synUploadSynapseManagedFileHandle(path, storageLocationId=NULL, mimetype=NULL)
}
\arguments{
\item{path}{ path to the file\cr
}
\item{storageLocationId}{ storageLocationId of a S3 storage location. pass in a value if you wish to use an ExternalS3StorageLocation\cr
}
\item{mimetype}{ MIME type of the file, if known.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a new FileHandle (the metadata for the uploaded file) as a named list 
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
\examples{
}




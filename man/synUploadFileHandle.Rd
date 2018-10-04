\name{synUploadFileHandle}
\alias{synUploadFileHandle}
\docType{methods}
\title{
synUploadFileHandle
}
\description{
Uploads the file in the provided path (if necessary) to a storage location based on project settings.
Returns a new FileHandle as a named list to represent the stored file.
Deprecated in synapser 0.4. Will be removed in synapser 0.5.
}
\usage{
synUploadFileHandle(path, parent, synapseStore=TRUE, mimetype=NULL, md5=NULL, file_size=NULL, file_type=NULL)
}
\arguments{
\item{path}{ file path to the file being uploaded\cr
}
\item{parent}{ parent of the entity to which we upload.\cr
}
\item{synapseStore}{ If FALSE, will not upload the file, but instead create an ExternalFileHandle that references the file on the local machine.\cr
                     If TRUE, will upload the file based on StorageLocation determined by the entity_parent_id\cr
}
\item{mimetype}{ The MIME type metadata for the uploaded file\cr
}
\item{md5}{ The MD5 checksum for the file, if known. Otherwise if the file is a local file, it will be calculated automatically.\cr
}
\item{file_size}{ The size the file, if known. Otherwise if the file is a local file, it will be calculated automatically.\cr
}
\item{file_type}{optional named parameter:  The MIME type the file, if known. Otherwise if the file is a local file, it will be calculated automatically.}
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




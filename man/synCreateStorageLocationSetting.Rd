\name{synCreateStorageLocationSetting}
\alias{synCreateStorageLocationSetting}
\docType{methods}
\title{
synCreateStorageLocationSetting
}
\description{
Creates an IMMUTABLE storage location based on the specified type.
}
\usage{
synCreateStorageLocationSetting(storage_type, ...)
}
\arguments{
\item{storage_type}{ the type of the StorageLocationSetting to create\cr
}
\item{...}{fields necessary for creation of the specified storage_type, as described below}
}
\details{
For each storage_type, the following named values should be specified:\cr\cr
ExternalObjectStorage: (S3-like (e.g. AWS S3 or Openstack) bucket not accessed by Synapse)\cr
- endpointUrl: endpoint URL of the S3 service (for example: 'https://s3.amazonaws.com')\cr
- bucket: the name of the bucket to use\cr\cr
ExternalS3Storage: (Amazon S3 bucket accessed by Synapse)\cr
- bucket: the name of the bucket to use\cr\cr
ExternalStorage: (SFTP or FTP storage location not accessed by Synapse)\cr
- url: the base URL for uploading to the external destination\cr
- supportsSubfolders(optional): does the destination support creating subfolders under the base url (default: false)\cr\cr
ProxyStorage: (a proxy server that controls access to a storage)\cr
- secretKey: The encryption key used to sign all pre-signed URLs used to communicate with the proxy.\cr
- proxyUrl: The HTTPS URL of the proxy used for upload and download.\cr
\cr
Optional named arguments for ALL types:\cr
- banner: The optional banner to show every time a file is uploaded\cr
- description: The description to show the user when the user has to choose which upload destination to use\cr
}
\value{
 the created StorageLocationSetting
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




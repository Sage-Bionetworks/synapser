%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreateStorageLocationSetting}
\alias{synCreateStorageLocationSetting}
\docType{methods}
\title{
synCreateStorageLocationSetting
}
\description{
Creates an IMMUTABLE storage location based on the specified type.

For each storage_type, the following kwargs should be specified:
ExternalObjectStorage: (S3-like (e.g. AWS S3 or Openstack) bucket not accessed by Synapse)
 - endpointUrl: endpoint URL of the S3 service (for example: 'https://s3.amazonaws.com')
 - bucket: the name of the bucket to use
ExternalS3Storage: (Amazon S3 bucket accessed by Synapse)
 - bucket: the name of the bucket to use
ExternalStorage: (SFTP or FTP storage location not accessed by Synapse)
 - url: the base URL for uploading to the external destination
 - supportsSubfolders(optional): does the destination support creating subfolders under the base url (default: false)
ProxyStorage: (a proxy server that controls access to a storage)
 - secretKey: The encryption key used to sign all pre-signed URLs used to communicate with the proxy.
 - proxyUrl: The HTTPS URL of the proxy used for upload and download.

Optional kwargs for ALL types:
 - banner: The optional banner to show every time a file is uploaded
 - description: The description to show the user when the user has to choose which upload destination to use
}
\usage{
synCreateStorageLocationSetting(storage_type, kwargs=NULL)
}
\arguments{
\item{storage_type}{ the type of the StorageLocationSetting to create\cr
}
\item{kwargs}{optional named parameter:  fields necessary for creation of the specified storage_type}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a dict of the created StorageLocationSetting
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
%
%}
}




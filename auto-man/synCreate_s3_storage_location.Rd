%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreate_s3_storage_location}
\alias{synCreate_s3_storage_location}
\docType{methods}
\title{
synCreate_s3_storage_location
}
\description{
Create a storage location in the given parent, either in the given folder or by creating a new
folder in that parent with the given name. This will both create a StorageLocationSetting,
and a ProjectSetting together, optionally creating a new folder in which to locate it,
and optionally enabling this storage location for access via STS. If enabling an existing folder for STS,
it must be empty.
}
\usage{
synCreate_s3_storage_location(parent=NULL, folder_name=NULL, folder=NULL, bucket_name=NULL, base_key=NULL, sts_enabled=FALSE)
}
\arguments{
\item{parent}{              The parent in which to locate the storage location (mutually exclusive with folder)\cr
}
\item{folder_name}{         The name of a new folder to create (mutually exclusive with folder)\cr
}
\item{folder}{              The existing folder in which to create the storage location\cr
                                (mutually exclusive with folder_name)\cr
}
\item{bucket_name}{         The name of an S3 bucket, if this is an external storage location,\cr
                                if None will use Synapse S3 storage\cr
}
\item{base_key}{            The base key of within the bucket, None to use the bucket root,\cr
                                only applicable if bucket_name is passed\cr
}
\item{sts_enabled}{         Whether this storage location should be STS enabled}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a 3-tuple of the synapse Folder, a the storage location setting, and the project setting dictionaries
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

}




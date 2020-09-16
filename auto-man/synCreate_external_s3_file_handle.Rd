%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreate_external_s3_file_handle}
\alias{synCreate_external_s3_file_handle}
\docType{methods}
\title{
synCreate_external_s3_file_handle
}
\description{
Create an external S3 file handle for e.g. a file that has been uploaded directly to
an external S3 storage location.
}
\usage{
synCreate_external_s3_file_handle(bucket_name, s3_file_key, file_path, parent=NULL, storage_location_id=NULL, mimetype=NULL)
}
\arguments{
\item{bucket_name}{             Name of the S3 bucket\cr
}
\item{s3_file_key}{             S3 key of the uploaded object\cr
}
\item{file_path}{               Local path of the uploaded file\cr
}
\item{parent}{                  Parent entity to create the file handle in, the file handle will be created\cr
                                    in the default storage location of the parent. Mutually exclusive with\cr
                                    storage_location_id\cr
}
\item{storage_location_id}{     Explicit storage location id to create the file handle in, mutually exclusive\cr
                                    with parent\cr
}
\item{mimetype}{                Mimetype of the file, if known}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{

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




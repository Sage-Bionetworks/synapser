\name{synCreateExternalS3FileHandle}
\alias{synCreateExternalS3FileHandle}
\docType{methods}
\title{
synCreateExternalS3FileHandle
}
\description{
Create an external S3 file handle for e.g. a file that has been uploaded directly to
an external S3 storage location.
}
\usage{
synCreateExternalS3FileHandle(bucket_name, s3_file_key, file_path, parent=NULL, storage_location_id=NULL, mimetype=NULL)
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

\examples{
\dontrun{
library("aws.s3")

# create a storage location
folder_and_storage_location <- synCreateS3StorageLocation(parent='syn123', folder_name='test_folder', bucket_name='aws-bucket-name', base_key='test', sts_enabled=TRUE)

storage_location <- folder_and_storage_location[[2]]

# get a write permission token
folder <- folder_and_storage_location[[1]]
folder_id <- folder$properties$id
sts_write_token <- synGetStsStorageToken(entity=folder_id, permission='read_write', output_format='json')

# configure the environment with AWS token
Sys.setenv('AWS_ACCESS_KEY_ID'=sts_write_token$accessKeyId, 'AWS_SECRET_ACCESS_KEY'=sts_write_token$secretAccessKey, 'AWS_SESSION_TOKEN'=sts_write_token$sessionToken)

# upload a file directly to s3
put_object(file='/tmp/foo.txt', object='test/foo.txt', bucket='aws-bucket-name')

# create a file handle for the object
synCreateExternalS3FileHandle(bucket_name='aws-bucket-name', s3_file_key='test/foo.txt', file_path='/tmp/foo.txt', storage_location_id=storage_location$storageLocationId) 

}
}




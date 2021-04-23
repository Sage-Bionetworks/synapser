\name{synGetStsStorageToken}
\alias{synGetStsStorageToken}
\docType{methods}
\title{
synGetStsStorageToken
}
\description{
Get STS credentials for the given entity_id and permission, outputting it in the given format
}
\usage{
synGetStsStorageToken(entity, permission, output_format=json, min_remaining_life=NULL)
}
\arguments{
\item{entity}{          the entity or entity id whose credentials are being returned\cr
}
\item{permission}{      one of 'read_only' or 'read_write'\cr
}
\item{output_format}{   one of 'json', 'boto', 'shell', 'bash', 'cmd', 'powershell'\cr
                        json: the dictionary returned from the Synapse STS API including expiration\cr
                        boto: a dictionary compatible with a boto session (aws_access_key_id, etc)\cr
                        shell: output commands for exporting credentials appropriate for the detected shell\cr
                        bash: output commands for exporting credentials into a bash shell\cr
                        cmd: output commands for exporting credentials into a windows cmd shell\cr
                        powershell: output commands for exporting credentials into a windows powershell\cr
}
\item{min_remaining_life}{ the minimum allowable remaining life on a cached token to return. if a cached token\cr
    has left than this amount of time left a fresh token will be fetched}
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

folder <- folder_and_storage_location[[1]]
storage_location <- folder_and_storage_location[[2]]

# get a write permission token
sts_write_token <- synGetStsStorageToken(entity=folder$properties$id, permission='read_write')

# configure the environment with AWS token
Sys.setenv('AWS_ACCESS_KEY_ID'=sts_write_token$accessKeyId, 'AWS_SECRET_ACCESS_KEY'=sts_write_token$secretAccessKey, 'AWS_SESSION_TOKEN'=sts_write_token$sessionToken)

# upload the file directly to s3
put_object(file='/tmp/foo.txt', object='test/foo.txt', bucket='aws-bucket-name')

}
}



%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\value{

}



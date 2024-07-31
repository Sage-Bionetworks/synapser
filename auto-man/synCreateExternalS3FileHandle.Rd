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

Arguments:
    bucket_name: Name of the S3 bucket
    s3_file_key: S3 key of the uploaded object
    file_path: Local path of the uploaded file
    parent: Parent entity to create the file handle in, the file handle will be created
            in the default storage location of the parent. Mutually exclusive with
            storage_location_id
    storage_location_id: Explicit storage location id to create the file handle in, mutually exclusive
            with parent
    mimetype: Mimetype of the file, if known
    md5: MD5 of the file, if known

Raises:
    ValueError: If neither parent nor storage_location_id is specified, or if both are specified.
}
\usage{
synCreateExternalS3FileHandle(bucket_name, s3_file_key, file_path, parent=NULL, storage_location_id=NULL, mimetype=NULL, md5=NULL)
}
\arguments{
\item{bucket_name}{}
\item{s3_file_key}{}
\item{file_path}{}
\item{parent}{}
\item{storage_location_id}{}
\item{mimetype}{}
\item{md5}{}
}
\value{

}



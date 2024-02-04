%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUploadFileHandle}
\alias{synUploadFileHandle}
\docType{methods}
\title{
synUploadFileHandle
}
\description{
Uploads the file in the provided path (if necessary) to a storage location based on project settings.
Returns a new FileHandle as a dict to represent the stored file.

Arguments:
    parent: Parent of the entity to which we upload.
    path:   File path to the file being uploaded
    synapseStore: If False, will not upload the file, but instead create an ExternalFileHandle that references
                    the file on the local machine.
                    If True, will upload the file based on StorageLocation determined by the entity_parent_id
    mimetype: The MIME type metadata for the uploaded file
    md5: The MD5 checksum for the file, if known. Otherwise if the file is a local file, it will be calculated
            automatically.
    file_size: The size the file, if known. Otherwise if the file is a local file, it will be calculated
                automatically.
    file_type: The MIME type the file, if known. Otherwise if the file is a local file, it will be calculated
                automatically.

Returns:
    A dict of a new FileHandle as a dict that represents the uploaded file
}
\usage{
synUploadFileHandle(path, parent, synapseStore=TRUE, mimetype=NULL, md5=NULL, file_size=NULL)
}
\arguments{
\item{path}{}
\item{parent}{}
\item{synapseStore}{}
\item{mimetype}{}
\item{md5}{}
\item{file_size}{}
}
\value{

}



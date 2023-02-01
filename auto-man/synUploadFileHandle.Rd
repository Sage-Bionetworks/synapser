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
}
\usage{
synUploadFileHandle(path, parent, synapseStore=TRUE, mimetype=NULL, md5=NULL, file_size=NULL, file_type=NULL)
}
\arguments{
\item{path}{            file path to the file being uploaded\cr
}
\item{parent}{          parent of the entity to which we upload.\cr
}
\item{synapseStore}{    If False, will not upload the file, but instead create an ExternalFileHandle that\cr
                        references the file on the local machine.\cr
                        If True, will upload the file based on StorageLocation determined by the\cr
                        entity_parent_id\cr
}
\item{mimetype}{        The MIME type metadata for the uploaded file\cr
}
\item{md5}{             The MD5 checksum for the file, if known. Otherwise if the file is a local file, it will\cr
                        be calculated automatically.\cr
}
\item{file_size}{       The size the file, if known. Otherwise if the file is a local file, it will be\cr
                        calculated automatically.\cr
}
\item{file_type}{optional named parameter:        The MIME type the file, if known. Otherwise if the file is a local file, it will be\cr
                        calculated automatically.}
}
\value{
 a dict of a new FileHandle as a dict that represents the uploaded file
}



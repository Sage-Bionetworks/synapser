\name{File}
\alias{File}
\docType{methods}
\title{
Constructor for objects of type File
}
\description{
Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will be
stored in Synapse. A File must have a path (or URL) and a parent.
}
\usage{
File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)
}
\arguments{
\item{path}{             Location to be represented by this File\cr
}
\item{parent}{           Project or Folder where this File is stored\cr
}
\item{synapseStore}{     Whether the File should be uploaded or if only the path should be stored when synStore \cr
                        is called on the File object. Defaults to TRUE (file should be uploaded)\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{name}{optional named parameter:              Name of the file in Synapse, not to be confused with the name within the path\cr
}
\item{contentType}{optional named parameter:       Manually specify Content-type header, for example "application/png" or "application/json; charset=UTF-8"\cr
}
\item{dataFileHandleId}{optional named parameter:  Defining an existing dataFileHandleId will use the existing dataFileHandleId\cr
                         The creator of the file must also be the owner of the dataFileHandleId to have permission to store the file\cr
}
}
\value{
An object of type File
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
file<-File('/path/to/file/data.xyz', parent=folder)
file<-synStore(file)
}
}




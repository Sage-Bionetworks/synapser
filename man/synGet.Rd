\name{synGet}
\alias{synGet}
\title{
Retrieve an object from Synapse
}
\description{
Retrieve an object from Synapse
}
\usage{
synGet(id, version=NULL, downloadFile=T, downloadLocation=NULL, ifcollision="keep.both", load=F)
}
\arguments{
 \item{id}{
 The Synapse ID of the entity to retrieve.
}
 \item{version}{
 Optional:  The version number of the entity to retrieve. Defaults to the most recent version
}
 \item{downloadFile}{
 For File entities only.  If TRUE then the attached file is downloaded to the 'downloadLocation'
}
 \item{downloadLocation}{
 For File entities only.  The folder in the local file system to which the attached file is to be downloaded. 
 If omitted, then a default location in a cache is used.  See \code{\link{getFileLocation}}
}
 \item{ifcollision}{
 if.collision is one of "keep.both", "keep.local", or "overwrite.local", 
telling the system what to do if a different file is found at the given local file location
}
 \item{load}{
 If TRUE then deserialize the downloaded file into memory, using the R 'load' command (See \code{\link{getObject}}, \code{\link{listObjects}})
}
}
\details{
Get an entity (File, Folder, TableSchema, etc.) from the Synapse server, with its attributes (properties, annotations) and, 
optionally (for a File entity), with its associated file.
}

\author{
Bruce Hoff
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{File}}
\code{\link{Folder}}
\code{\link{Project}}
\code{\link{TableColumn}}
\code{\link{TableSchema}}
\code{\link{synStore}}
\code{\link{getFileLocation}}
\code{\link{getObject}}
\code{\link{listObjects}}
}

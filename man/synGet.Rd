\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{
Gets a Synapse entity from the repository service.
}
\usage{
synGet(entity, version=NULL, downloadFile=NULL, downloadLocation=NULL, followLink=NULL, ifcollision=NULL, limitSearch=NULL)
}
\arguments{
\item{entity}{           A Synapse ID, a Synapse Entity object,\cr
                         a named list in which 'id' maps to a Synapse ID or\cr
                         a local file that is stored in Synapse (found by hash of file)\cr
}
\item{version}{optional named parameter:           The specific version to get.\cr
                         Defaults to the most recent version.\cr
}
\item{downloadFile}{optional named parameter:      Whether associated files(s) should be downloaded.\cr
                         Defaults to TRUE\cr
}
\item{downloadLocation}{optional named parameter:  Directory where to download the Synapse File Entity.\cr
                         Defaults to the local cache.\cr
}
\item{followLink}{optional named parameter:        Whether the link returns the target Entity.\cr
                         Defaults to FALSE\cr
}
\item{ifcollision}{optional named parameter:       Determines how to handle file collisions.\cr
                         May be "overwrite.local", "keep.local", or "keep.both".\cr
                         Defaults to "keep.both".\cr
}
\item{limitSearch}{optional named parameter:       a Synanpse ID used to limit the search in Synapse if entity is\cr
                         specified as a local file.  That is, if the file is stored in multiple\cr
                         locations in Synapse only the ones in the specified folder/project will be\cr
                         returned.}
}
\value{
 A new Synapse Entity object of the appropriate type
}
%
% Verified that the following works on 2018Jan11.
%
\examples{
\dontrun{
## download file
file <- synGet('syn1906479')
print(file$properties$name)
print(file$path)

## to access the file's metadata without downloading the file
file <- synGet("syn1906479", downloadFile = FALSE)
md5 <- file$get("md5")
}
}




\name{getFileLocation}
\alias{getFileLocation}
\title{
getFileLocation
}
\description{
function to get the location of the attachment to a File
}
\usage{getFileLocation(fileObject)}
\details{
Returns a string which is the path to the file attached to a File object.
If the File 'links' to an external URL (not downloaded to the local file system), returns the URL itself.
}
\examples{
\dontrun{
file<-synGet("syn123456")
filePath<-getFileLocation(file)
}
}
\seealso{
\code{\link{File}}
\code{\link{synGet}}
\code{\link{synStore}}
}
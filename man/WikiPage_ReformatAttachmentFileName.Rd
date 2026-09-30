\name{synReformatAttachmentFileName}
\alias{WikiPage_synReformatAttachmentFileName}
\docType{methods}
\title{
WikiPage :  reformat_attachment_file_name
}
\description{
Reformat the attachment file name to be a valid attachment path.
}
\usage{
synReformatAttachmentFileName(attachment_file_name)
}
\arguments{
\item{attachment_file_name}{(str) The name of the attachment file.}
}
\value{
The reformatted attachment file name.
}
\examples{
\dontrun{
## Reformat the attachment file name
    attachment_file_name = "file.txt"
    attachment_file_name_reformatted = synReformatAttachmentFileName(attachment_file_name)
    cat("Reformatted attachment file name:", attachment_file_name_reformatted, "\n")
}
}
\keyword{WikiPage}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synReformatAttachmentFileName}
\alias{synReformatAttachmentFileName}
\docType{methods}
\title{
WikiPage :  reformat_attachment_file_name
}
\description{
Reformat the attachment file name to be a valid attachment path.
}
\usage{
synReformatAttachmentFileName(instance, attachment_file_name)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{attachment_file_name}{(str) The name of the attachment file.}
}
\value{
The reformatted attachment file name.
}
\examples{
\dontrun{
## Reformat the attachment file name
    attachment_file_name = "file.txt"
    attachment_file_name_reformatted = WikiPage.reformat_attachment_file_name(attachment_file_name)
    print(f"Reformatted attachment file name: {attachment_file_name_reformatted}")
}
}
\keyword{WikiPage}

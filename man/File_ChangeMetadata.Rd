\name{synChangeMetadata}
\alias{File_synChangeMetadata}
\docType{methods}
\title{
File :  change_metadata
}
\description{
Change File Entity metadata for properties that are immutable after creation
through the store method.
}
\usage{
synChangeMetadata(instance, name=NULL, download_as=NULL, content_type=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(File) The File instance to operate on.}
\item{name}{(Optional[str]) Specify to change the filename of a file as seen on Synapse.}
\item{download_as}{(Optional[str]) Specify filename to change the filename of a filehandle.}
\item{content_type}{(Optional[str]) Specify content type to change the content type of a filehandle.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The file object.
}
\section{Errors}{
An error is raised if the file does not have an ID to change metadata.
}
\examples{
\dontrun{
## Using this function
    # Can be used to change the filename, the filename when the file is
    # downloaded, or the file content-type without downloading:
    file_entity = File(id = "syn123", download_file = FALSE) |> synGet()
    cat(basename(file_entity$path), "\n")  # prints, e.g., "my_file.txt"

    file_entity = file_entity |> synChangeMetadata(
        name = "my_new_name_file.txt",
        download_as = "my_new_downloadAs_name_file.txt",
        content_type = "text/plain"
    )
    cat(basename(file_entity$path), "\n")  # prints, "my_new_downloadAs_name_file.txt"
    cat(file_entity$name, "\n")  # prints, "my_new_name_file.txt"
}
}
\keyword{File}

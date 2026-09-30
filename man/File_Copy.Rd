\name{synCopy}
\alias{File_synCopy}
\docType{methods}
\title{
File :  copy
}
\description{
Copy the file to another Synapse location. Defaults to the latest version of the
file, or the version_number specified in the instance.
}
\usage{
synCopy(instance, parent_id, update_existing=FALSE, copy_annotations=TRUE, copy_activity="traceback", synapse_client=NULL)
}
\arguments{
\item{instance}{(File) The File instance to operate on.}
\item{parent_id}{(str) Synapse ID of a folder/project that the copied entity is being copied to}
\item{update_existing}{(bool) When the destination has a file that has the same name, users can choose to update that file.}
\item{copy_annotations}{(bool) TRUE to copy the annotations.}
\item{copy_activity}{(Optional[str]) Has three options to set the activity of the copied file:\cr
- traceback: Creates a copy of the source files Activity.\cr
- existing: Link to the source file's original Activity (if it exists)\cr
- NULL: No activity is set}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The copied file object.
}
\section{Errors}{
An error is raised if the file does not have an ID and parent_id to copy.
}
\examples{
\dontrun{
## Using this function
    # Assuming you have a file with the ID "syn123" and you want to copy it to a
    # folder with the ID "syn456":
    new_file_instance = File(id = "syn123") |> synCopy(parent_id = "syn456")

    # Copy the file but do not persist annotations or activity:
    new_file_instance = File(id = "syn123") |> synCopy(parent_id = "syn456", copy_annotations = FALSE, copy_activity = NULL)
}
}
\keyword{File}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCopy}
\alias{synCopy}
\docType{methods}
\title{
Project :  copy
}
\description{
You must have already created the Project you will be copying to. It will have
it's own Synapse ID and unique name that you will use as the destination_id.


Copy the project to another Synapse project. This will recursively copy all
Tables, Links, Files, and Folders within the project.
}
\usage{
synCopy(instance, destination_id, copy_annotations=TRUE, copy_wiki=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{destination_id}{(str) Synapse ID of a project to copy to.}
\item{copy_annotations}{(bool) True to copy the annotations.}
\item{copy_wiki}{(bool) True to copy the wiki pages.}
\item{exclude_types}{(Optional[list[str]]) A list of entity types ['file', 'table', 'link'] which determines which entity types to not copy. Defaults to an empty list.}
\item{file_update_existing}{(bool) When the destination has a file that has the same name, users can choose to update that file.}
\item{file_copy_activity}{(Optional[str]) Has three options to set the activity of the copied file:\cr
\cr
- traceback: Creates a copy of the source files Activity. - existing: Link to the source file's original Activity (if it exists) - None: No activity is set}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The copied project object.
}
\section{Errors}{
ValueError: If the project does not have an ID and destination_id to copy.
}
\examples{
\dontrun{
## Using this function
    Assuming you have a project with the ID "syn123" and you want to copy it to a
    project with the ID "syn456":

        new_instance = await Project(id="syn123").copy_async(destination_id="syn456")

    Copy the project but do not persist annotations:

        new_instance = await Project(id="syn123").copy_async(destination_id="syn456", copy_annotations=False)
}
}
\keyword{Project}

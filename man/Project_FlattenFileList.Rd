\name{synFlattenFileList}
\alias{Project_synFlattenFileList}
\docType{methods}
\title{
Project :  flatten_file_list
}
\description{
Recursively loop over all of the already retrieved files and folders and return
a list of all files in the container.
}
\usage{
synFlattenFileList(instance)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
}
\value{
A list of all files in the container.
}
\examples{
\dontrun{
## Using this function
    # synFlattenFileList only looks at files and folders that have already been
    # retrieved, so sync the project from Synapse first.
    library(synapser)
    synLogin()

    my_project = Project(id = "syn123") |> synSyncFromSynapse(download_file = FALSE)

    all_files = my_project |> synFlattenFileList()
    for (file in all_files) {
        print(sprintf("\%s (\%s)", file$name, file$id))
    }
}
}
\keyword{Project}

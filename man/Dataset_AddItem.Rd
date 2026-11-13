\name{synAddItem}
\alias{Dataset_synAddItem}
\docType{methods}
\title{
Dataset :  add_item
}
\description{
Adds an item in the form of an \code{\link{EntityRef}} to the dataset.
For Folders, children are added recursively. Effect is not seen
until the dataset is stored.
}
\usage{
synAddItem(instance, item, synapse_client=NULL)
}
\arguments{
\item{instance}{(Dataset) The Dataset instance to operate on.}
\item{item}{(EntityRef, File, or Folder) Entity to add to the dataset. Must be an \code{\link{EntityRef}}, File, or Folder.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\section{Errors}{
Raises an error if the item is not an EntityRef, File, or Folder.
}
\examples{
\dontrun{
## Example 1: Add a file to a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(File(id = "syn1235"))
    my_dataset |> synStore()

## Example 2: Add a folder to a dataset.
    # All child files are recursively added to the dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(Folder(id = "syn1236"))
    my_dataset |> synStore()

## Example 3: Add an entity reference to a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(EntityRef(id = "syn1237", version = 1L))
    my_dataset |> synStore()
}
}
\keyword{Dataset}

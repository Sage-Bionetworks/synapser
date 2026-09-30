\name{synPrintEntity}
\alias{synPrintEntity}
\docType{methods}
\title{
synPrintEntity
}
\description{
Pretty print an Entity as JSON.
}
\usage{
synPrintEntity(entity, ensure_ascii=TRUE, synapse_client=NULL)
}
\arguments{
\item{entity}{(Union[str, dict, Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable]) Either an Entity object (Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable), a Synapse ID string, or a named list representation of an entity.}
\item{ensure_ascii}{(bool) If TRUE, escapes all non-ASCII characters in the output. Defaults to TRUE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL. Prints the entity to the logger.
}
\examples{
\dontrun{
## Example 1: Printing an entity by ID
    # Print an entity using its Synapse ID:
    library(synapser)
    synLogin()

    # Print entity by Synapse ID
    synPrintEntity("syn123456")

## Example 2: Printing an entity object
    # Print an entity object:
    library(synapser)
    synLogin()

    # Get and print a file entity
    file = synGet(synapse_id = "syn123456")
    synPrintEntity(file)

## Example 3: Controlling ASCII output
    # Print an entity with non-ASCII characters:
    library(synapser)
    synLogin()

    # Print with unicode characters preserved
    synPrintEntity("syn123456", ensure_ascii = FALSE)
}
}

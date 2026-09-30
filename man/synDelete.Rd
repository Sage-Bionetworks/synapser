\name{synDelete}
\alias{synDelete}
\docType{methods}
\title{
synDelete
}
\description{
Factory method to delete any Synapse entity.

This method serves as a unified interface for deleting any type of Synapse entity.
It automatically applies the appropriate delete logic based on the entity type.

Version Deletion Behavior:
    The function supports deleting specific versions of entities with the following
    precedence order:

    1. \strong{version parameter} (highest priority): When provided, this version number
       will be used for deletion, overriding any version information from the entity
       object or the entity ID string.

    2. \strong{Entity's version_number attribute} (secondary): If the entity object has
       a \code{version_number} attribute set and no explicit \code{version} parameter is
       provided, this version will be used.

    3. \strong{version_only parameter}: When set to TRUE, indicates that only a specific
       version should be deleted (not the entire entity). This parameter is only
       meaningful when combined with a version number from either the \code{version}
       parameter or the entity's \code{version_number} attribute.

    \strong{Supported for version-specific deletion:}

    - String ID with version (e.g., "syn123.4")\cr
    - File, RecordSet (use version_only=TRUE)\cr
    - Table, Dataset, DatasetCollection, EntityView, MaterializedView,
      SubmissionView, VirtualTable (use version_only=TRUE)

    \strong{Not supported for version-specific deletion:}

    - Project, Folder, Evaluation, Team, SchemaOrganization, CurationTask, Grid
}
\usage{
synDelete(entity, version=NULL, version_only=FALSE, synapse_client=NULL)
}
\arguments{
\item{entity}{(Union[str, CurationTask, Dataset, DatasetCollection, EntityView, Evaluation, File, Folder, Grid, JSONSchema, MaterializedView, Project, RecordSet, SchemaOrganization, SubmissionView, Table, Team, VirtualTable, DockerRepository]) The entity instance to delete, or a Synapse ID string (e.g., "syn123456" or "syn123456.4" for a specific version). Must be one of the supported entity types or a valid Synapse ID.}
\item{version}{(Optional[Union[str, int]]) Optional version number to delete. Takes precedence over any version information in the entity object or ID string. When provided with \code{version_only = TRUE}, deletes only this specific version.}
\item{version_only}{(bool) If TRUE, only the specified version will be deleted, not the entire entity. Requires a version number from either the \code{version} parameter or the entity's \code{version_number} attribute. This parameter is applicable for entities that support version-specific deletion (File, RecordSet, Table, Dataset, DatasetCollection, EntityView, MaterializedView, SubmissionView, VirtualTable, JSONSchema).}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\section{Errors}{
- An error is raised if the entity is not a supported type or not a valid Synapse ID.\cr
- An error is raised if version_only is TRUE but no version number is available.
}
\examples{
\dontrun{
## Example 1: Deleting a file by object
    # Delete a file from Synapse:
    library(synapser)
    synLogin()

    file = File(id = "syn123456")
    file |> synDelete()
    print("File deleted successfully")

## Example 2: Deleting a specific version of a file
    # Delete only version 2 of a file, keeping other versions:
    library(synapser)
    synLogin()

    # Method 1: Using version parameter (highest priority)
    file = File(id = "syn123456")
    file |> synDelete(version = 2L, version_only = TRUE)

    # Method 2: Using entity's version_number attribute
    file = File(id = "syn123456", version_number = 2L)
    file |> synDelete(version_only = TRUE)

    # Method 3: Using synapse ID with version
    synDelete("syn123456.2", version_only = TRUE)
    print("File version 2 deleted successfully")

## Example 3: Deleting a file by ID string
    # Delete a file from Synapse using just its ID:
    library(synapser)
    synLogin()

    synDelete("syn123456")
    print("Entity deleted successfully")

## Example 4: Deleting a project
    # Delete a project from Synapse:
    library(synapser)
    synLogin()

    project = Project(id = "syn123456")
    project |> synDelete()
    print("Project deleted successfully")

## Example 5: Deleting a table
    # Delete a table from Synapse:
    library(synapser)
    synLogin()

    table = Table(id = "syn123456")
    table |> synDelete()
    print("Table deleted successfully")

## Example 6: Deleting a team
    # Delete a team from Synapse:
    library(synapser)
    synLogin()

    team = Team(id = "123456")
    team |> synDelete()
    print("Team deleted successfully")
}
}

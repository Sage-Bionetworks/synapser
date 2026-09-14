%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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

    1. **version parameter** (highest priority): When provided, this version number
       will be used for deletion, overriding any version information from the entity
       object or the entity ID string.

    2. **Entity's version_number attribute** (secondary): If the entity object has
       a \code{version_number} attribute set and no explicit \code{version} parameter is
       provided, this version will be used.

    3. **version_only parameter**: When set to True, indicates that only a specific
       version should be deleted (not the entire entity). This parameter is only
       meaningful when combined with a version number from either the \code{version}
       parameter or the entity's \code{version_number} attribute.

    **Supported for version-specific deletion:**

    - String ID with version (e.g., "syn123.4")
    - File, RecordSet (use version_only=True)
    - Table, Dataset, DatasetCollection, EntityView, MaterializedView,
      SubmissionView, VirtualTable (use version_only=True)

    **Not supported for version-specific deletion:**

    - Project, Folder, Evaluation, Team, SchemaOrganization, CurationTask, Grid
}
\usage{
synDelete(entity, version=NULL, version_only=FALSE, synapse_client=NULL)
}
\arguments{
\item{entity}{(Union[str, ForwardRef('CurationTask'), ForwardRef('Dataset'), ForwardRef('DatasetCollection'), ForwardRef('EntityView'), ForwardRef('Evaluation'), ForwardRef('File'), ForwardRef('Folder'), ForwardRef('Grid'), ForwardRef('JSONSchema'), ForwardRef('MaterializedView'), ForwardRef('Project'), ForwardRef('RecordSet'), ForwardRef('SchemaOrganization'), ForwardRef('SubmissionView'), ForwardRef('Table'), ForwardRef('Team'), ForwardRef('VirtualTable'), ForwardRef('DockerRepository')]) The entity instance to delete, or a Synapse ID string (e.g., "syn123456" or "syn123456.4" for a specific version). Must be one of the supported entity types or a valid Synapse ID.}
\item{version}{(Optional[Union[str, int]]) Optional version number to delete. Takes precedence over any version information in the entity object or ID string. When provided with \code{version_only=True}, deletes only this specific version.}
\item{version_only}{(bool) If True, only the specified version will be deleted, not the entire entity. Requires a version number from either the \code{version} parameter or the entity's \code{version_number} attribute. This parameter is applicable for entities that support version-specific deletion (File, RecordSet, Table, Dataset, DatasetCollection, EntityView, MaterializedView, SubmissionView, VirtualTable, JSONSchema).}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None
}
\section{Errors}{
ValueError: If the entity is not a supported type or not a valid Synapse ID.
    ValueError: If version_only is True but no version number is available.
}
\examples{
\dontrun{
## Example 1: Deleting a file by object
    # Delete a file from Synapse:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    file = File(id="syn123456")
    delete(file)
    print("File deleted successfully")

## Example 2: Deleting a specific version of a file
    # Delete only version 2 of a file, keeping other versions:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    # Method 1: Using version parameter (highest priority)
    file = File(id="syn123456")
    delete(file, version=2, version_only=True)

    # Method 2: Using entity's version_number attribute
    file = File(id="syn123456", version_number=2)
    delete(file, version_only=True)

    # Method 3: Using synapse ID with version
    delete("syn123456.2", version_only=True)
    print("File version 2 deleted successfully")

## Example 3: Deleting a file by ID string
    # Delete a file from Synapse using just its ID:

    from synapseclient import Synapse
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    delete("syn123456")
    print("Entity deleted successfully")

## Example 4: Deleting a project
    # Delete a project from Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Project
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    project = Project(id="syn123456")
    delete(project)
    print("Project deleted successfully")

## Example 5: Deleting a specific version of a RecordSet
    # Delete only a specific version of a RecordSet:

    from synapseclient import Synapse
    from synapseclient.models import RecordSet
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    record_set = RecordSet(id="syn123456", version_number=3)
    delete(record_set, version_only=True)
    print("RecordSet version 3 deleted successfully")

## Example 6: Deleting a table
    # Delete a table from Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Table
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    table = Table(id="syn123456")
    delete(table)
    print("Table deleted successfully")

## Example 7: Deleting a team
    # Delete a team from Synapse:

    from synapseclient import Synapse
    from synapseclient.models import Team
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    team = Team(id="123456")
    delete(team)
    print("Team deleted successfully")

## Example 8: Deleting a curation task
    # Delete a curation task from Synapse:

    from synapseclient import Synapse
    from synapseclient.models import CurationTask
    from synapseclient.operations import delete

    syn = Synapse()
    syn.login()

    task = CurationTask(task_id=123)
    delete(task)
    print("Curation task deleted successfully")
}
}
\keyword{}

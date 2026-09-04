%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{entity}{(Union[str, dict, ForwardRef('Dataset'), ForwardRef('DatasetCollection'), ForwardRef('EntityView'), ForwardRef('File'), ForwardRef('Folder'), ForwardRef('Link'), ForwardRef('MaterializedView'), ForwardRef('Project'), ForwardRef('RecordSet'), ForwardRef('SubmissionView'), ForwardRef('Table'), ForwardRef('VirtualTable')]) Either an Entity object (Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable), a Synapse ID string, or a dictionary representation of an entity.}
\item{ensure_ascii}{(bool) If True, escapes all non-ASCII characters in the output. Defaults to True.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None. Prints the entity to the logger.
}
\examples{
\dontrun{
## Example 1: Printing an entity by ID
    # Print an entity using its Synapse ID:

    from synapseclient import Synapse
    from synapseclient.operations import print_entity

    syn = Synapse()
    syn.login()

    # Print entity by Synapse ID
    print_entity("syn123456")

## Example 2: Printing an entity object
    # Print an entity object:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import print_entity, get

    syn = Synapse()
    syn.login()

    # Get and print a file entity
    file = get(synapse_id="syn123456")
    print_entity(file)

## Example 3: Controlling ASCII output
    # Print an entity with non-ASCII characters:

    from synapseclient import Synapse
    from synapseclient.operations import print_entity

    syn = Synapse()
    syn.login()

    # Print with unicode characters preserved
    print_entity("syn123456", ensure_ascii=False)
}
}
\keyword{}

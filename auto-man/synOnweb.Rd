%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synOnweb}
\alias{synOnweb}
\docType{methods}
\title{
synOnweb
}
\description{
Open up a browser window to the entity page or wiki-subpage.
}
\usage{
synOnweb(entity, subpage_id=NULL, synapse_client=NULL)
}
\arguments{
\item{entity}{(Union[str, ForwardRef('Dataset'), ForwardRef('DatasetCollection'), ForwardRef('EntityView'), ForwardRef('File'), ForwardRef('Folder'), ForwardRef('Link'), ForwardRef('MaterializedView'), ForwardRef('Project'), ForwardRef('RecordSet'), ForwardRef('SubmissionView'), ForwardRef('Table'), ForwardRef('VirtualTable')]) Either an Entity object (Dataset, DatasetCollection, EntityView, File, Folder, Link, MaterializedView, Project, RecordSet, SubmissionView, Table, VirtualTable) or a Synapse ID string.}
\item{subpage_id}{(Optional[str]) (Optional) ID of one of the wiki's sub-pages.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The URL that was opened in the browser.
}
\examples{
\dontrun{
## Example 1: Opening an entity in browser
    # Open an entity's page in the default web browser:

    from synapseclient import Synapse
    from synapseclient.operations import onweb

    syn = Synapse()
    syn.login()

    # Open by Synapse ID
    url = onweb("syn123456")
    print(f"Opened: {url}")

## Example 2: Opening with an entity object
    # Open an entity using an entity object:

    from synapseclient import Synapse
    from synapseclient.models import File
    from synapseclient.operations import onweb, get

    syn = Synapse()
    syn.login()

    file = get(synapse_id="syn123456")
    url = onweb(file)
    print(f"Opened file: {url}")

## Example 3: Opening a wiki subpage
    # Open a specific wiki subpage:

    from synapseclient import Synapse
    from synapseclient.operations import onweb

    syn = Synapse()
    syn.login()

    # Open a specific wiki subpage
    url = onweb("syn123456", subpage_id="12345")
    print(f"Opened wiki subpage: {url}")
}
}
\keyword{}

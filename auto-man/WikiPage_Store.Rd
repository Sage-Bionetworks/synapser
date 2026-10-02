%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{WikiPage_synStore}
\docType{methods}
\title{
WikiPage :  store
}
\description{
Store the wiki page. If there is no wiki page, a new wiki page will be created.
If the wiki page already exists, it will be updated.
Subwiki pages are created by passing in a parent_id.
If a parent_id is provided, the wiki page will be created as a subwiki page.
}
\usage{
synStore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The created/updated wiki page.
}
\section{Errors}{
ValueError: If owner_id is not provided or if required fields are missing.
}
\examples{
\dontrun{
## Store a wiki page
    # This example shows how to store a wiki page.
    from synapseclient import Synapse
    from synapseclient.models import (
        Project,
        WikiPage,
    )
    syn = Synapse()
    syn.login()
    project = await Project(name="My uniquely named project about Alzheimer's Disease").get_async()
    wiki_page = await WikiPage(owner_id=project.id, title="My wiki page").store_async()
    print(wiki_page)
}
}
\keyword{WikiPage}

%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{WikiOrderHint_synStore}
\docType{methods}
\title{
WikiOrderHint :  store
}
\description{
Store the order hint of a wiki page tree.
}
\usage{
synStore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiOrderHint) The WikiOrderHint instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
The updated WikiOrderHint object for the entity.
}
\section{Errors}{
ValueError: If owner_id or request is not provided.
}
\examples{
\dontrun{
## Example 1: Set the WikiOrderHint for a project
    # This example shows how to set a WikiOrderHint for existing wiki pages in a project.
    # The WikiOrderHint is not set by default, so you need to set it explicitly.
    from synapseclient import Synapse
    from synapseclient.models import (
        Project,
        WikiOrderHint,
    )
    syn = Synapse()
    syn.login()
    project = await Project(name="My uniquely named project about Alzheimer's Disease").get_async()
    wiki_order_hint = await WikiOrderHint(owner_id=project.id).get_async()

    wiki_order_hint.id_list = [
        root_wiki_page.id,
        wiki_page_1.id,
        wiki_page_3.id,
        wiki_page_2.id,
        wiki_page_4.id,
    ]
    await wiki_order_hint.store_async()
    print(wiki_order_hint)

## Example 2: Update the WikiOrderHint for a project
    # This example shows how to update a WikiOrderHint for existing wiki pages in a project.
    wiki_order_hint.id_list = [
        root_wiki_page.id,
        wiki_page_1.id,
        wiki_page_2.id,
        wiki_page_3.id,
        wiki_page_4.id,
    ]
    await wiki_order_hint.store_async()
    print(wiki_order_hint)
}
}
\keyword{WikiOrderHint}

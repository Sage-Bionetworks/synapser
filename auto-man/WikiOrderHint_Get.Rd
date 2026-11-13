%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{WikiOrderHint_synGet}
\docType{methods}
\title{
WikiOrderHint :  get
}
\description{
Get the order hint of a wiki page tree.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiOrderHint) The WikiOrderHint instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
A WikiOrderHint object for the entity.
}
\section{Errors}{
ValueError: If owner_id is not provided.
}
\examples{
\dontrun{
## Get the WikiOrderHint for a project
    # This example shows how to get a WikiOrderHint for existing wiki pages in a project.
    from synapseclient import Synapse
    from synapseclient.models import (
        Project,
        WikiOrderHint,
    )
    syn = Synapse()
    syn.login()
    project = await Project(name="My uniquely named project about Alzheimer's Disease").get_async()
    wiki_order_hint = await WikiOrderHint(owner_id=project.id).get_async()
    print(wiki_order_hint)
}
}
\keyword{WikiOrderHint}

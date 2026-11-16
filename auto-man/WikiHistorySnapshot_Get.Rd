%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{WikiHistorySnapshot_synGet}
\docType{methods}
\title{
WikiHistorySnapshot :  get
}
\description{
Get the history of a wiki page as a list of WikiHistorySnapshot objects.
}
\usage{
synGet(cls, owner_id=NULL, id=NULL, offset=0L, limit=20L, synapse_client=NULL)
}
\arguments{
\item{cls}{(WikiHistorySnapshot) The WikiHistorySnapshot class (or an existing WikiHistorySnapshot instance) to dispatch this call to.}
\item{owner_id}{(str) The Synapse ID of the owner entity.}
\item{id}{(str) The ID of the wiki page.}
\item{offset}{(int) The index of the pagination offset.}
\item{limit}{(int) Limits the size of the page returned.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
Individual WikiHistorySnapshot objects from each page of the response.
}
\examples{
\dontrun{
## Get the history of a wiki page
    for history in WikiHistorySnapshot.get(owner_id=project.id, id=wiki_page.id):
        print(f"History: {history}")
}
}
\keyword{WikiHistorySnapshot}

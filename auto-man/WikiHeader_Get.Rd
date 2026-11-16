%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{WikiHeader_synGet}
\docType{methods}
\title{
WikiHeader :  get
}
\description{
Get the header tree (hierarchy) of wiki pages for an entity.
}
\usage{
synGet(cls, owner_id, offset=0L, limit=20L, synapse_client=NULL)
}
\arguments{
\item{cls}{(WikiHeader) The WikiHeader class (or an existing WikiHeader instance) to dispatch this call to.}
\item{owner_id}{(str) The ID of the owner entity.}
\item{offset}{(int) The index of the pagination offset.}
\item{limit}{(int) Limits the size of the page returned.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
Individual WikiHeader objects for the entity.
}
\examples{
\dontrun{
## Get the header tree (hierarchy) of wiki pages for an entity
    for header in WikiHeader.get(owner_id=project.id):
        print(f"Header: {header}")
}
}
\keyword{WikiHeader}

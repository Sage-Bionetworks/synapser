%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{WikiPage_synGet}
\docType{methods}
\title{
WikiPage :  get
}
\description{
Get a wiki page from Synapse.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The wiki page.
}
\section{Errors}{
ValueError: If owner_id is not provided.
}
\examples{
\dontrun{
## Get a wiki page from Synapse
    # This example shows how to get a wiki page from Synapse.
    wiki_page = await WikiPage(owner_id=project.id, id=wiki_page.id).get_async()
    print(wiki_page)
}
}
\keyword{WikiPage}

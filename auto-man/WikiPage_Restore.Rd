%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestore}
\alias{WikiPage_synRestore}
\docType{methods}
\title{
WikiPage :  restore
}
\description{
Restore a specific version of a wiki page.
}
\usage{
synRestore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The restored wiki page.
}
\examples{
\dontrun{
## Restore a specific version of a wiki page
    # This example shows how to restore a specific version of a wiki page.
    wiki_page_restored = await WikiPage(owner_id=project.id, id=wiki_page.id, wiki_version="0").restore_async()
    print(wiki_page_restored)
}
}
\keyword{WikiPage}

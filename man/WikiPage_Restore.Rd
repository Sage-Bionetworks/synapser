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
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The restored wiki page.
}
\examples{
\dontrun{
## Restore a specific version of a wiki page
    # This example shows how to restore a specific version of a wiki page.
    wiki_page_restored = WikiPage(owner_id = project$id, id = wiki_page$id, wiki_version = "0") |> synRestore()
    wiki_page_restored
}
}
\keyword{WikiPage}

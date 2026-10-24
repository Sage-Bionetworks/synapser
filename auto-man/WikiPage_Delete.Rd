%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDelete}
\alias{WikiPage_synDelete}
\docType{methods}
\title{
WikiPage :  delete
}
\description{
Delete this wiki page.
}
\usage{
synDelete(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If required fields are missing.
}
\examples{
\dontrun{
## Delete a wiki page
    # This example shows how to delete a wiki page.
    wiki_page = await WikiPage(owner_id=project.id, id=wiki_page.id).delete_async()
    print(f"Wiki page {wiki_page.title} deleted successfully.")
}
}
\keyword{WikiPage}

\name{synCopy}
\alias{WikiPage_synCopy}
\docType{methods}
\title{
WikiPage :  copy
}
\description{
Copy the wiki page tree of the owner entity to another entity and
update internal links.

If id is set on this WikiPage, only the sub-tree rooted at that wiki page
is copied. Otherwise the entire wiki of the owner entity is copied.
}
\usage{
synCopy(instance, destination_owner_id, destination_sub_page_id=NULL, update_links=TRUE, entity_map=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{destination_owner_id}{(character) The Synapse ID of the entity that the wiki will be copied to.}
\item{destination_sub_page_id}{(Optional[character]) Optional ID of a wiki page that already exists in the destination. The root of the copied tree is written into that page, replacing its title, markdown, and attachments, and the rest of the copied pages are created beneath it. Required when the destination entity already has a root wiki page.}
\item{update_links}{(logical) Update all the internal links so that they point at the copied wiki pages. For example, syn1234/wiki/34345 becomes syn3345/wiki/49508. Defaults to TRUE.}
\item{entity_map}{(Optional[named list]) A mapping of old Synapse IDs to new Synapse IDs, for example \code{list(syn1234 = "syn2345")}. If provided, the Synapse IDs referenced in the markdown of the copied wiki pages are updated, for example syn1234 becomes syn2345. If omitted, Synapse IDs are left unchanged.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of \code{\link{WikiHeader}} objects for the destination entity.
}
\section{Errors}{
Raises an error if owner_id is not provided or is not a Synapse ID,
if destination_owner_id is not a Synapse ID, if a key or value of
entity_map is not a Synapse ID, if id is set but no wiki page with that ID
exists in the owner entity, if destination_sub_page_id does not exist in
the destination entity, if the destination entity already has a root wiki
page and destination_sub_page_id is not provided, or if copying an
attachment file handle fails.
}
\examples{
\dontrun{
## Example 1: Copy the entire wiki of an entity to another entity
    # This example shows how to copy all wiki pages from one project to another.
    library(synapser)
    synLogin()

    new_wiki_headers = WikiPage(owner_id = "syn123") |> synCopy(
        destination_owner_id = "syn456"
    )
    print(new_wiki_headers)

## Example 2: Copy a wiki sub-tree and update Synapse ID references
    # This example shows how to copy a specific wiki page and its sub-pages,
    # rewriting references to syn1234 so they point at syn2345.
    new_wiki_headers = WikiPage(owner_id = "syn123", id = "34345") |> synCopy(
        destination_owner_id = "syn456",
        entity_map = list(syn1234 = "syn2345")
    )
    print(new_wiki_headers)
}
}
\keyword{WikiPage}

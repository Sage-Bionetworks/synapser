%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetChildren}
\alias{synGetChildren}
\docType{methods}
\title{
synGetChildren
}
\description{
Retrieves all of the entities stored within a parent such as folder or project.
}
\usage{
synGetChildren(parent, includeTypes=c("folder", "file", "table", "link", "entityview", "dockerrepo", "submissionview", "dataset", "materializedview"), sortBy=NAME, sortDirection=ASC)
}
\arguments{
\item{parent}{          An id or an object of a Synapse container or None to retrieve all projects}
\item{includeTypes}{    Must be a list of entity types (ie. ["folder","file"]) which can be found here:\cr
                        http://docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html}
\item{sortBy}{          How results should be sorted.  Can be NAME, or CREATED_ON}
\item{sortDirection}{   The direction of the result sort.  Can be ASC, or DESC}
}
\value{
                An iterator that shows all the children of the container.
}



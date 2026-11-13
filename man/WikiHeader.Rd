\name{WikiHeader}
\alias{WikiHeader}
\docType{class}
\title{
WikiHeader
}
\format{An S3-style class object.}
\description{
A WikiHeader contains basic metadata about a WikiPage.
}
\usage{
WikiHeader(id=NULL, title=NULL, parent_id=NULL)
}
\arguments{
\item{id}{(Optional[str]) The unique identifier for this wiki page.}
\item{title}{(Optional[str]) The title of this page.}
\item{parent_id}{(Optional[str]) When set, the WikiPage is a sub-page of the indicated parent WikiPage.}
}
\value{
NULL
}
\examples{
\dontrun{
## Get the header tree (hierarchy) of wiki pages for an entity
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    for (header in as.list(WikiHeader() |> synGet(owner_id = project$id))) {
        print(header)
    }
}
}
\section{Methods}{
\itemize{
\item \code{WikiHeader(id=NULL, title=NULL, parent_id=NULL)}: Constructor for \code{\link{WikiHeader}}
}
}


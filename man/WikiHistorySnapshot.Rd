\name{WikiHistorySnapshot}
\alias{WikiHistorySnapshot}
\docType{class}
\title{
WikiHistorySnapshot
}
\format{An S3-style class object.}
\description{
A WikiHistorySnapshot contains basic information about an update to a WikiPage.
}
\usage{
WikiHistorySnapshot(version=NULL, modified_on=NULL, modified_by=NULL)
}
\arguments{
\item{version}{(Optional[str]) The version number of the wiki page.}
\item{modified_on}{(Optional[str]) The timestamp when this version was created.}
\item{modified_by}{(Optional[str]) The ID of the user that created this version.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{WikiHistorySnapshot(version=NULL, modified_on=NULL, modified_by=NULL)}: Constructor for \code{\link{WikiHistorySnapshot}}
}
}


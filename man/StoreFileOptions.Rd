\name{StoreFileOptions}
\alias{StoreFileOptions}
\docType{class}
\title{
StoreFileOptions
}
\format{An S3-style class object.}
\description{
Options for storing File entities.
}
\usage{
StoreFileOptions(synapse_store=NULL, content_type=NULL, merge_existing_annotations=NULL, associate_activity_to_new_version=NULL)
}
\arguments{
\item{synapse_store}{(Optional[bool]) Whether to store the file in Synapse or use an external URL.}
\item{content_type}{(Optional[str]) The content type of the file.}
\item{merge_existing_annotations}{(Optional[bool]) If TRUE, merge existing annotations with new ones. If FALSE, replace all annotations.}
\item{associate_activity_to_new_version}{(Optional[bool]) If TRUE, associate activity with new version. If FALSE, do not associate activity.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreFileOptions(synapse_store=NULL, content_type=NULL, merge_existing_annotations=NULL, associate_activity_to_new_version=NULL)}: Constructor for \code{\link{StoreFileOptions}}
}
}


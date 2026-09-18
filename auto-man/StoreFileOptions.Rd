%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{merge_existing_annotations}{(Optional[bool]) If True, merge existing annotations with new ones. If False, replace all annotations.}
\item{associate_activity_to_new_version}{(Optional[bool]) If True, associate activity with new version. If False, do not associate activity.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreFileOptions(synapse_store=NULL, content_type=NULL, merge_existing_annotations=NULL, associate_activity_to_new_version=NULL)}: Constructor for \code{\link{StoreFileOptions}}
}
}


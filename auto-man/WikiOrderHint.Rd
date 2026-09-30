%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{WikiOrderHint}
\alias{WikiOrderHint}
\docType{class}
\title{
WikiOrderHint
}
\format{An S3-style class object.}
\description{
A WikiOrderHint contains the order hint for the root wiki that corresponds to the given owner ID and type.
}
\usage{
WikiOrderHint(owner_id=NULL, owner_object_type=NULL, id_list=list(), etag=NULL)
}
\arguments{
\item{owner_id}{(Optional[str]) The Synapse ID of the owner object (e.g., entity, evaluation, etc.).}
\item{owner_object_type}{(Optional[str]) The type of the owner object.}
\item{id_list}{(list[str]) The list of sub wiki ids that in the order that they should be placed relative to their siblings.}
\item{etag}{(Optional[str]) The etag of this object.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{WikiOrderHint(owner_id=NULL, owner_object_type=NULL, id_list=list(), etag=NULL)}: Constructor for \code{\link{WikiOrderHint}}
}
}


%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{File-class}
\alias{File-class}
\docType{class}
\title{
File
}
\format{An R6 class object.}
\description{
Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will be
stored in Synapse. A File must have a path (or URL) and a parent.
}
\section{Methods}{
\itemize{
\item \code{File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, local_state=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)}: Constructor for \code{\link{File}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


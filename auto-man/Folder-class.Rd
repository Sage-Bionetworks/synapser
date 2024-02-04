%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Folder-class}
\alias{Folder-class}
\docType{class}
\title{
Folder
}
\format{An R6 class object.}
\description{
Represents a folder in Synapse.

Folders must have a name and a parent and can optionally have annotations.

Attributes:
    name: The name of the folder
    parent: The parent project or folder
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\section{Methods}{
\itemize{
\item \code{Folder(name=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Folder}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.\cr
\cr
Arguments:\cr
    state: A dictionary containing the object's internal state.\cr
\cr
Returns:\cr
    result: The object's internal state, excluding properties, or annotations.
}
}


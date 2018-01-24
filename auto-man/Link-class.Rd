%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Link-class}
\alias{Link-class}
\docType{class}
\title{
Link
}
\format{An R6 class object.}
\description{
Represents a link in Synapse.

Links must have a target ID and a parent. When you do synGet on a Link object,
the Link object is returned. If the target is desired, specify followLink=True in synapseclient.Synapse.get.
}
\section{Methods}{
\itemize{
\item \code{Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Link}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


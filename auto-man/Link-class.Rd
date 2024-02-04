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

Links must have a target ID and a parent. When you do [synapseclient.Synapse.get][] on a Link object,
the Link object is returned. If the target is desired, specify followLink=True in synapseclient.Synapse.get.

Attributes:
    targetId: The ID of the entity to be linked
    targetVersion: The version of the entity to be linked
    parent: The parent project or folder
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\section{Methods}{
\itemize{
\item \code{Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Link}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.\cr
\cr
Arguments:\cr
    state: A dictionary containing the object's internal state.\cr
\cr
Returns:\cr
    result: The object's internal state, excluding properties, or annotations.
}
}


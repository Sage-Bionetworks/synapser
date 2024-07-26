%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Project-class}
\alias{Project-class}
\docType{class}
\title{
Project
}
\format{An R6 class object.}
\description{
Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project with a name that's already taken, say
'My project', will result in an error

Attributes:
    name: The name of the project
    alias: The project alias for use in friendly project urls.
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\section{Methods}{
\itemize{
\item \code{Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)}: Constructor for \code{\link{Project}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.\cr
\cr
Arguments:\cr
    state: A dictionary containing the object's internal state.\cr
\cr
Returns:\cr
    result: The object's internal state, excluding properties, or annotations.
}
}


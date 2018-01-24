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

Projects in Synapse must be uniquely named. Trying to create a project with
a name that's already taken, say 'My project', will result in an error
}
\section{Methods}{
\itemize{
\item \code{Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Project}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


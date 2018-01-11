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
\item \code{has_key(key)}: Is the given key a property or annotation?
\item \code{keys()}: Returns a set of property and annotation keys
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


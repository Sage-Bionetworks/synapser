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
}
\section{Methods}{
\itemize{
\item \code{Folder(name=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Folder}}
\item \code{has_key(key)}: Is the given key a property or annotation?
\item \code{keys()}: Returns a set of property and annotation keys
\item \code{local_state(state=NULL)}: Internal use only
}
}


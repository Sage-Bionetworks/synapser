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
\item \code{File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)}: Constructor for \code{\link{File}}
}
}


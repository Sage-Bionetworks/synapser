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
\item \code{has_key(key)}: Is the given key a property or annotation?
\item \code{keys()}: Returns a set of property and annotation keys
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


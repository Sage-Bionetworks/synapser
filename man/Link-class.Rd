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
the Link object is returned. If the target is desired, specify followLink=TRUE in synapseclient.Synapse.get.
}
\section{Methods}{
\itemize{
\item \code{Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL)}: Constructor for \code{\link{Link}}
}
}


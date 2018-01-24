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
\item \code{Project(name=NULL, properties=NULL, annotations=NULL)}: Constructor for \code{\link{Project}}
}
}


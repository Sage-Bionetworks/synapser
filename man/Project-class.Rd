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
\item \code{has_key(key)}: Is the given key a property or annotation?
\item \code{keys()}: Returns a set of property and annotation keys
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


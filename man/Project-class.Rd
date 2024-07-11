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
}

\section{Attributes}{
\itemize{
\item{name:}{        The name of the project\cr
}
\item{alias:}{       The project alias for use in friendly project urls\cr
}
\item{properties:}{  A map of Synapse properties\cr
}
\item{annotations:}{ A map of user defined annotations\cr
}
\item{local_state:}{ Internal use only\cr
}
}
}

\section{Methods}{
\itemize{
\item \code{Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)}: Constructor for \code{\link{Project}}
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.\cr

\subsection{Arguments}{
state: A dictionary containing the object's internal state
}
\subsection{Returns}{
The object's internal state, excluding properties, or annotations
}
}
}
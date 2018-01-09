\name{DockerRepository-class}
\alias{DockerRepository-class}
\docType{class}
\title{
DockerRepository
}
\format{An R6 class object.}
\description{
A Docker repository is a lightweight virtual machine image.

NOTE: store()-ing a DockerRepository created in the Python client will always result in it being treated as a 
reference to an external Docker repository that is not managed by synapse. 
To upload a docker image that is managed by Synapse please use the official Docker client and read http://docs.synapse.org/articles/docker.html for instructions on uploading a Docker Image to Synapse
}
\section{Methods}{
\itemize{
\item \code{DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{DockerRepository}}
\item \code{has_key(key)}: Is the given key a property or annotation?
\item \code{keys()}: Returns a set of property and annotation keys
\item \code{local_state(state=NULL)}: Set or get the object's internal state, excluding properties, or annotations.
}
}


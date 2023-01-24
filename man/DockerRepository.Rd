\name{DockerRepository}
\alias{DockerRepository}
\docType{methods}
\title{
Constructor for objects of type DockerRepository
}
\description{
A Docker repository is a lightweight virtual machine image.

NOTE: store()-ing a DockerRepository created in the Python client will always result in it being treated as a
reference to an external Docker repository that is not managed by synapse.
To upload a docker image that is managed by Synapse please use the official Docker client and read http://docs.synapse.org/articles/docker.html for instructions on uploading a Docker Image to Synapse
}
\usage{
DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL)
}
\arguments{
\item{repositoryName}{ the name of the Docker Repository. Usually in the format: [host[:port]/]path. If host is not set, it will default to that of DockerHub. port can only be specified if the host is also specified\cr
}
\item{parent}{ the parent project for the Docker repository\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
}
\value{
An object of type DockerRepository
}
\examples{
\dontrun{
dr <- DockerRepository(repositoryName = "test", parent = "syn123")
dr <- synStore(dr)
}
}




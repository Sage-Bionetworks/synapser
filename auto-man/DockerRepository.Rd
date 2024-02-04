%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{DockerRepository}
\alias{DockerRepository}
\docType{methods}
\title{
Constructor for objects of type DockerRepository
}
\description{
A Docker repository is a lightweight virtual machine image.

NOTE: [store()][synapseclient.Synapse.store]-ing a DockerRepository created in the Python client will always result
in it being treated as a reference to an external Docker repository that is not
managed by synapse. To upload a docker image that is managed by Synapse please use the official
Docker client and read <https://help.synapse.org/docs/Synapse-Docker-Registry.2011037752.html>
for instructions on uploading a Docker Image to Synapse

Attributes:
    repositoryName: The name of the Docker Repository. Usually in the format: [host[:port]/]path.
                    If host is not set, it will default to that of DockerHub.
                    port can only be specified if the host is also specified.
    parent: The parent project or folder
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{repositoryName}{}
\item{parent}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type DockerRepository
}



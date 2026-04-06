# DockerRepository

A Docker repository is a lightweight virtual machine image.

NOTE: synStore()-ing a DockerRepository created in the client will
always result in it being treated as a reference to an external Docker
repository that is not managed by synapse. To upload a docker image that
is managed by Synapse please use the standard Docker client and read
http://docs.synapse.org/articles/docker.html for instructions on
uploading a Docker Image to Synapse

## Format

An R6 class object.

## Methods

- `DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL)`:
  Constructor for
  [`DockerRepository`](https://r-docs.synapse.org/reference/DockerRepository.md)

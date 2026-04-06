# Constructor for objects of type DockerRepository

A Docker repository is a lightweight virtual machine image.

NOTE: store()-ing a DockerRepository created in the Python client will
always result in it being treated as a reference to an external Docker
repository that is not managed by synapse. To upload a docker image that
is managed by Synapse please use the official Docker client and read
http://docs.synapse.org/articles/docker.html for instructions on
uploading a Docker Image to Synapse

## Usage

``` r
DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL)
```

## Arguments

- repositoryName:

  the name of the Docker Repository. Usually in the format:
  \[host\[:port\]/\]path. If host is not set, it will default to that of
  DockerHub. port can only be specified if the host is also specified  

- parent:

  the parent project for the Docker repository  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

## Value

An object of type DockerRepository

## Examples

``` r
if (FALSE) { # \dontrun{
dr <- DockerRepository(repositoryName = "test", parent = "syn123")
dr <- synStore(dr)
} # }
```

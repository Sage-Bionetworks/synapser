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

NOTE: store()-ing a DockerRepository created in the Python client will always result in it being treated as a 
reference to an external Docker repository that is not managed by synapse. 
To upload a docker image that is managed by Synapse please use the official Docker client and read http://docs.synapse.org/articles/docker.html for instructions on uploading a Docker Image to Synapse
}
\usage{
DockerRepository(repositoryName=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)
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
\item{local_state}{     Internal use only}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type DockerRepository
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%
%}
}




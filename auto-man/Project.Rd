%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Project}
\alias{Project}
\docType{methods}
\title{
Constructor for objects of type Project
}
\description{
Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project with a name that's already taken, say
'My project', will result in an error
}
\usage{
Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{            The name of the project\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
}
\value{
An object of type Project
}

 
\examples{
%\dontrun{
%    project = Project('Foobarbat project')
%    project = syn.store(project)
%}
}

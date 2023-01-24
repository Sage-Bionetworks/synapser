%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Folder}
\alias{Folder}
\docType{methods}
\title{
Constructor for objects of type Folder
}
\description{
Represents a folder in Synapse.

Folders must have a name and a parent and can optionally have annotations.
}
\usage{
Folder(name=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{            The name of the folder\cr
}
\item{parent}{          The parent project or folder\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
}
\value{
An object of type Folder
}

 
\examples{
%\dontrun{
%    folder = Folder('my data', parent=project)
%    folder = syn.store(folder)
%}
}

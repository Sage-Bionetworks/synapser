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

Attributes:
    name: The name of the folder
    parent: The parent project or folder
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
Folder(name=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{}
\item{parent}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type Folder
}



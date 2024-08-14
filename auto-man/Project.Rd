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

Attributes:
    name: The name of the project
    alias: The project alias for use in friendly project urls.
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)
}
\arguments{
\item{name}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
\item{alias}{}
}
\value{
An object of type Project
}



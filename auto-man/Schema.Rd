%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Schema}
\alias{Schema}
\docType{methods}
\title{
Constructor for objects of type Schema
}
\description{
A Schema is an [Entity][synapseclient.entity.Entity] that defines a set of columns in a table.

Attributes:
    name:        The name for the Table Schema object
    description: User readable description of the schema
    columns:     A list of [Column][synapseclient.table.Column] objects or their IDs
    parent:      The project in Synapse to which this table belongs
    properties:  A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{}
\item{columns}{}
\item{parent}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type Schema
}

 
\examples{
%\dontrun{
%    cols = [Column(name='Isotope', columnType='STRING'),
%            Column(name='Atomic Mass', columnType='INTEGER'),
%            Column(name='Halflife', columnType='DOUBLE'),
%            Column(name='Discovered', columnType='DATE')]
%}
}

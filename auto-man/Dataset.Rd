%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Dataset}
\alias{Dataset}
\docType{methods}
\title{
Constructor for objects of type Dataset
}
\description{
A Dataset is an [Entity][synapseclient.entity.Entity] that defines a
flat list of entities as a tableview (a.k.a. a "dataset").

Attributes:
    name:          The name for the Dataset object
    description:   User readable description of the schema
    columns:       A list of [Column][synapseclient.table.Column] objects or their IDs
    parent:        The Synapse Project to which this Dataset belongs
    properties:    A map of Synapse properties
    annotations:   A map of user defined annotations
    dataset_items: A list of items characterized by entityId and versionNumber
    folder:        A list of Folder IDs
    local_state:   Internal use only
}
\usage{
Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE)
}
\arguments{
\item{name}{}
\item{columns}{}
\item{parent}{}
\item{properties}{}
\item{addDefaultViewColumns}{}
\item{addAnnotationColumns}{}
\item{ignoredAnnotationColumnNames}{}
\item{annotations}{}
\item{local_state}{}
\item{dataset_items}{}
\item{folders}{}
\item{force}{}
}
\value{
An object of type Dataset
}



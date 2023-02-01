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
A Dataset is an Entity that defines a
flat list of entities as a tableview (a.k.a. a "dataset").
}
\usage{
Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE, description=NULL, folder=NULL)
}
\arguments{
\item{name}{            The name for the Dataset object\cr
}
\item{columns}{         A list of Column objects or their IDs\cr
}
\item{parent}{          The Synapse Project to which this Dataset belongs\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{addDefaultViewColumns}{}
\item{addAnnotationColumns}{}
\item{ignoredAnnotationColumnNames}{}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{dataset_items}{   A list of items characterized by entityId and versionNumber\cr
}
\item{folders}{}
\item{force}{}
\item{description}{optional named parameter:      User readable description of the schema\cr
}
\item{folder}{optional named parameter:           A list of Folder IDs\cr
}
}
\value{
An object of type Dataset
}

 
\examples{
%\dontrun{
%    syn = synapseclient.login()
%    syn.create_snapshot_version(
%        dataset.id,
%        label="v1.0",
%        comment="This is version 1")
%}
}

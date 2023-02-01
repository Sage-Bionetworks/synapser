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
A Schema is an Entity that defines a set of columns in a table.
}
\usage{
Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)
}
\arguments{
\item{name}{            the name for the Table Schema object\cr
}
\item{columns}{         a list of Column objects or their IDs\cr
}
\item{parent}{          the project in Synapse to which this table belongs\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{description}{optional named parameter:      User readable description of the schema\cr
}
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

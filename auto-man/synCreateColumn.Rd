%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreateColumn}
\alias{synCreateColumn}
\docType{methods}
\title{
synCreateColumn
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the `.columns` attribute on table-like classes or `add_column` method to store columns during the storage of these table-like classes.

Creates a new [synapseclient.table.Column][] in Synapse.

Arguments:
    name: The name of the column
    columnType: The column type
    maximumSize: The maximum size of the column
    defaultValue: The default value of the column
    enumValues: The enum values of the column

Returns:
    A [synapseclient.table.Column][] object
}
\usage{
synCreateColumn(name, columnType, maximumSize=NULL, defaultValue=NULL, enumValues=NULL)
}
\arguments{
\item{name}{}
\item{columnType}{}
\item{maximumSize}{}
\item{defaultValue}{}
\item{enumValues}{}
}
\value{

}



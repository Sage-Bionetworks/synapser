%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Row}
\alias{Row}
\docType{methods}
\title{
Constructor for objects of type Row
}
\description{
A [row](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.html) in a Table.

Attributes:
    values:        A list of values
    rowId:         The immutable ID issued to a new row
    versionNumber: The version number of this row. Each row version is immutable, so when a row is updated a
                   new version is created.
}
\usage{
Row(values, rowId=NULL, versionNumber=NULL, etag=NULL)
}
\arguments{
\item{values}{}
\item{rowId}{}
\item{versionNumber}{}
\item{etag}{}
}
\value{
An object of type Row
}



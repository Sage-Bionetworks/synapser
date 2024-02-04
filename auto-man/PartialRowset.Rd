%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{PartialRowset}
\alias{PartialRowset}
\docType{methods}
\title{
Constructor for objects of type PartialRowset
}
\description{
A set of Partial Rows used for updating cells of a table.
PartialRowsets allow you to push only the individual cells you wish to change instead of pushing entire rows with
many unchanged cells.

Attributes:
    schema: The [Schema][synapseclient.table.Schema] of the table to update or its tableId as a string
    rows:   A list of PartialRows
}
\usage{
PartialRowset(schema, rows)
}
\arguments{
\item{schema}{}
\item{rows}{}
}
\value{
An object of type PartialRowset
}



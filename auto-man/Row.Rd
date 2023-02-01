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
A \href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.html}{row} in a Table.
}
\usage{
Row(values, rowId=NULL, versionNumber=NULL, etag=NULL)
}
\arguments{
\item{values}{          A list of values\cr
}
\item{rowId}{           The immutable ID issued to a new row\cr
}
\item{versionNumber}{   The version number of this row. Each row version is immutable, so when a row is updated a\cr
                        new version is created.}
\item{etag}{}
}
\value{
An object of type Row
}



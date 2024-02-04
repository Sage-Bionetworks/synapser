%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Row-class}
\alias{Row-class}
\docType{class}
\title{
Row
}
\format{An R6 class object.}
\description{
A [row](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.html) in a Table.

Attributes:
    values:        A list of values
    rowId:         The immutable ID issued to a new row
    versionNumber: The version number of this row. Each row version is immutable, so when a row is updated a
                   new version is created.
}
\section{Methods}{
\itemize{
\item \code{Row(values, rowId=NULL, versionNumber=NULL, etag=NULL)}: Constructor for \code{\link{Row}}
}
}


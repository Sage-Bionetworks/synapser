%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetColumns}
\alias{synGetColumns}
\docType{methods}
\title{
synGetColumns
}
\description{
Get the columns defined in Synapse either (1) corresponding to a set of column headers, (2) those for a given
schema, or (3) those whose names start with a given prefix.

Arguments:
    x: A list of column headers, a Table Entity object (Schema/EntityViewSchema), a Table's Synapse ID, or a
        string prefix
    limit: maximum number of columns to return (pagination parameter)
    offset: the index of the first column to return (pagination parameter)

Yields:
    A generator over [synapseclient.table.Column][] objects
}
\usage{
synGetColumns(x, limit=100, offset=0)
}
\arguments{
\item{x}{}
\item{limit}{}
\item{offset}{}
}
\value{

}



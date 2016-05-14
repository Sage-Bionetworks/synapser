\name{synGetColumns}
\alias{synGetColumns}
\docType{methods}
\title{
synGetColumns
}
\description{}
\usage{
	synGetColumns(limit=100, offset=0)
}
\arguments{
\item{limit=100}{}
\item{offset=0}{}
}
\details{
Get all columns defined in Synapse, those corresponding to a set of column
headers or those whose names start with a given prefix.

:param x: a list of column headers, a Schema, a TableSchema's Synapse ID, or a string prefix
:Return: a generator of Column objects
}


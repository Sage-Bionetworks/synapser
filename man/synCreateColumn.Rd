\name{synCreateColumn}
\alias{synCreateColumn}
\docType{methods}
\title{
synCreateColumn
}
\description{
This is redundant with synStore(Column(...)) and will be removed.
}
\usage{
synCreateColumn(name, columnType, maximumSize=NULL, defaultValue=NULL, enumValues=NULL)
}
\arguments{
\item{name}{Column name}
\item{columnType}{Column type}
\item{maximumSize}{maximum length of values (only used when columnType is STRING)}
\item{defaultValue}{default values (otherwise defaults to NULL)}
\item{enumValues}{permitted values}
}
\value{
An object of type Column.
}





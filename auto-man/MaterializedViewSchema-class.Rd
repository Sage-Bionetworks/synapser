%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{MaterializedViewSchema-class}
\alias{MaterializedViewSchema-class}
\docType{class}
\title{
MaterializedViewSchema
}
\format{An R6 class object.}
\description{
A MaterializedViewSchema is an Entity that defines a set of columns in a
materialized view along with the SQL statement.
}
\section{Methods}{
\itemize{
\item \code{MaterializedViewSchema(name=NULL, columns=NULL, parent=NULL, definingSQL=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)}: Constructor for \code{\link{MaterializedViewSchema}}
\item \code{addColumn(column)}: 
\item \code{addColumns(columns)}: 
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{removeColumn(column)}: 
}
}


%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{EntityViewSchema-class}
\alias{EntityViewSchema-class}
\docType{class}
\title{
EntityViewSchema
}
\format{An R6 class object.}
\description{
A EntityViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes
}
\section{Methods}{
\itemize{
\item \code{EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{EntityViewSchema}}
\item \code{addColumn(column)}: 
\item \code{addColumns(columns)}: 
\item \code{add_scope(entities)}: 
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{removeColumn(column)}: 
}
}


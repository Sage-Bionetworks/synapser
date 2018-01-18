\name{Schema-class}
\alias{Schema-class}
\docType{class}
\title{
Schema
}
\format{An R6 class object.}
\description{
A Schema is an Entity that defines a set of columns in a table.
}
\section{Methods}{
\itemize{
\item \code{Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)}: Constructor for \code{\link{Schema}}
\item \code{addColumn(column)}: Adds a \code{\link{Column}} to the schema
\item \code{addColumns(columns)}: Adds a list of \code{\link{Column}}s to the schema
\item \code{add_scope(entities)}: Adds a list of entities (usually \code{\link{Project}}s) to the view
\item \code{has_columns()}: Are there any \code{\link{Column}}s specified in the schema?
\item \code{removeColumn(column)}: Removes a \code{\link{Column}} from the schema
}
}


\name{EntityViewSchema-class}
\alias{EntityViewSchema-class}
\docType{class}
\title{
EntityViewSchema
}
\format{An R6 class object.}
\description{
A EntityViewSchema is a Entity that displays all files/projects (depending on user choice) within a given set of scopes
}
\section{Methods}{
\itemize{
\item \code{EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{EntityViewSchema}}
\item \code{addColumn(column)}: Adds a \code{\link{Column}} to the schema
\item \code{addColumns(columns)}: Adds a list of \code{\link{Column}}s to the schema
\item \code{add_scope(entities)}: Adds a list of entities (usually \code{\link{Project}}s) to the view
\item \code{has_columns()}: Are there any \code{\link{Column}}s specified in the schema?
\item \code{removeColumn(column)}: Removes a \code{\link{Column}} from the schema
}
}


\name{SubmissionViewSchema-class}
\alias{SubmissionViewSchema-class}
\docType{class}
\title{
SubmissionViewSchema
}
\format{An R6 class object.}
\description{
A SubmissionViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes
}
\section{Methods}{
\itemize{
\item \code{SubmissionViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{SubmissionViewSchema}}
\item \code{addColumn(column)}:
\item \code{addColumns(columns)}:
\item \code{add_scope(entities)}:
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{removeColumn(column)}:
}
}


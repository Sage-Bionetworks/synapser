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
\item \code{EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL)}: Constructor for \code{\link{EntityViewSchema}}
\item \code{addColumn(column)}: Adds a \code{\link{Column}} to the schema
\item \code{addColumns(columns)}: Adds a list of \code{\link{Column}}s to the schema
\item \code{add_scope(entities)}: Adds a list of entities (usually \code{\link{Project}}s) to the view
\item \code{has_columns()}: Are there any \code{\link{Column}}s specified in the schema?
\item \code{removeColumn(column)}: Removes a \code{\link{Column}} from the schema
}
}
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example().
%
% 
%
% Verified that the following works on 2018Jan23.
% 
\dontrun{
project_or_folder <- synGet("syn123")  
schema <- EntityViewSchema(name='MyFileView', parent=project, scopes=c(project_or_folder_id, 'syn456'), view_type='file')
schema <- synStore(schema)
schema$has_columns()
schema$removeColumn(Column(name="modifiedOn", columnType="DATE"))
another_project<-synGet("syn789")
schema$add_scope(another_project)
schema<-synStore(schema)
}
}

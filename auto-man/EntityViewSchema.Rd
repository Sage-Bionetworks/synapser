%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{EntityViewSchema}
\alias{EntityViewSchema}
\docType{methods}
\title{
Constructor for objects of type EntityViewSchema
}
\description{
A EntityViewSchema is a Entity that displays all files/projects (depending on user choice) within a given set of scopes
}
\usage{
EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, add_default_columns=TRUE, properties=NULL, annotations=NULL, local_state=NULL, view_type=NULL)
}
\arguments{
\item{name}{ give the Entity View Table object a name\cr
}
\item{columns}{ a list of Column objects or their IDs. These are optional\cr
}
\item{parent}{ the project in Synapse to which this table belongs\cr
}
\item{scopes}{ a list of Projects/Folders or their ids\cr
}
\item{type}{}
\item{add_default_columns}{ whether to add the default view columns based on the EntityView. Defaults to True.\cr
The default columns will be added after a call to synStore.\cr
::}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
\item{view_type}{optional named parameter:  the type of EntityView to display: either 'file' or 'project'. Defaults to 'file'\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type EntityViewSchema
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%
%}
}




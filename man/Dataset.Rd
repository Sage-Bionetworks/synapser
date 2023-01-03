\name{Dataset}
\alias{Dataset}
\docType{methods}
\title{
Constructor for objects of type Dataset
}
\description{
A Dataset is an Entity that defines a
flat list of entities as a tableview (a.k.a. a "dataset").
}
\usage{
Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE, description=NULL, folder=NULL)
}
\arguments{
\item{name}{            The name for the Dataset object\cr
}
\item{columns}{         A list of Column objects or their IDs\cr
}
\item{parent}{          The Synapse Project to which this Dataset belongs\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{addDefaultViewColumns}{}
\item{addAnnotationColumns}{}
\item{ignoredAnnotationColumnNames}{}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{dataset_items}{   A list of items characterized by entityId and versionNumber\cr
}
\item{folders}{}
\item{force}{}
\item{description}{optional named parameter:      User readable description of the schema\cr
}
\item{folder}{optional named parameter:           A list of Folder IDs\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Dataset
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
%    syn = synapseclient.login()
%    syn.create_snapshot_version(
%        dataset.id,
%        label="v1.0",
%        comment="This is version 1")
%}
}




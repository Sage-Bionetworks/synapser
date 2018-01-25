%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{RowSet}
\alias{RowSet}
\docType{methods}
\title{
Constructor for objects of type RowSet
}
\description{
A Synapse object of type \href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/RowSet.html}{org.sagebionetworks.repo.model.table.RowSet}.
}
\usage{
RowSet(columns=NULL, schema=NULL, headers=NULL, tableId=NULL, rows=NULL, etag=NULL)
}
\arguments{
\item{columns}{}
\item{schema}{   A Schema object that will be used to set the tableId\cr
}
\item{headers}{optional named parameter:   The list of SelectColumn objects that describe the fields in each row.\cr
}
\item{tableId}{optional named parameter:   The ID of the TableEntity than owns these rows\cr
}
\item{rows}{optional named parameter:      The Rows of this set. The index of each row value aligns with the index of each header.\cr
}
\item{etag}{optional named parameter:        Any RowSet returned from Synapse will contain the current etag of the change set. To update any rows from a RowSet the etag must be provided with the POST.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type RowSet
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

}




\name{MaterializedViewSchema}
\alias{MaterializedViewSchema}
\docType{methods}
\title{
Constructor for objects of type MaterializedViewSchema
}
\description{
A MaterializedViewSchema is an Entity that defines a set of columns in a
materialized view along with the SQL statement.
}
\usage{
MaterializedViewSchema(name=NULL, columns=NULL, parent=NULL, definingSQL=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)
}
\arguments{
\item{name}{            the name for the Materialized View Schema object\cr
}
\item{columns}{         a list of Column objects or their IDs\cr
}
\item{parent}{          the project in Synapse to which this Materialized View belongs\cr
}
\item{definingSQL}{     The synapse SQL statement that defines the data in the materialized view. The SQL may\cr
                        contain JOIN clauses on multiple tables.\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{description}{optional named parameter:      User readable description of the schema\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type MaterializedViewSchema
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
%    defining_sql = "SELECT * FROM syn111 F JOIN syn2222 P on (F.patient_id = P.patient_id)"
%}
}




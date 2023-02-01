%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\value{
An object of type MaterializedViewSchema
}

 
\examples{
%\dontrun{
%    defining_sql = "SELECT * FROM syn111 F JOIN syn2222 P on (F.patient_id = P.patient_id)"
%}
}

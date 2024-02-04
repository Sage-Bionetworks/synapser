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
A MaterializedViewSchema is an [Entity][synapseclient.entity.Entity] that defines a set of columns in a
materialized view along with the SQL statement.

Attributes:
    name:        The name for the Materialized View Schema object
    description: User readable description of the schema
    definingSQL: The synapse SQL statement that defines the data in the materialized view. The SQL                   contain JOIN clauses on multiple tables.
    columns:     A list of [Column][synapseclient.table.Column] objects or their IDs
    parent:      The project in Synapse to which this Materialized View belongs
    properties:  A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
MaterializedViewSchema(name=NULL, columns=NULL, parent=NULL, definingSQL=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{}
\item{columns}{}
\item{parent}{}
\item{definingSQL}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type MaterializedViewSchema
}

 
\examples{
%\dontrun{
%    defining_sql = "SELECT * FROM syn111 F JOIN syn2222 P on (F.patient_id = P.patient_id)"
%}
}

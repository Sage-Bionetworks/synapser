%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Schema-class}
\alias{Schema-class}
\docType{class}
\title{
Schema
}
\format{An R6 class object.}
\description{
A Schema is an [Entity][synapseclient.entity.Entity] that defines a set of columns in a table.

Attributes:
    name:        The name for the Table Schema object
    description: User readable description of the schema
    columns:     A list of [Column][synapseclient.table.Column] objects or their IDs
    parent:      The project in Synapse to which this table belongs
    properties:  A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\section{Methods}{
\itemize{
\item \code{Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL)}: Constructor for \code{\link{Schema}}
\item \code{addColumn(column)}: Store the column\cr
\cr
Arguments:\cr
    column: A column object or its ID\cr
\cr
Raises:\cr
    ValueError: If the given column is not a string, integer or [Column][synapseclient.table.Column] object
\item \code{addColumns(columns)}: Add columns\cr
\cr
Arguments:\cr
    columns: A list of column objects or their ID
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{removeColumn(column)}: Remove column\cr
\cr
Arguments:\cr
    column: A column object or its ID\cr
\cr
Raises:\cr
    ValueError: If the given column is not a string, integer or [Column][synapseclient.table.Column] object
}
}


%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Column-class}
\alias{Column-class}
\docType{class}
\title{
Column
}
\format{An R6 class object.}
\description{
Defines a column to be used in a table [Schema][synapseclient.table.Schema]
[EntityViewSchema][synapseclient.table.EntityViewSchema].

Attributes:
    id:                An immutable ID issued by the platform
    columnType:        The column type determines the type of data that can be stored in a column. It can be any
                       of:

        - `STRING`
        - `DOUBLE`
        - `INTEGER`
        - `BOOLEAN`
        - `DATE`
        - `FILEHANDLEID`
        - `ENTITYID`
        - `LINK`
        - `LARGETEXT`
        - `USERID`

        For more information, please see:
        <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/ColumnType.html>
    maximumSize:       A parameter for columnTypes with a maximum size. For example, ColumnType.STRINGs have a
                       default maximum size of 50 characters, but can be set to a `maximumSize` of 1 to 1000
                       characters.
    maximumListLength: Required if using a columnType with a "_LIST" suffix. Describes the maximum number of
                       values that will appear in that list. Value range 1-100 inclusive. Default 100
    name:              The display name of the column
    enumValues:        Columns type of STRING can be constrained to an enumeration values set on this list.
    defaultValue:      The default value for this column. Columns of type FILEHANDLEID and ENTITYID are not
                       allowed to have default values.
}
\section{Methods}{
\itemize{
\item \code{Column()}: Constructor for \code{\link{Column}}
}
}


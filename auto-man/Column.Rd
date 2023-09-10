%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Column}
\alias{Column}
\docType{methods}
\title{
Constructor for objects of type Column
}
\description{
Defines a column to be used in a table Schema
EntityViewSchema.
}
\usage{
Column(id=NULL, columnType=NULL, maximumSize=NULL, maximumListLength=NULL, name=NULL, enumValues=NULL, defaultValue=NULL)
}
\arguments{
\item{id}{optional named parameter:                   An immutable ID issued by the platform\cr
}
\item{columnType}{optional named parameter:         The column type determines the type of data that can be stored in a column. It can be any\cr
                          of: "STRING", "DOUBLE", "INTEGER", "BOOLEAN", "DATE", "FILEHANDLEID", "ENTITYID", "LINK",\cr
                          "LARGETEXT", "USERID". For more information, please see:\cr
                          https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/ColumnType.html\cr
}
\item{maximumSize}{optional named parameter:        A parameter for columnTypes with a maximum size. For example, ColumnType.STRINGs have a\cr
                          default maximum size of 50 characters, but can be set to a maximumSize of 1 to 1000\cr
                          characters.\cr
}
\item{maximumListLength}{optional named parameter:  Required if using a columnType with a "_LIST" suffix. Describes the maximum number of\cr
                          values that will appear in that list. Value range 1-100 inclusive. Default 100\cr
}
\item{name}{optional named parameter:               The display name of the column\cr
}
\item{enumValues}{optional named parameter:         Columns type of STRING can be constrained to an enumeration values set on this list.\cr
}
\item{defaultValue}{optional named parameter:       The default value for this column. Columns of type FILEHANDLEID and ENTITYID are not\cr
                          allowed to have default values.}
}
\value{
An object of type Column
}



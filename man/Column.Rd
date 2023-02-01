\name{Column}
\alias{Column}
\docType{methods}
\title{
Constructor for objects of type Column
}
\description{
Defines a column to be used in a table Schema, or in an EntityViewSchema.
}
\usage{
Column(id=NULL, columnType=NULL, maximumSize=NULL, maximumListLength=NULL, name=NULL, enumValues=NULL, defaultValue=NULL)
}
\arguments{
\item{id}{optional named parameter:                 An immutable ID issued by the platform\cr
}
\item{columnType}{optional named parameter:         The column type determines the type of data that can be stored in a column. It can be any of: "STRING", "DOUBLE", "INTEGER", "BOOLEAN", "DATE", "FILEHANDLEID", "ENTITYID", "LINK", "LARGETEXT", "USERID". For more information, please see: https://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/ColumnType.html\cr
}
\item{maximumSize}{optional named parameter:        A parameter for columnTypes with a maximum size. For example, ColumnType.STRINGs have a default maximum size of 50 characters, but can be set to a maximumSize of 1 to 1000 characters.\cr
}
\item{maximumListLength}{optional named parameter:  Required if using a columnType with a "_LIST" suffix. Describes the maximum number of\cr
                          values that will appear in that list. Value range 1-100 inclusive. Default 100\cr
}
\item{name}{optional named parameter:               The display name of the column\cr
}
\item{enumValues}{optional named parameter:         Columns type of STRING can be constrained to an enumeration values set on this list.\cr
}
\item{defaultValue}{optional named parameter:       The default value for this column. Columns of type FILEHANDLEID and ENTITYID are not allowed to have default values.}
}
\value{
An object of type Column
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
Column(name='Isotope', columnType='STRING')
Column(name='Atomic Mass', columnType='INTEGER')
Column(name='Halflife', columnType='DOUBLE')
Column(name='Discovered', columnType='DATE')
}
}




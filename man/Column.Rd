\name{Column}
\alias{Column}
\docType{class}
\title{
Column
}
\format{An S3-style class object.}
\description{
A column model contains the metadata of a single column of a table or view.
}
\usage{
Column(id=NULL, name=NULL, column_type=NULL, facet_type=NULL, default_value=NULL, maximum_size=NULL, maximum_list_length=NULL, enum_values=NULL, json_sub_columns=NULL)
}
\arguments{
\item{id}{(Optional[str]) The immutable ID issued to new columns.}
\item{name}{(Optional[str]) The display name of the column.}
\item{column_type}{(Optional[ColumnType]) The column type determines the type of data that can be stored in a column. Switching between types (using a transaction with TableUpdateTransaction in the "changes" list) is generally allowed except for switching to "_LIST" suffixed types. In such cases, a new column must be created and data must be copied over manually.}
\item{facet_type}{(Optional[FacetType]) Set to one of the enumerated values to indicate a column should be treated as a facet.}
\item{default_value}{(Optional[str]) The default value for this column. Columns of type ENTITYID, FILEHANDLEID, USERID, and LARGETEXT are not allowed to have default values.}
\item{maximum_size}{(Optional[int]) A parameter for column types with a maximum size. For example, columns of type "STRING" have a default maximum size of 50 characters, but can be set to a maximum size of 1 to 1000 characters. For a column type of STRING_LIST, this limits the size of individual string elements in the list.}
\item{maximum_list_length}{(Optional[int]) Required if using a column type with a "_LIST" suffix. Describes the maximum number of values that will appear in that list. Value range 1-100 inclusive. Default 100.}
\item{enum_values}{(Optional[list[str]]) Columns of type STRING can be constrained to an enumeration of values set on this list. The maximum number of entries for an enum is 100.}
\item{json_sub_columns}{(Optional[list[JsonSubColumn]]) For a column of type JSON that represents the combination of multiple sub-columns, this property is used to define each sub-column.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Column(id=NULL, name=NULL, column_type=NULL, facet_type=NULL, default_value=NULL, maximum_size=NULL, maximum_list_length=NULL, enum_values=NULL, json_sub_columns=NULL)}: Constructor for \code{\link{Column}}
\item \code{\link[=synList]{synList}(prefix=NULL, limit=100L, offset=0L, synapse_client=NULL)}: List columns with optional prefix filtering.
}
}


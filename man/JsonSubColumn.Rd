\name{JsonSubColumn}
\alias{JsonSubColumn}
\docType{class}
\title{
JsonSubColumn
}
\format{An S3-style class object.}
\description{
For column of type JSON that represents the combination of multiple
sub-columns, this property is used to define each sub-column.
}
\usage{
JsonSubColumn(name, column_type, json_path, facet_type=NULL)
}
\arguments{
\item{name}{(character) The display name of the column.}
\item{column_type}{(ColumnType) The column type determines the type of data that can be stored in a column. Switching between types (using a transaction with TableUpdateTransaction in the "changes" list) is generally allowed except for switching to "_LIST" suffixed types. In such cases, a new column must be created and data must be copied over manually.}
\item{json_path}{(character) Defines the JSON path of the sub column. Use the '$' char to represent the root of JSON object. If the JSON key of a sub column is 'a', then the json_path for that column would be: '$.a'.}
\item{facet_type}{(Optional[FacetType]) Set to one of the enumerated values to indicate a column should be treated as a facet.}
}
\value{
NULL
}
\examples{
\dontrun{
## Defining a JSON column with sub-columns
    library(synapser)
    synLogin()

    json_column = Column(
        name = "my_json_column",
        column_type = "JSON",
        json_sub_columns = list(
            JsonSubColumn(name = "a", column_type = "STRING", json_path = "$.a"),
            JsonSubColumn(name = "b", column_type = "INTEGER", json_path = "$.b", facet_type = "range")
        )
    )
    table = Table(name = "My Table", parent_id = "syn123", columns = list(json_column)) |> synStore()
}
}
\section{Methods}{
\itemize{
\item \code{JsonSubColumn(name, column_type, json_path, facet_type=NULL)}: Constructor for \code{\link{JsonSubColumn}}
}
}

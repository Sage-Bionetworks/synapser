\name{TableOptions}
\alias{TableOptions}
\docType{class}
\title{
TableOptions
}
\format{An S3-style class object.}
\description{
Configuration options for table-like entities when using the factory methods.

This dataclass controls how table-like entities (Table, Dataset, EntityView,
MaterializedView, SubmissionView, VirtualTable, and DatasetCollection) are
retrieved, particularly whether column schema information should be included.
}
\usage{
TableOptions(include_columns=TRUE)
}
\arguments{
\item{include_columns}{(bool) Whether to include column schema information when retrieving table-like entities. If TRUE, the returned entity will have its columns attribute populated with Column objects containing schema information (name, column_type, etc.). If FALSE, the columns attribute will be an empty named list. Including columns may result in additional API calls but provides complete table structure information. Default is TRUE.}
}
\value{
NULL
}
\examples{
\dontrun{
    # Configure table column inclusion:
    library(synapser)

    # Include column schema information
    with_columns = TableOptions(include_columns = TRUE)

    # Skip column information (faster retrieval)
    without_columns = TableOptions(include_columns = FALSE)
}
}
\section{Methods}{
\itemize{
\item \code{TableOptions(include_columns=TRUE)}: Constructor for \code{\link{TableOptions}}
}
}


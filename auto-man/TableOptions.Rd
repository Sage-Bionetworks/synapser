%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{include_columns}{(bool) Whether to include column schema information when retrieving table-like entities. If True, the returned entity will have its columns attribute populated with Column objects containing schema information (name, column_type, etc.). If False, the columns attribute will be an empty dict. Including columns may result in additional API calls but provides complete table structure information. Default is True.}
}
\value{
NULL
}
\examples{
\dontrun{
    # Configure table column inclusion:

    from synapseclient.operations import TableOptions

    # Include column schema information
    with_columns = TableOptions(include_columns=True)

    # Skip column information (faster retrieval)
    without_columns = TableOptions(include_columns=False)
}
}
\section{Methods}{
\itemize{
\item \code{TableOptions(include_columns=TRUE)}: Constructor for \code{\link{TableOptions}}
}
}


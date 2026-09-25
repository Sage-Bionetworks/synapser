%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{ActivityOptions}
\alias{ActivityOptions}
\docType{class}
\title{
ActivityOptions
}
\format{An S3-style class object.}
\description{
Configuration options for entities that support activity/provenance tracking.

This dataclass controls whether activity information (provenance data) should
be included when retrieving entities. Activity information tracks the computational
steps, data sources, and relationships that led to the creation of an entity.
}
\usage{
ActivityOptions(include_activity=FALSE)
}
\arguments{
\item{include_activity}{(bool) Whether to include activity/provenance information when retrieving the entity. If True, the returned entity will have its activity attribute populated with provenance data (if available). If False, the activity attribute will be None. Including activity may result in additional API calls and slower retrieval times. Default is False.}
}
\value{
NULL
}
\examples{
\dontrun{
    # Configure activity inclusion:

    from synapseclient.operations import ActivityOptions

    # Include activity information
    with_activity = ActivityOptions(include_activity=True)

    # Skip activity information (faster retrieval)
    without_activity = ActivityOptions(include_activity=False)
}
}
\section{Methods}{
\itemize{
\item \code{ActivityOptions(include_activity=FALSE)}: Constructor for \code{\link{ActivityOptions}}
}
}
\note{
Activity information is only available for entities that support provenance
    tracking (File, Table, Dataset, etc...). For other entity
    types, this option is ignored.
}


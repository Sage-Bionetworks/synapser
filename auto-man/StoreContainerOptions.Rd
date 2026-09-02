%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{StoreContainerOptions}
\alias{StoreContainerOptions}
\docType{class}
\title{
StoreContainerOptions
}
\format{An S3-style class object.}
\description{
Options for storing container entities (Project, Folder).
}
\usage{
StoreContainerOptions(failure_strategy=NULL)
}
\arguments{
\item{failure_strategy}{(Optional[Union[str, FailureStrategy]]) Strategy for handling failures when storing child entities. Can be either a FailureStrategy enum value or a string. Valid string values: "LOG_EXCEPTION", "RAISE_EXCEPTION". Valid enum values: FailureStrategy.LOG_EXCEPTION, FailureStrategy.RAISE_EXCEPTION.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreContainerOptions(failure_strategy=NULL)}: Constructor for \code{\link{StoreContainerOptions}}
}
}


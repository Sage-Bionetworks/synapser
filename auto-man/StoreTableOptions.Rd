%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{StoreTableOptions}
\alias{StoreTableOptions}
\docType{class}
\title{
StoreTableOptions
}
\format{An S3-style class object.}
\description{
Options for storing Table-like entities.
}
\usage{
StoreTableOptions(dry_run=FALSE, job_timeout=600L)
}
\arguments{
\item{dry_run}{(bool) If True, will not actually store but will log what would be done.}
\item{job_timeout}{(int) Maximum time to wait for table schema update job to complete.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreTableOptions(dry_run=FALSE, job_timeout=600L)}: Constructor for \code{\link{StoreTableOptions}}
}
}


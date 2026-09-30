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
\item{dry_run}{(bool) If TRUE, will not actually store but will log what would be done.}
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


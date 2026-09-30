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
\item{failure_strategy}{(Optional[str]) Strategy for handling failures when storing child entities. One of \code{"LOG_EXCEPTION"} or \code{"RAISE_EXCEPTION"}.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreContainerOptions(failure_strategy=NULL)}: Constructor for \code{\link{StoreContainerOptions}}
}
}


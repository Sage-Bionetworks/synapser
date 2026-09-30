\name{StoreGridOptions}
\alias{StoreGridOptions}
\docType{class}
\title{
StoreGridOptions
}
\format{An S3-style class object.}
\description{
Options for storing Grid entities.
}
\usage{
StoreGridOptions(attach_to_previous_session=FALSE, timeout=120L)
}
\arguments{
\item{attach_to_previous_session}{(bool) If TRUE and using record_set_id, will attach to an existing active session if one exists.}
\item{timeout}{(int) The number of seconds to wait for the job to complete.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StoreGridOptions(attach_to_previous_session=FALSE, timeout=120L)}: Constructor for \code{\link{StoreGridOptions}}
}
}


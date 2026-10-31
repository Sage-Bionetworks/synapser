\name{UsedURL}
\alias{UsedURL}
\docType{class}
\title{
UsedURL
}
\format{An S3-style class object.}
\description{
URL that was used or executed by an Activity such as a link to a
GitHub commit or a link to a specific version of a software tool.
}
\usage{
UsedURL(name=NULL, url=NULL)
}
\arguments{
\item{name}{(Optional[str]) The name of the URL.}
\item{url}{(Optional[str]) The external URL of the file that was used such as a link to a GitHub commit or a link to a specific version of a software tool.}
}
\value{
NULL
}
\examples{
\dontrun{
## Recording a URL used to produce a file
    library(synapser)
    synLogin()

    activity = Activity(
        name = "Analysis",
        used = list(UsedURL(name = "Reference genome", url = "https://www.ncbi.nlm.nih.gov/grc/human")),
        executed = list(UsedURL(name = "Analysis code", url = "https://github.com/my-org/my-analysis"))
    )
    activity = activity |> synStore(parent = "syn123")
}
}
\section{Methods}{
\itemize{
\item \code{UsedURL(name=NULL, url=NULL)}: Constructor for \code{\link{UsedURL}}
}
}


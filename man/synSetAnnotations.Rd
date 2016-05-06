\name{synSetAnnotations}
\alias{synSetAnnotations}
\docType{methods}
\title{
synSetAnnotations
}
\description{
Set all the annotations on an entity.
}
\usage{synSetAnnotations(entity)<-values}
\arguments{
	\item{entity}{
	The entity on which to set the annotations.
	}
	\item{values}{
	A named list in which the names are the annotation names and the values are the annotation values.
	}
}
\examples{
\dontrun{
  f <- File(path="/path/to/my/file.csv", parentId="syn1234")
  synSetAnnotations(f) <- list(tissueType="colon",  platform="rnaseq")
}
}
\seealso{
\code{\link{synGetAnnotations}}
\code{\link{synGetProperties}}
\code{\link{synSetProperties}}
\code{\link{synGetAnnotation}}
\code{\link{synSetAnnotation}}
\code{\link{synGetProperty}}
\code{\link{synSetProperty}}
}

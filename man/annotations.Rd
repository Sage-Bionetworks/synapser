\name{annotations}
\alias{annotations}
\alias{annotationValues}
\alias{annotationValues<-}
\alias{annotValue}
\alias{annotValue<-}
\alias{deleteAnnotation}
\title{
Entity Annotations
}
\description{
Functions for manipulating object annotations
}
\usage{
annotations(object)
annotationValues(object)
annotValue(object, which)
deleteAnnotation(object, which)
}
\arguments{
  \item{object}{
The object whose annotations are being modified.
}
\item{which}{
An annotation name
}
}
\value{
for deleteAnnotation and annotValue:
The modified object.

for annotations:
an object of class SynapseAnnotations.

for annotValue:
the value stored for the annotation specified by "which"

}

\details{
annotValue is used to get or set a single annotation value. annotationValues is used to get all
annotations as a list or to assign the elements of the list as annotations.

the annotations() function should generally not be called by the end-user and may be deprecated
in the future.
}
\note{
when using \code{annotationValues<-}, if the object already has an annotation with the same name
as an element in the list, it's value will be overwritten.
}

\author{
Matt Furia
}

\seealso{
\code{\link{properties}}
}

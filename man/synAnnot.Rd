\name{synAnnot}
\alias{synAnnot}
\title{
synAnnot
}
\description{
Get/set properties/annotations on a Synapse Entity
}
\usage{
synAnnot(entity, attribute)<-value
synAnnot(entity, attribute)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{entity}{
The entity whose properties/annotations are to be set/retrieved.
} 
 \item{attribute}{
The name of the property or value to be set/retrieved.
}
}
\value{
The attribute value.
}
\examples{
\dontrun{
	synAnnot(entity, "name")<-"syn101"
	synAnnot(entity, "tissueType")<-"plasma"
	synAnnot(entity, "id")
}
}


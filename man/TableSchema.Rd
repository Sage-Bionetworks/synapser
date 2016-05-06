\name{TableSchema}
\alias{TableSchema}
\docType{methods}
\title{
TableSchema Constructor
}
\description{Constructor for TableSchema}
\usage{TableSchema(name, parent, columns, ...)}
\arguments{
  \item{name}{
  the name of the new table schema
  }
   \item{parent}{
   the parent entity (either its ID or the entity itself)
  }
   \item{columns}{
   a list or vector of the IDs of the columns to be included in the table schema, or of the column objects themselves
  }
}

\seealso{
\code{\link{synStore},\link{synGet}}
}

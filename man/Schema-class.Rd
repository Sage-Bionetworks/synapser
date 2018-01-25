\name{Schema-class}
\alias{Schema-class}
\docType{class}
\title{
Schema
}
\format{An R6 class object.}
\description{
A Schema is an Entity that defines a set of columns in a table.
}
\section{Methods}{
\itemize{
\item \code{Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, description=NULL)}: Constructor for \code{\link{Schema}}
\item \code{addColumn(column)}: Adds a \code{\link{Column}} to the schema
\item \code{addColumns(columns)}: Adds a list of \code{\link{Column}}s to the schema
\item \code{has_columns()}: Are there any \code{\link{Column}}s specified in the schema?
\item \code{removeColumn(column)}: Removes a \code{\link{Column}} from the schema
}
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
schema <- Schema(name='MyTable', parent=project)
schema$addColumn(Column(name='Isotope', columnType='STRING'))
cols <- c(Column(name='Atomic Mass', columnType='INTEGER'),
	Column(name='Halflife', columnType='DOUBLE'),
	Column(name='Discovered', columnType='DATE'))
schema$addColumns(cols)
schema$has_columns()
schema$removeColumn(Column(name='Discovered', columnType='DATE'))
schema <- synStore(schema)
}
}

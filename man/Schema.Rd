\name{Schema}
\alias{Schema}
\docType{methods}
\title{
Constructor for objects of type Schema
}
\description{
A Schema is an Entity that defines a set of columns in a table.
}
\usage{
Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, description=NULL)
}
\arguments{
\item{name}{ the name for the Table Schema object\cr
}
\item{columns}{ a list of Column objects or their IDs\cr
}
\item{parent}{ the project in Synapse to which this table belongs\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{description}{optional named parameter:  User readable description of the schema\cr
}
}
\value{
An object of type Schema
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
cols <- c(Column(name='Isotope', columnType='STRING'),
	Column(name='Atomic Mass', columnType='INTEGER'),
	Column(name='Halflife', columnType='DOUBLE'),
	Column(name='Discovered', columnType='DATE'))

schema <- synStore(Schema(name='MyTable', columns=cols, parent=project))
}
}




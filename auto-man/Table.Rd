%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Table}
\alias{Table}
\docType{methods}
\title{
Table
}
\description{
Combine a table schema and a set of values into some type of Table object
depending on what type of values are given.
}
\usage{
Table(schema, values)
}
\arguments{
\item{schema}{ a table Schema object or Synapse Id of Table.\cr
}
\item{values}{ an object that holds the content of the tables\cr
                  - a RowSet\cr
                  - a list of lists (or tuples) where each element is a row\cr
                  - a string holding the path to a CSV file\cr
                  - a Pandas \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{DataFrame}\cr
                  - a dict which will be wrapped by a Pandas                        \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{DataFrame}}
}
\value{
 a Table object suitable for storing
}



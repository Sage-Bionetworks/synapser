%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{build_table}
\alias{build_table}
\docType{methods}
\title{
build_table
}
\description{
Build a Table object
}
\usage{
build_table(name, parent, values)
}
\arguments{
\item{name}{    the name for the Table Schema object\cr
}
\item{parent}{  the project in Synapse to which this table belongs\cr
}
\item{values}{  an object that holds the content of the tables\cr
                    - a string holding the path to a CSV file\cr
                    - a Pandas \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{DataFrame}}
}
\value{
 a Table object suitable for storing
}

 
\examples{
%\dontrun{
%    path = "/path/to/file.csv"
%    table = build_table("simple_table", "syn123", path)
%    table = syn.store(table)
%}
}

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

Arguments:
    name:    The name for the Table Schema object
    parent:  The project in Synapse to which this table belongs
    values:  An object that holds the content of the tables

        - A string holding the path to a CSV file
        - A [Pandas DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe)

Returns:
    A Table object suitable for storing
}
\usage{
build_table(name, parent, values)
}
\arguments{
\item{name}{}
\item{parent}{}
\item{values}{}
}
\value{

}

 
\examples{
%\dontrun{
%    path = "/path/to/file.csv"
%    table = build_table("simple_table", "syn123", path)
%    table = syn.store(table)
%}
}

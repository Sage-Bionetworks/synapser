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

Arguments:
    schema: A table [Schema][synapseclient.table.Schema] object or Synapse Id of Table.
    values: An object that holds the content of the tables

        - A [RowSet][synapseclient.table.RowSet]
        - A list of lists (or tuples) where each element is a row
        - A string holding the path to a CSV file
        - A [Pandas DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe)
        - A dict which will be wrapped by a [Pandas DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe)

Returns:
    A Table object suitable for storing

Usually, the immediate next step after creating a Table object is to store it:

    table = syn.store(Table(schema, values))

End users should not need to know the details of these Table subclasses:

- [TableAbstractBaseClass][synapseclient.table.TableAbstractBaseClass]
- [RowSetTable][synapseclient.table.RowSetTable]
- [TableQueryResult][synapseclient.table.TableQueryResult]
- [CsvFileTable][synapseclient.table.CsvFileTable]
}
\usage{
Table(schema, values)
}
\arguments{
\item{schema}{}
\item{values}{}
}
\value{

}



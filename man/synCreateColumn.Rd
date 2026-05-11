\name{synCreateColumn}
\alias{synCreateColumn}
\docType{methods}
\title{
synCreateColumn
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the `.columns` attribute on table-like classes or `add_column` method to store columns during the storage of these table-like classes.
For individual column operations, use the synapseclient.api.table_services.post_columns function. 

Creates a new Column in Synapse.

}
\usage{
synCreateColumn(name, columnType, maximumSize=NULL, defaultValue=NULL, enumValues=NULL)
}
\arguments{
\item{name}{Column name}
\item{columnType}{Column type}
\item{maximumSize}{maximum length of values (only used when columnType is STRING)}
\item{defaultValue}{default values (otherwise defaults to NULL)}
\item{enumValues}{permitted values}
}
\value{
A Column object that has been created in Synapse
}





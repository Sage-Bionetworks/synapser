\name{synCreateColumns}
\alias{synCreateColumns}
\docType{methods}
\title{
synCreateColumns
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the `.columns` attribute on table-like classes or `add_column` method to store columns during the storage of these table-like classes.
For individual column operations, use the synapseclient.api.table_services.post_columns function. 

Creates a batch of Columns in Synapse.
}
\usage{
synCreateColumns(columns)
}
\arguments{
\item{columns}{ a list of Column objects}
}
\value{
A list of Column objects that have been created in Synapse
}





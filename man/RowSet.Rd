\name{RowSet}
\alias{RowSet}
\docType{methods}
\title{
Constructor for objects of type RowSet
}
\description{
A Synapse object of type \href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/RowSet.html}{RowSet}.
}
\usage{
RowSet(columns=NULL, schema=NULL, headers=NULL, tableId=NULL, rows=NULL, etag=NULL)
}
\arguments{
\item{columns}{  An alternative to 'headers', a list of column objects that describe the fields in each row.\cr
}
\item{schema}{   A Schema object that will be used to set the tableId\cr
}
\item{headers}{optional named parameter:   The list of SelectColumn objects that describe the fields in each row.\cr
}
\item{tableId}{optional named parameter:   The ID of the TableEntity that owns these rows\cr
}
\item{rows}{optional named parameter:      The Row s of this set. The index of each row value aligns with the index of each header.\cr
}
\item{etag}{optional named parameter:        Any RowSet returned from Synapse will contain the current etag of the change set. To update any rows from a RowSet the etag must be provided with the POST.}
}
\value{
An object of type RowSet
}





%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{RowSet}
\alias{RowSet}
\docType{methods}
\title{
Constructor for objects of type RowSet
}
\description{
A Synapse object of type [org.sagebionetworks.repo.model.table.RowSet](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/RowSet.html).

Attributes:
    schema:  A [Schema][synapseclient.table.Schema] object that will be used to set the tableId
    headers: The list of SelectColumn objects that describe the fields in each row.
    columns: An alternative to 'headers', a list of column objects that describe the fields in each row.
    tableId: The ID of the TableEntity that owns these rows
    rows:    The [Row][synapseclient.table.Row] s of this set. The index of each row value aligns with the
             index of each header.
    etag:    Any RowSet returned from Synapse will contain the current etag of the change set. To update any
             rows from a RowSet the etag must be provided with the POST.
}
\usage{
RowSet(columns=NULL, schema=NULL)
}
\arguments{
\item{columns}{}
\item{schema}{}
}
\value{
An object of type RowSet
}



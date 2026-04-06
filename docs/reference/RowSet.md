# Constructor for objects of type RowSet

A Synapse object of type
[RowSet](http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/RowSet.md).

## Usage

``` r
RowSet(columns=NULL, schema=NULL, headers=NULL, tableId=NULL, rows=NULL, etag=NULL)
```

## Arguments

- columns:

  An alternative to 'headers', a list of column objects that describe
  the fields in each row.  

- schema:

  A Schema object that will be used to set the tableId  

- headers:

  optional named parameter: The list of SelectColumn objects that
  describe the fields in each row.  

- tableId:

  optional named parameter: The ID of the TableEntity that owns these
  rows  

- rows:

  optional named parameter: The Row s of this set. The index of each row
  value aligns with the index of each header.  

- etag:

  optional named parameter: Any RowSet returned from Synapse will
  contain the current etag of the change set. To update any rows from a
  RowSet the etag must be provided with the POST.

## Value

An object of type RowSet

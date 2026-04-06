# Constructor for objects of type Row

A
[row](http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.md)
in a Table.

## Usage

``` r
Row(values, rowId=NULL, versionNumber=NULL, etag=NULL)
```

## Arguments

- values:

  A list of values  

- rowId:

  The immutable ID issued to a new row  

- versionNumber:

  The version number of this row. Each row version is immutable, so when
  a row is updated a new version is created.

- etag:

## Value

An object of type Row

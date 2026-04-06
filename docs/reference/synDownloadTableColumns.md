# synDownloadTableColumns

Bulk download of table-associated files.

## Usage

``` r
synDownloadTableColumns(table, columns)
```

## Arguments

- table:

  table query result  

- columns:

  a list of column names as character strings

## Value

a named list whose names are file handle IDs and values are paths to
downloaded files in the local file system

## Examples

``` r
if (FALSE) { # \dontrun{
tableId<-"syn1234567"
results <- synTableQuery(sprintf("select * from %s ", tableId))
fileAttachments<-synDownloadTableColumns(results, "Attachments")
} # }
```

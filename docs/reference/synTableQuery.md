# synTableQuery

Query a Synapse Table.

## Usage

``` r
synTableQuery(query, resultsAs="csv", offset=NULL, isConsistent=NULL, quoteCharacter=NULL, escapeCharacter=NULL, lineEnd=NULL, separator=NULL, header=NULL, includeRowIdAndRowVersion=NULL)
```

## Arguments

- query:

  query string in a [SQL-like
  syntax](http://docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.md),
  for example  
  "SELECT \* from syn12345"  
    

- resultsAs:

  select whether results are returned as a CSV file ("csv") or
  incrementally downloaded as sets of rows ("rowset").

- offset:

  optional named parameter: don't return the first n rows, defaults to 0

- isConsistent:

  optional named parameter: (\*\*DEPRECATED\*\*)

- quoteCharacter:

  optional named parameter: default double quote  

- escapeCharacter:

  optional named parameter: default backslash  

- lineEnd:

  optional named parameter: defaults to os.linesep  

- separator:

  optional named parameter: defaults to comma  

- header:

  optional named parameter: TRUE by default  

- includeRowIdAndRowVersion:

  optional named parameter: TRUE by default

## Value

A Table object that serves as a wrapper around a CSV file (or generator
over Row objects if resultsAs="rowset").

## Examples

``` r
if (FALSE) { # \dontrun{
tableId<-"syn1234567"
results <- synTableQuery(sprintf("select * from %s where Chromosome='1' and Start < 41000 and End > 20000", tableId))
results$filepath
as.data.frame(results)
} # }
```

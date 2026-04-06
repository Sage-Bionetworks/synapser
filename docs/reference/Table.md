# Table

Combine a table schema and a set of values into some type of Table
object depending on what type of values are given.

## Usage

``` r
Table(schema, values)
```

## Arguments

- schema:

  a table Schema object, or the Synapse ID of a Table  

- values:

  an object that holds the content of the tables:  
  - a data frame  
  - a RowSet  
  - a string holding the path to a CSV file  

## Value

a Table object suitable for storing

## See also

[Tables Vignette](https://r-docs.synapse.org/articles/tables.html)

## Examples

``` r
if (FALSE) { # \dontrun{
# Define the table's column schema
cols <- list(
    Column(name = 'Name', columnType = 'STRING', maximumSize = 20),
    Column(name = 'Chromosome', columnType = 'STRING', maximumSize = 20),
    Column(name = 'Start', columnType = 'INTEGER'),
    Column(name = 'End', columnType = 'INTEGER'),
    Column(name = 'Strand', columnType = 'STRING', enumValues = list('+', '-'), maximumSize = 1),
    Column(name = 'TranscriptionFactor', columnType = 'BOOLEAN'))

# create the schema
schema <- Schema(name = 'My Favorite Genes', columns = cols, parent = project)

# define the data to be added to the table
genes <- data.frame(
  Name = c("foo", "arg", "zap", "bah", "bnk", "xyz"),
  Chromosome = c(1,2,2,1,1,1),
  Start = c(12345,20001,30033,40444,51234,61234),
  End = c(126000,20200,30999,41444,54567,68686),
  Strand = c('+', '+', '-', '-', '+', '+'),
  TranscriptionFactor = c(F,F,F,F,T,F))

# now add the data to the table and save
table <- Table(schema, genes)
table <- synStore(table)

# after the Table is created, it can be updated using its ID
table_id <- table$tableId
table <- synStore(Table(table_id, genes))
} # }
```

# synBuildTable

Build a Table object

## Usage

``` r
synBuildTable(name, parent, values)
```

## Arguments

- name:

  the name for the Table Schema object  

- parent:

  the project in Synapse to which this table belongs  

- values:

  an object that holds the content of the tables  
  - a string holding the path to a CSV file  
  - a data.frame

## Value

a Table object suitable for storing

## Examples

``` r
if (FALSE) { # \dontrun{
path <- "/path/to/file.csv"
table <- synBuildTable("simple_table", "syn123", path)
table <- synStore(table)

genes <- data.frame(
    Name = c("foo", "arg", "zap", "bah", "bnk", "xyz"),
    Chromosome = c(1, 2, 2, 1, 1, 1),
    Start = c(12345, 20001, 30033, 40444, 51234, 61234),
    End = c(126000, 20200, 30999, 41444, 54567, 68686),
    Strand = c("+", "+", "-", "-", "+", "+"),
    TranscriptionFactor = c(F, F, F, F, T, F))
table2 = synBuildTable("My Favorite Genes", project, genes)
table2 <- synStore(table2)
} # }
```

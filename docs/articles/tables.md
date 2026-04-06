# Tables

## Tables

Synapse Tables enable storage of tabular data in Synapse in a form that
can be queried using a SQL-like query language.

A table has a Schema and holds a set of rows conforming to that schema.

A Schema defines a series of Column of the following types: STRING,
DOUBLE, INTEGER, BOOLEAN, DATE, ENTITYID, FILEHANDLEID, LINK, LARGETEXT,
USERID

Preliminaries:

``` r
library(synapser)
## 
## TERMS OF USE NOTICE:
##   When using Synapse, remember that the terms and conditions of use require that you:
##   1) Attribute data contributors when discussing these data or results from these data.
##   2) Not discriminate, identify, or recontact individuals or groups represented by the data.
##   3) Use and contribute only data de-identified to HIPAA standards.
##   4) Redistribute data only under these same terms of use.
synLogin()
## NULL
# Create a new project
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)
```

Let’s say we have some data stored in an R data.frame:

``` r
genes <- data.frame(
  Name = c("foo", "arg", "zap", "bah", "bnk", "xyz"),
  Chromosome = c(1, 2, 2, 1, 1, 1),
  Start = c(12345, 20001, 30033, 40444, 51234, 61234),
  End = c(126000, 20200, 30999, 41444, 54567, 68686),
  Strand = c("+", "+", "-", "-", "+", "+"),
  TranscriptionFactor = c(F, F, F, F, T, F),
  Time = as.POSIXlt(c("2017-02-14 11:23:11.024", "1970-01-01 00:00:00.000", "2018-10-01 00:00:00.000", "2020-11-03 04:59:59.999", "2011-12-16 06:23:11.139", "1999-03-18 21:03:33.044"), tz = "UTC", format = "%Y-%m-%d %H:%M:%OS"))
```

To create a Table with name “My Favorite Genes” with `project` as
parent:

``` r
table <- synBuildTable("My Favorite Genes", project, genes)
table$schema
## Schema(concreteType='org.sagebionetworks.repo.model.table.TableEntity', columnIds=[], name='My Favorite Genes', columns_to_store=[{'name': 'Name', 'columnType': 'STRING', 'maximumSize': 30, 'defaultValue': '', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'Chromosome', 'columnType': 'INTEGER', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'Start', 'columnType': 'INTEGER', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'End', 'columnType': 'INTEGER', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'Strand', 'columnType': 'STRING', 'maximumSize': 30, 'defaultValue': '', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'TranscriptionFactor', 'columnType': 'BOOLEAN', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}, {'name': 'Time', 'columnType': 'INTEGER', 'concreteType': 'org.sagebionetworks.repo.model.table.ColumnModel'}], parentId='syn74360935')
```

`synBuildTable` creates a Table Schema based on the data and returns a
Table object that can be stored in Synapse using
[`synStore()`](https://r-docs.synapse.org/reference/synStore.md). To
create a custom Table Schema, defines the columns of the table:

``` r
cols <- list(
    Column(name = "Name", columnType = "STRING", maximumSize = 20),
    Column(name = "Chromosome", columnType = "STRING", maximumSize = 20),
    Column(name = "Start", columnType = "INTEGER"),
    Column(name = "End", columnType = "INTEGER"),
    Column(name = "Strand", columnType = "STRING", enumValues = list("+", "-"), maximumSize = 1),
    Column(name = "TranscriptionFactor", columnType = "BOOLEAN"),
    Column(name = "Time", columnType = "DATE"))

schema <- Schema(name = "My Favorite Genes", columns = cols, parent = project)

table <- Table(schema, genes)
```

Let’s store that in Synapse:

``` r
table <- synStore(table)
tableId <- table$tableId
```

The Table() function takes two arguments, a schema object, or a Table ID
and data in some form, which can be:

- a path to a CSV file
- a data frame
- a RowSet object
- a list of lists where each of the inner lists is a row

We now have a table populated with data. Let’s try to query:

``` r
results <- synTableQuery(sprintf('select * from %s where Chromosome=1 and Start < 41000 and "End" > 20000', tableId), resultsAs = 'csv')
```

[`synTableQuery()`](https://r-docs.synapse.org/reference/synTableQuery.md)
downloads the data and saves it to a csv file at location:

``` r
results$filepath
```

To load the data into an R data.frame:

``` r
df <- as.data.frame(results)
```

## Changing Data

Once the schema is settled, changes come in two flavors: appending new
rows and updating existing ones.

Changing data in a table requires row IDs and version numbers for each
row to be modified (called `ROW_ID` and `ROW_VERSION`). We get those by
querying before updating. Minimizing change sets to contain only rows
that actually change will make processing faster. Appending new rows can
be accomplished by leaving values for `ROW_ID` and `ROW_VERSION` blank.

Appending new rows is fairly straightforward. To continue the previous
example, we might add some new genes:

``` r
moreGenes <- data.frame(
  Name = c("abc", "def"),
  Chromosome = c(2, 2),
  Start = c(12345, 20001),
  End = c(126000, 20200),
  Strand = c("+", "+"),
  TranscriptionFactor = c(F, F),
  Time = as.POSIXlt(c("2070-01-12 03:53:12.169", "2018-05-03 12:03:33.464"), tz = "UTC", format = "%Y-%m-%d %H:%M:%OS"))
synStore(Table(tableId, moreGenes))
## <synapseclient.table.CsvFileTable object at 0x16e90b9a0>
```

For example, let’s update the names of some of our favorite genes:

``` r
results <- synTableQuery(sprintf("select * from %s where Chromosome='1'", tableId))
df <- as.data.frame(results)
df["Name"] <- c("rzing", "zing1", "zing2", "zing3")
```

Let’s save that:

``` r
table <- Table(tableId, df)
table <- synStore(table)
```

Now, query the table again to see your changes:

``` r
results <- synTableQuery(sprintf("select * from %s limit 10", tableId))
as.data.frame(results)
##   ROW_ID ROW_VERSION  Name Chromosome Start    End Strand TranscriptionFactor
## 1      1           3 rzing          1 12345 126000      +               FALSE
## 2      2           1   arg          2 20001  20200      +               FALSE
## 3      3           1   zap          2 30033  30999      -               FALSE
## 4      4           3 zing1          1 40444  41444      -               FALSE
## 5      5           3 zing2          1 51234  54567      +                TRUE
## 6      6           3 zing3          1 61234  68686      +               FALSE
## 7      7           2   abc          2 12345 126000      +               FALSE
## 8      8           2   def          2 20001  20200      +               FALSE
##                  Time
## 1 2017-02-14 11:23:11
## 2 1970-01-01 00:00:00
## 3 2018-10-01 00:00:00
## 4 2020-11-03 04:59:59
## 5 2011-12-16 06:23:11
## 6 1999-03-18 21:03:33
## 7 2070-01-12 03:53:12
## 8 2018-05-03 12:03:33
```

One other piece of information required for making changes to tables is
the etag, which is used by the Synapse server to prevent concurrent
users from making conflicting changes through a technique called
optimistic concurrency. This comes as a result of running
`synTableQuery`. In the example above, you could see the etag by running
`results$etag` - but you should never have to use it directly. In case
of a conflict, your update may be rejected. You then have to do another
query and try your update again.

## Changing Table Structure

Adding columns can be done using the methods Schema\$addColumn() or
addColumns() on the Schema object:

``` r
schema <- synGet(tableId)
newColumn <- synStore(Column(name = "Note", columnType = "STRING", maximumSize = 20))
schema$addColumn(newColumn)
schema <- synStore(schema)
```

In the example above, we do know what `newColumn` is. While working with
other columns, you can retrieve all columns a table has by using
[`synGetTableColumns()`](https://r-docs.synapse.org/reference/synGetTableColumns.md):

``` r
columns <- as.list(synGetTableColumns(tableId))
```

You can then explore the list of columns to find the column you want to
modify.

Renaming or otherwise modifying a column involves removing the column
and adding a new column:

``` r
notesColumn <- synStore(Column(name = "Notes", columnType = "STRING", maximumSize = 20))
schema <- synGet(tableId)
schema$removeColumn(newColumn)
schema$addColumn(notesColumn)
schema <- synStore(schema)
```

Now we can set the values for the new column:

``` r
results <- synTableQuery(sprintf("SELECT * FROM %s", tableId))
data <- as.data.frame(results)
data["Notes"] <- c("check name", NA, NA, NA, "update test", NA, NA, NA)
synStore(Table(tableId, data))
```

## Updating Column Type

Column “Notes” has type STRING with “maximumSize” set to 20. We cannot
add a new row with “Notes” as “a very looooooooong note” since it has
more than 20 characters. Let”s change the ColumnType to “STRING” with
“maximumSize” set to 100:

``` r
# getting the existing table metadata and data
originalSchema <- synGet(tableId)
oldQueryResults <- synTableQuery(sprintf("SELECT * FROM %s", tableId))
oldData <- as.data.frame(oldQueryResults)

# remove the column
originalSchema$removeColumn(notesColumn)
newSchema <- synStore(originalSchema)

# create a new Column
newCol <- Column(name = "Notes", columnType = "STRING", maximumSize = 100)

# add the new column to the new table
newSchema$addColumn(newCol)
newSchema <- synStore(newSchema)

# copy the data over to the new column
newQueryResults <- synTableQuery(sprintf("SELECT * FROM %s", newSchema$properties$id))
newData <- as.data.frame(newQueryResults)
newData["Notes"] <- oldData["Notes"]

# save the change
synStore(Table(tableId, newData))

# add the new data
moreGenes <- data.frame(
    Name = c("not_sure"),
    Chromosome = c(2),
    Start = c(12345),
    End = c(126000),
    Strand = c("+"),
    TranscriptionFactor = c(F),
    Time = as.POSIXlt("2014-07-03 20:12:44.000", tz = "UTC", format = "%Y-%m-%d %H:%M:%OS"),
    Notes = c("a very looooooooong note"))
synStore(Table(tableId, moreGenes))
```

To access a column that you do not have a reference to, please see:

``` r
?synGetColumn
?synGetColumns
```

### Notes on Dates and Times

In Synapse tables, the DATE type is stored as a timestamp integer,
equivalent to the number of *milliseconds* that have passed since
1970-01-01 00:00:00 UTC. R has built in `POSIXt` types that are similar,
though they are numerics that store time in *seconds*. When values of
type `POSIXt` are uploaded to Synapse tables in synapser, values are
automatically converted to millisecond timestamps. Conversely, values in
Synapse table columns of type DATE are automatically converted to
`POSIXlt` by synapser.

When adding or changing dates, they may be `POSIXt` times.

``` r
timestamp <- as.numeric(as.POSIXlt("1980-01-01", tz = "UTC", format = "%Y-%m-%d")) * 1000
results <- synTableQuery(sprintf("select * from %s where \"Time\" < %.0f", tableId, timestamp))
df <- as.data.frame(results)
df$Time <- as.POSIXlt("2015-07-04 05:22", tz = "UTC", format = "%Y-%m-%d %H:%M")
synStore(Table(tableId, moreGenes))
## <synapseclient.table.CsvFileTable object at 0x16fb4dd80>
```

Dates may also be submitted in timestamp milliseconds:

``` r
results <- synTableQuery(sprintf("select * from %s where Name='zap'", tableId))
df <- as.data.frame(results)
df$Time <- timestamp
synStore(Table(tableId, moreGenes))
## <synapseclient.table.CsvFileTable object at 0x16fb66560>
```

Note that using `POSIXlt` is strongly preferred over `POSIXct`, because
`POSIXct` does not store values with enough precision to reliably
recover milliseconds. For more information, see the R documentation:

``` r
?as.POSIXlt
```

## Table Attached Files

Synapse tables support a special column type called ‘File’ which contain
a file handle, an identifier of a file stored in Synapse. Here’s an
example of how to upload files into Synapse, associate them with a table
and read them back later:

``` r
newCols <- list(
    Column(name = "artist", columnType = "STRING", maximumSize = 50),
    Column(name = "album", columnType = "STRING", maximumSize = 50),
    Column(name = "year", columnType = "INTEGER"),
    Column(name = "catalog", columnType = "STRING", maximumSize = 50),
    Column(name = "covers", columnType = "FILEHANDLEID"))
newSchema <- synStore(Schema(name = "Jazz Albums", columns = newCols, parent = project))

newData <- data.frame(
  artist = c("John Coltrane", "Sonny Rollins", "Sonny Rollins", "Kenny Burrel"),
  album = c("Blue Train", "Vol. 2", "Newk's Time", "Kenny Burrel"),
  year = c(1957, 1957, 1958, 1956),
  catalog = c("BLP 1577", "BLP 1558", "BLP 4001", "BLP 1543")
)

# writing some temp files to upload or pointing to existing files in your system

files <- c("coltraneBlueTrain.jpg", "rollinsBN1558.jpg", "rollinsBN4001.jpg", "burrellWarholBN1543.jpg")

# upload to filehandle service
files <- lapply(files, function (f) {
  cat(f, file = f)
  synUploadFileHandle(f, project)
  })

# get the filehandle ids
fileHandleIds <- lapply(files, function(f) f$id)
newData["covers"] <- fileHandleIds
## Warning in `[<-.data.frame`(`*tmp*`, "covers", value = list("169920500", :
## provided 4 variables to replace 1 variables

newTable <- synStore(Table(newSchema$properties$id, newData))
```

To download attached files in a table:

``` r
result <- synTableQuery(sprintf("select * from %s", newTable$tableId))
data <- synDownloadTableColumns(result, columns = list("covers"))
```

## Set Annotations

A table schema is a Synapse entity. Annotations on table works the same
way as annotations on any other entity types.

To set annotation on table, use synStore() on the schema. Note,
`forceVersion=False` will not re version the file and setting the
annotations this way will wipe the old versions.

``` r
schema <- synGet(tableId)
schema$annotations = list(temp = "test")
synStore(schema, forceVersion = FALSE)
## Schema(id='syn74360936', isLatestVersion=True, createdOn='2026-04-06T17:33:25.372Z', modifiedBy='3324230', createdBy='3324230', columnIds=['120266', '85771', '120129', '120130', '120267', '120132', '120268', '120269'], etag='d5ca2f51-aae7-4043-8178-99c802a639bf', concreteType='org.sagebionetworks.repo.model.table.TableEntity', name='My Favorite Genes', versionLabel='in progress', temp=['test'], columns_to_store=[], versionComment='in progress', parentId='syn74360935', modifiedOn='2026-04-06T17:34:32.997Z', versionNumber=1)
```

To view annotations on table, retrieve the schema:

``` r
schema <- synGet(tableId)
schema$annotations
## {
##   "temp": [
##     "test"
##   ]
## }
```

Please visit [synapser
vignettes](https://r-docs.synapse.org/articles/synapser.html#annotating-synapse-entities)
to read more about annotations.

## Deleting Rows

Query for the rows you want to delete and call synDelete on the results:

``` r
results <- synTableQuery(sprintf("select * from %s where Chromosome='2'", tableId))
deleted <- synDelete(results)
```

## Deleting Table

Deleting the schema deletes the whole table and all rows:

``` r
synDelete(schema)
## NULL
```

## Queries

The query language is quite similar to SQL select statements, except
that joins are not supported. The documentation for the Synapse API has
lots of [query
examples](http://docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.md).

For more details see the native reference documentation, e.g.:

``` r
?Schema
?Column
?Row
?Table
```

``` r
synDelete(project)
## NULL
fileHandleIds <- lapply(files, function(f) file.remove(f$fileName))
```

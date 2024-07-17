## ----collapse=TRUE------------------------------------------------------------
library(synapser)
synLogin()
# Create a new project
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)

## ----collapse=TRUE------------------------------------------------------------
genes <- data.frame(
  Name = c("foo", "arg", "zap", "bah", "bnk", "xyz"),
  Chromosome = c(1, 2, 2, 1, 1, 1),
  Start = c(12345, 20001, 30033, 40444, 51234, 61234),
  End = c(126000, 20200, 30999, 41444, 54567, 68686),
  Strand = c("+", "+", "-", "-", "+", "+"),
  TranscriptionFactor = c(F, F, F, F, T, F),
  Time = as.POSIXlt(c("2017-02-14 11:23:11.024", "1970-01-01 00:00:00.000", "2018-10-01 00:00:00.000", "2020-11-03 04:59:59.999", "2011-12-16 06:23:11.139", "1999-03-18 21:03:33.044"), tz = "UTC", format = "%Y-%m-%d %H:%M:%OS"))

## ----collapse=TRUE------------------------------------------------------------
table <- synBuildTable("My Favorite Genes", project, genes)
table$schema

## ----collapse=TRUE------------------------------------------------------------
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

## ----collapse=TRUE------------------------------------------------------------
table <- synStore(table)
tableId <- table$tableId

## ----collapse=TRUE------------------------------------------------------------
results <- synTableQuery(sprintf('select * from %s where Chromosome=1 and Start < 41000 and "End" > 20000', tableId), resultsAs = 'csv')

## ----collapse=TRUE, eval=FALSE------------------------------------------------
#  results$filepath


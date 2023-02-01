\name{synBuildTable}
\alias{synBuildTable}
\docType{methods}
\title{
synBuildTable
}
\description{
Build a Table object
}
\usage{
synBuildTable(name, parent, values)
}
\arguments{
\item{name}{ the name for the Table Schema object\cr
}
\item{parent}{ the project in Synapse to which this table belongs\cr
}
\item{values}{ an object that holds the content of the tables\cr
  - a string holding the path to a CSV file\cr
  - a data.frame}
}
\value{
 a Table object suitable for storing
}
\examples{
\dontrun{
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
}
}




\name{Table}
\alias{Table}
\docType{methods}
\title{
Table
}
\description{
Combine a table schema and a set of values into some type of Table object
depending on what type of values are given.
}
\usage{
Table(schema, values)
}
\arguments{
\item{schema}{ a table Schema object, or the Synapse ID of a Table\cr
}
\item{values}{ an object that holds the content of the tables:\cr
  - a data frame\cr
  - a RowSet\cr
  - a string holding the path to a CSV file\cr
  }
}
\value{
 a Table object suitable for storing
}
\seealso{
\href{https://r-docs.synapse.org/articles/tables.html}{Tables Vignette}
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
%
% Verified that the following works on 2018Jan23.
%

\examples{
\dontrun{
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
}
}



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
\item{schema}{ a table Schema object\cr
}
\item{values}{ an object that holds the content of the tables:\cr
  - a data frame\cr
  - a RowSet\cr
  - a string holding the path to a CSV file\cr
  }
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a Table object suitable for storing
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%
% Verified that the following works on 2018Jan23.
%
\dontrun{
# Define the table's column schema
cols <- list(
    Column(name='Name', columnType='STRING', maximumSize=20),
    Column(name='Chromosome', columnType='STRING', maximumSize=20),
    Column(name='Start', columnType='INTEGER'),
    Column(name='End', columnType='INTEGER'),
    Column(name='Strand', columnType='STRING', enumValues=list('+', '-'), maximumSize=1),
    Column(name='TranscriptionFactor', columnType='BOOLEAN'))
# create the schema
schema <- Schema(name='My Favorite Genes', columns=cols, parent=project)
# define the data to be added to the table
genes<-data.frame(
	Name=c("foo", "arg", "zap", "bah", "bnk", "xyz"), 
	Chromosome=c(1,2,2,1,1,1), 
	Start=c(12345,20001,30033,40444,51234,61234),
	End=c(126000,20200,30999,41444,54567,68686),
	Strand=c('+', '+', '-', '-', '+', '+'),
	TranscriptionFactor=c(F,F,F,F,T,F))
# now add the data to the table and save
table<-Table(schema, genes)
table<-synStore(table)
}
}




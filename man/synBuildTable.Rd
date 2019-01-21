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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{

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




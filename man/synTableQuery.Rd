\name{synTableQuery}
\alias{synTableQuery}
\docType{methods}
\title{
synTableQuery
}
\description{
Query a Synapse Table.
}
\usage{
synTableQuery(query, resultsAs=csv, offset=NULL, isConsistent=NULL, quoteCharacter=NULL, escapeCharacter=NULL, lineEnd=NULL, separator=NULL, header=NULL, includeRowIdAndRowVersion=NULL)
}
\arguments{
\item{query}{ query string in a \href{http://docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html}{SQL-like syntax}, for example\cr
    "SELECT * from syn12345"\cr
    \cr
}
\item{resultsAs}{ select whether results are returned as a CSV file ("csv") or incrementally
                  downloaded as sets of rows ("rowset").}
\item{offset}{optional named parameter:  don't return the first n rows, defaults to 0
}
\item{isConsistent}{optional named parameter:  defaults to TRUE. If set to FALSE, return results based on current
                     state of the index without waiting for pending writes to complete.
                     It is rare to modify the default value.}
\item{quoteCharacter}{optional named parameter:  default double quote\cr
}
\item{escapeCharacter}{optional named parameter:  default backslash\cr
}
\item{lineEnd}{optional named parameter:  defaults to os.linesep\cr
}
\item{separator}{optional named parameter:  defaults to comma\cr
}
\item{header}{optional named parameter:  TRUE by default\cr
}
\item{includeRowIdAndRowVersion}{optional named parameter:  TRUE by default}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A Table object that serves as a wrapper around a CSV file (or generator over
         Row objects if resultsAs="rowset").
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
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
tableId<-"syn1234567"
results <- synTableQuery(sprintf("select * from \%s where Chromosome='1' and Start < 41000 and End > 20000", tableId))
results$filepath
as.data.frame(results)
}
}




%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
synTableQuery(query, resultsAs=csv, offset=NULL, isConsistent=NULL, quoteCharacter=NULL, escapeCharacter=NULL, lineEnd=NULL, separator=NULL, header=NULL, includeRowIdAndRowVersion=NULL, downloadLocation=NULL)
}
\arguments{
\item{query}{ query string in a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html}{SQL-like syntax         }, for example\cr
    "SELECT * from syn12345"}
\item{resultsAs}{   select whether results are returned as a CSV file ("csv") or incrementally downloaded as\cr
                    sets of rows ("rowset").}
\item{offset}{optional named parameter:           don't return the first n rows, defaults to None\cr
}
\item{isConsistent}{optional named parameter:     (**DEPRECATED**)}
\item{quoteCharacter}{optional named parameter:    default double quote\cr
}
\item{escapeCharacter}{optional named parameter:   default backslash\cr
}
\item{lineEnd}{optional named parameter:           defaults to os.linesep\cr
}
\item{separator}{optional named parameter:         defaults to comma\cr
}
\item{header}{optional named parameter:            True by default\cr
}
\item{includeRowIdAndRowVersion}{optional named parameter:  True by default\cr
}
\item{downloadLocation}{optional named parameter:  directory path to download the CSV file to}
}
\value{
 A Table object that serves as a wrapper around a CSV file (or generator over Row objects if
         resultsAs="rowset").
}



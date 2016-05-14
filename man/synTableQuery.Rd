\name{synTableQuery}
\alias{synTableQuery}
\docType{methods}
\title{
synTableQuery
}
\description{}
\usage{
	synTableQuery(resultsAs=csv, ...)
}
\arguments{
\item{resultsAs=csv}{}
\item{...}{Extra parameters, passed by argument name.}
}
\details{
Query a Synapse Table.

:param query: query string in a `SQL-like syntax <http://rest.synapse.org/org/sagebionetworks/repo/web/controller/TableExamples.html>`_::

    SELECT * from syn12345

:param resultsAs: select whether results are returned as a CSV file ("csv") or incrementally
                  downloaded as sets of rows ("rowset").

:return: A Table object that serves as a wrapper around a CSV file (or generator over
         Row objects if resultsAs="rowset").

You can receive query results either as a generator over rows or as a CSV file. For
smallish tables, either method will work equally well. Use of a "rowset" generator allows
rows to be processed one at a time and processing may be stopped before downloading
the entire table.

Optional keyword arguments differ for the two return types. For the "rowset" option,

:param  limit: specify the maximum number of rows to be returned, defaults to None
:param offset: don't return the first n rows, defaults to None
:param isConsistent: defaults to True. If set to False, return results based on current
                     state of the index without waiting for pending writes to complete.
                     Only use this if you know what you're doing.

For CSV files, there are several parameters to control the format of the resulting file:

:param quoteCharacter: default double quote
:param escapeCharacter: default backslash
:param lineEnd: defaults to os.linesep
:param separator: defaults to comma
:param header: True by default
:param includeRowIdAndRowVersion: True by default

NOTE: When performing queries on frequently updated tables,
      the table can be inaccessible for a period leading to a
      timeout of the query.  Since the results are guaranteed
      to eventually be returned you can change the max timeout
      by setting the table_query_timeout variable of the Synapse
      object:

      syn.table_query_timeout = 300  #Sets the max timeout to 5 minutes.
}


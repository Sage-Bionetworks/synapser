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

You can receive query results either as a generator over rows or as a CSV file. For smallish tables, either
method will work equally well. Use of a "rowset" generator allows rows to be processed one at a time and
processing may be stopped before downloading the entire table.

Optional keyword arguments differ for the two return types of `rowset` or `csv`

Arguments:
    query: Query string in a [SQL-like syntax](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html), for example: `"SELECT * from syn12345"`
    resultsAs: select whether results are returned as a CSV file ("csv") or incrementally downloaded as sets of rows ("rowset")
    limit: (rowset only) Specify the maximum number of rows to be returned, defaults to None
    offset: (rowset only) Don't return the first n rows, defaults to None
    quoteCharacter: (csv only) default double quote
    escapeCharacter: (csv only) default backslash
    lineEnd: (csv only) defaults to os.linesep
    separator: (csv only) defaults to comma
    header: (csv only) True by default
    includeRowIdAndRowVersion: (csv only) True by default
    downloadLocation: (csv only) directory path to download the CSV file to

Returns:
    A [TableQueryResult][synapseclient.table.TableQueryResult] or [CsvFileTable][synapseclient.table.CsvFileTable] object

NOTE:
    When performing queries on frequently updated tables, the table can be inaccessible for a period leading
      to a timeout of the query.  Since the results are guaranteed to eventually be returned you can change the
      max timeout by setting the table_query_timeout variable of the Synapse object:

          # Sets the max timeout to 5 minutes.
          syn.table_query_timeout = 300
}
\usage{
synTableQuery(query, resultsAs=csv)
}
\arguments{
\item{query}{}
\item{resultsAs}{}
}
\value{

}



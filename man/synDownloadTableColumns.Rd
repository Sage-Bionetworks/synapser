\name{synDownloadTableColumns}
\alias{synDownloadTableColumns}
\docType{methods}
\title{
synDownloadTableColumns
}
\description{}
\usage{
	synDownloadTableColumns()
}
\arguments{

}
\details{
Bulk download of table-associated files.

:param table:            table query result
:param column:           a list of column names as strings

:returns: a dictionary from file handle ID to path in the local file system.

For example, consider a Synapse table whose ID is "syn12345" with two columns of type File
named 'foo' and 'bar'. The associated files are JSON encoded, so we might retrieve the
files from Synapse and load for the second 100 of those rows as shown here::

    import json

    results = syn.tableQuery('SELECT * FROM syn12345 LIMIT 100 OFFSET 100')
    file_map = syn.downloadTableColumns(results, ['foo', 'bar'])

    for file_handle_id, path in file_map.items():
        with open(path) as f:
            data[file_handle_id] = f.read()
}


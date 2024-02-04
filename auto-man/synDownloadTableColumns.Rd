%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDownloadTableColumns}
\alias{synDownloadTableColumns}
\docType{methods}
\title{
synDownloadTableColumns
}
\description{
Bulk download of table-associated files.

Arguments:
    table: Table query result
    columns: A list of column names as strings
    downloadLocation: Directory into which to download the files

Returns:
    A dictionary from file handle ID to path in the local file system.

For example, consider a Synapse table whose ID is "syn12345" with two columns of type FILEHANDLEID named 'foo'
and 'bar'. The associated files are JSON encoded, so we might retrieve the files from Synapse and load for the
second 100 of those rows as shown here:

    import json

    results = syn.tableQuery('SELECT * FROM syn12345 LIMIT 100 OFFSET 100')
    file_map = syn.downloadTableColumns(results, ['foo', 'bar'])

    for file_handle_id, path in file_map.items():
        with open(path) as f:
            data[file_handle_id] = f.read()
}
\usage{
synDownloadTableColumns(table, columns, downloadLocation=NULL)
}
\arguments{
\item{table}{}
\item{columns}{}
\item{downloadLocation}{}
}
\value{

}



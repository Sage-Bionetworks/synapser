\name{synDownloadTableFile}
\alias{synDownloadTableFile}
\docType{methods}
\title{
synDownloadTableFile
}
\description{}
\usage{
	synDownloadTableFile(table=NULL, table=NULL, table=NULL, table=keep.both, downloadLocation=NULL, rowId=NULL, versionNumber=NULL, rowIdAndVersion=NULL, ifcollision=keep.both)
}
\arguments{
\item{table=NULL}{}
\item{table=NULL}{}
\item{table=NULL}{}
\item{table=keep.both}{}
\item{downloadLocation=NULL}{}
\item{rowId=NULL}{}
\item{versionNumber=NULL}{}
\item{rowIdAndVersion=NULL}{}
\item{ifcollision=keep.both}{}
}
\details{
Downloads a file associated with a row in a Synapse table.

:param table:            schema object, table query result or synapse ID
:param rowId:            row number that holds the file handle
:param versionNumber:    version number of the row that holds the file handle
:param rowIdAndVersion:  row number and version in one string, "101_2" for version 2 of row 101
:param column:           a Column object, the ID of a column or its name
:param downloadLocation: location in local file system to download the file
:param ifcollision:      Determines how to handle file collisions.
                         May be "overwrite.local", "keep.local", or "keep.both".
                         Defaults to "keep.both".

:returns: a dictionary with 'path'.

Example::

    file_info = syn.downloadTableFile(table, rowId=1, versionNumber=1, column="cover_art", downloadLocation=".")
    print(file_info['path'])
}


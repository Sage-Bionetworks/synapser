%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreateSnapshotVersion}
\alias{synCreateSnapshotVersion}
\docType{methods}
\title{
synCreateSnapshotVersion
}
\description{
Create a new Table Version, new View version, or new Dataset version.

Arguments:
    table: The schema of the Table/View, or its ID.
    comment: Optional snapshot comment.
    label: Optional snapshot label.
    activity: Optional activity ID applied to snapshot version.
    wait: True if this method should return the snapshot version after waiting for any necessary
            asynchronous table updates to complete. If False this method will return
            as soon as any updates are initiated.

Returns:
    The snapshot version number if wait=True, None if wait=False
}
\usage{
synCreateSnapshotVersion(table, comment=NULL, label=NULL, activity=NULL, wait=TRUE)
}
\arguments{
\item{table}{}
\item{comment}{}
\item{label}{}
\item{activity}{}
\item{wait}{}
}
\value{

}



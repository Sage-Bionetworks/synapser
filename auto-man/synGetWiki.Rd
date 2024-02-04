%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetWiki}
\alias{synGetWiki}
\docType{methods}
\title{
synGetWiki
}
\description{
Get a [synapseclient.wiki.Wiki][] object from Synapse. Uses wiki2 API which supports versioning.

Arguments:
    owner: The entity to which the Wiki is attached
    subpageId: The id of the specific sub-page or None to get the root Wiki page
    version: The version of the page to retrieve or None to retrieve the latest

Returns:
    A [synapseclient.wiki.Wiki][] object
}
\usage{
synGetWiki(owner, subpageId=NULL, version=NULL)
}
\arguments{
\item{owner}{}
\item{subpageId}{}
\item{version}{}
}
\value{

}



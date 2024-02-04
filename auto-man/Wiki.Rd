%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Wiki}
\alias{Wiki}
\docType{methods}
\title{
Constructor for objects of type Wiki
}
\description{
Represents a wiki page in Synapse with content specified in markdown.

Arguments:
    title: Title of the Wiki
    owner: Parent Entity that the Wiki will belong to
    markdown: Content of the Wiki (cannot be defined if markdownFile is defined)
    markdownFile: Path to file which contains the Content of Wiki (cannot be defined if markdown is defined)
    attachments: List of paths to files to attach
    fileHandles: List of file handle IDs representing files to be attached
    parentWikiId: (optional) For sub-pages, specify parent wiki page
}
\usage{
Wiki()
}
\arguments{

}
\value{
An object of type Wiki
}



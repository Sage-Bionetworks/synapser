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
}
\usage{
Wiki(title=NULL, owner=NULL, markdown=NULL, markdownFile=NULL, attachments=NULL, fileHandles=NULL, parentWikiId=NULL)
}
\arguments{
\item{title}{optional named parameter:            Title of the Wiki\cr
}
\item{owner}{optional named parameter:            Parent Entity that the Wiki will belong to\cr
}
\item{markdown}{optional named parameter:         Content of the Wiki (cannot be defined if markdownFile is defined)\cr
}
\item{markdownFile}{optional named parameter:     Path to file which contains the Content of Wiki (cannot be defined if markdown is defined)\cr
}
\item{attachments}{optional named parameter:      List of paths to files to attach\cr
}
\item{fileHandles}{optional named parameter:      List of file handle IDs representing files to be attached\cr
}
\item{parentWikiId}{optional named parameter:     (optional) For sub-pages, specify parent wiki page}
}
\value{
An object of type Wiki
}



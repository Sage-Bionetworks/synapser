%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Wiki-class}
\alias{Wiki-class}
\docType{class}
\title{
Wiki
}
\format{An R6 class object.}
\description{
Represents a wiki page in Synapse with content specified in markdown.
}
\section{Methods}{
\itemize{
\item \code{Wiki(title=NULL, owner=NULL, markdown=NULL, markdownFile=NULL, attachments=NULL, fileHandles=NULL, parentWikiId=NULL)}: Constructor for \code{\link{Wiki}}
\item \code{json()}: Returns the JSON representation of the Wiki object.
\item \code{update_markdown(markdown=NULL, markdown_file=NULL)}: Updates the wiki's markdown. Specify only one of markdown or markdown_file
}
}


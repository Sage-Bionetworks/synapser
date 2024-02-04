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

Arguments:
    title: Title of the Wiki
    owner: Parent Entity that the Wiki will belong to
    markdown: Content of the Wiki (cannot be defined if markdownFile is defined)
    markdownFile: Path to file which contains the Content of Wiki (cannot be defined if markdown is defined)
    attachments: List of paths to files to attach
    fileHandles: List of file handle IDs representing files to be attached
    parentWikiId: (optional) For sub-pages, specify parent wiki page
}
\section{Methods}{
\itemize{
\item \code{Wiki()}: Constructor for \code{\link{Wiki}}
\item \code{json()}: Returns the JSON representation of the Wiki object.
\item \code{update_markdown(markdown=NULL, markdown_file=NULL)}: Updates the wiki's markdown. Specify only one of markdown or markdown_file\cr
\cr
Arguments:\cr
    markdown: text that will become the markdown\cr
    markdown_file: path to a file. Its contents will be the markdown
}
}


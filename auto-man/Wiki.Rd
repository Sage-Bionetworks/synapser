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
\item{title}{optional named parameter:        Title of the Wiki\cr
}
\item{owner}{optional named parameter:        Parent Entity that the Wiki will belong to\cr
}
\item{markdown}{optional named parameter:     Content of the Wiki (cannot be defined if markdownFile is defined)\cr
}
\item{markdownFile}{optional named parameter:  Path to file which contains the Content of Wiki (cannot be defined if markdown is defined)\cr
}
\item{attachments}{optional named parameter:  List of paths to files to attach\cr
}
\item{fileHandles}{optional named parameter:  List of file handle IDs representing files to be attached\cr
}
\item{parentWikiId}{optional named parameter:  (optional) For subpages, specify parent wiki page}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Wiki
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{

}




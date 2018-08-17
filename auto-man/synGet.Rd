%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{
Gets a Synapse entity from the repository service.
}
\usage{
synGet(entity, version=NULL, downloadFile=NULL, downloadLocation=NULL, followLink=NULL, ifcollision=NULL, limitSearch=NULL)
}
\arguments{
\item{entity}{           A Synapse ID, a Synapse Entity object, a plain dictionary in which 'id' maps to a\cr
                         Synapse ID or a local file that is stored in Synapse (found by the file MD5)\cr
}
\item{version}{optional named parameter:           The specific version to get.\cr
                         Defaults to the most recent version.\cr
}
\item{downloadFile}{optional named parameter:      Whether associated files(s) should be downloaded.\cr
                         Defaults to True\cr
}
\item{downloadLocation}{optional named parameter:  Directory where to download the Synapse File Entity.\cr
                         Defaults to the local cache.\cr
}
\item{followLink}{optional named parameter:        Whether the link returns the target Entity.\cr
                         Defaults to False\cr
}
\item{ifcollision}{optional named parameter:       Determines how to handle file collisions.\cr
                         May be "overwrite.local", "keep.local", or "keep.both".\cr
                         Defaults to "keep.both".\cr
}
\item{limitSearch}{optional named parameter:       a Synanpse ID used to limit the search in Synapse if entity is specified as a local\cr
                         file.  That is, if the file is stored in multiple locations in Synapse only the ones\cr
                         in the specified folder/project will be returned.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A new Synapse Entity object of the appropriate type
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
%\dontrun{
%    # download file into cache
%    entity = syn.get('syn1906479')
%    print(entity.name)
%    print(entity.path)
%}
}




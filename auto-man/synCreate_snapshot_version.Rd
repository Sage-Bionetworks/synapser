%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreate_snapshot_version}
\alias{synCreate_snapshot_version}
\docType{methods}
\title{
synCreate_snapshot_version
}
\description{
Create a new Table Version or a new View version.
}
\usage{
synCreate_snapshot_version(table, comment=NULL, label=NULL, activity=NULL, wait=TRUE)
}
\arguments{
\item{table}{  The schema of the Table/View, or its ID.\cr
}
\item{comment}{  Optional snapshot comment.\cr
}
\item{label}{  Optional snapshot label.\cr
}
\item{activity}{  Optional activity ID applied to snapshot version.\cr
}
\item{wait}{ True if this method should return the snapshot version after waiting for any necessary\cr
                asynchronous table updates to complete. If False this method will return return\cr
                as soon as any updates are initiated.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 the snapshot version number if wait=True, None if wait=False
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



